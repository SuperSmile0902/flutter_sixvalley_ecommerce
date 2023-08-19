import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/my_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String addressID;
  final String billingId;
  final String? orderNote;
  final String customerID;
  final String couponCode;
  final String? couponCodeAmount;
  final String? paymentMethod;

  PaymentScreen(
      {required this.addressID,
      required this.customerID,
      required this.couponCode,
      required this.billingId,
      this.orderNote,
      this.couponCodeAmount,
      this.paymentMethod});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedUrl;
  double value = 0.0;
  bool _isLoading = true;

  WebViewController? controllerGlobal;
  PullToRefreshController? pullToRefreshController;
  MyInAppBrowser? browser;

  @override
  void initState() {
    super.initState();
    selectedUrl =
        '${AppConstants.BASE_URL}/customer/payment-mobile?customer_id='
        '${widget.customerID}&address_id=${widget.addressID}&coupon_code='
        '${widget.couponCode}&coupon_discount=${widget.couponCodeAmount}&billing_address_id=${widget.billingId}&order_note=${widget.orderNote}&payment_method=${widget.paymentMethod}';
    print(selectedUrl);

    _initData();
  }

  void _initData() async {
    browser = MyInAppBrowser(context);
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      bool swInterceptAvailable =
          await AndroidWebViewFeature.isFeatureSupported(
              AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();
        await serviceWorkerController
            .setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            print(request);
            return null;
          },
        ));
      }
    }

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser!.webViewController.reload();
        } else if (Platform.isIOS) {
          browser!.webViewController.loadUrl(
              urlRequest:
                  URLRequest(url: await browser!.webViewController.getUrl()));
        }
      },
    );
    browser!.pullToRefreshController = pullToRefreshController;

    await browser!.openUrlRequest(
      urlRequest: URLRequest(url: Uri.parse(selectedUrl!)),
      options: InAppBrowserClassOptions(
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true, useOnLoadResource: true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
            title: Text(''), backgroundColor: Theme.of(context).cardColor),
        body: Center(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor)),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal!.canGoBack()) {
      controllerGlobal!.goBack();
      return Future.value(false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => DashBoardScreen()),
          (route) => false);
      showAnimatedDialog(
          context,
          MyDialog(
            icon: Icons.clear,
            title: getTranslated('payment_cancelled', context)!,
            description: getTranslated('your_payment_cancelled', context)!,
            isFailed: true,
          ),
          dismissible: false,
          isFlip: true);
      return Future.value(true);
    }
  }
}

class MyInAppBrowser extends InAppBrowser {
  final BuildContext context;

  MyInAppBrowser(
    this.context, {
    int? windowId,
    UnmodifiableListView<UserScript>? initialUserScripts,
  }) : super(windowId: windowId, initialUserScripts: initialUserScripts);

  bool _canRedirect = true;

  @override
  Future onBrowserCreated() async {
    print("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(url) async {
    print("\n\nStarted: $url\n\n");
    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    print("\n\nStopped: $url\n\n");
    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    print("Can't load [$url] Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
    print("Progress: $progress");
  }

  @override
  void onExit() {
    if (_canRedirect) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => DashBoardScreen()),
          (route) => false);

      showAnimatedDialog(
          context,
          MyDialog(
            icon: Icons.clear,
            title: getTranslated('payment_failed', context)!,
            description: getTranslated('your_payment_failed', context)!,
            isFailed: true,
          ),
          dismissible: false,
          isFlip: true);
    }

    print("\n\nBrowser closed!\n\n");
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      navigationAction) async {
    print("\n\nOverride ${navigationAction.request.url}\n\n");
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(response) {
    // print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    print("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }

  void _pageRedirect(String url) {
    if (_canRedirect) {
      bool _isSuccess =
          url.contains('success') && url.contains(AppConstants.BASE_URL);
      bool _isFailed =
          url.contains('fail') && url.contains(AppConstants.BASE_URL);
      bool _isCancel =
          url.contains('cancel') && url.contains(AppConstants.BASE_URL);
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
        close();
      }
      if (_isSuccess) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => DashBoardScreen()),
            (route) => false);

        showAnimatedDialog(
            context,
            MyDialog(
              icon: Icons.done,
              title: getTranslated('payment_done', context)!,
              description:
                  getTranslated('your_payment_successfully_done', context)!,
            ),
            dismissible: false,
            isFlip: true);
      } else if (_isFailed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => DashBoardScreen()),
            (route) => false);

        showAnimatedDialog(
            context,
            MyDialog(
              icon: Icons.clear,
              title: getTranslated('payment_failed', context)!,
              description: getTranslated('your_payment_failed', context)!,
              isFailed: true,
            ),
            dismissible: false,
            isFlip: true);
      } else if (_isCancel) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => DashBoardScreen()),
            (route) => false);

        showAnimatedDialog(
            context,
            MyDialog(
              icon: Icons.clear,
              title: getTranslated('payment_cancelled', context)!,
              description: getTranslated('your_payment_cancelled', context)!,
              isFailed: true,
            ),
            dismissible: false,
            isFlip: true);
      }
    }
  }
}
