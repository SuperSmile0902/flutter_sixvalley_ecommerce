import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/order_details.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/refunded_status_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/review_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/refund_request_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class OrderDetailsWidget extends StatefulWidget {
  final OrderDetailsModel? orderDetailsModel;
  final String? orderType;
  final String? paymentStatus;
  final Function? callback;
  OrderDetailsWidget(
      {this.orderDetailsModel,
      this.callback,
      this.orderType,
      this.paymentStatus});

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // setState((){ });
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        children: [
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  fit: BoxFit.scaleDown,
                  width: 60,
                  height: 60,
                  image:
                      '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}/${widget.orderDetailsModel!.productDetails?.thumbnail}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.scaleDown,
                      width: 50,
                      height: 50),
                ),
              ),
              SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.orderDetailsModel!.productDetails?.name ??
                                '',
                            style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                                color: Theme.of(context).hintColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Provider.of<OrderProvider>(context).orderTypeIndex ==
                                    1 &&
                                widget.orderType != "POS"
                            ? InkWell(
                                onTap: () {
                                  if (Provider.of<OrderProvider>(context,
                                              listen: false)
                                          .orderTypeIndex ==
                                      1) {
                                    Provider.of<ProductDetailsProvider>(context,
                                            listen: false)
                                        .removeData();
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => ReviewBottomSheet(
                                            productID: widget.orderDetailsModel!
                                                .productDetails.id
                                                .toString(),
                                            callback: widget.callback!));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: Dimensions.PADDING_SIZE_SMALL),
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                      horizontal:
                                          Dimensions.PADDING_SIZE_SMALL),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.PADDING_SIZE_DEFAULT),
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: Text(getTranslated('review', context)!,
                                      style: titilliumRegular.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_SMALL,
                                        color: ColorResources.getTextTitle(
                                            context),
                                      )),
                                ),
                              )
                            : SizedBox.shrink(),
                        Consumer<OrderProvider>(builder: (context, refund, _) {
                          return refund.orderTypeIndex == 1 &&
                                  widget.orderDetailsModel!.refundReq == 0 &&
                                  widget.orderType != "POS"
                              ? InkWell(
                                  onTap: () {
                                    Provider.of<ProductDetailsProvider>(context,
                                            listen: false)
                                        .removeData();
                                    refund
                                        .getRefundReqInfo(context,
                                            widget.orderDetailsModel!.id)
                                        .then((value) {
                                      if (value.response!.statusCode == 200) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RefundBottomSheet(
                                                        product: widget
                                                            .orderDetailsModel!
                                                            .productDetails,
                                                        orderDetailsId: widget
                                                            .orderDetailsModel!
                                                            .id)));
                                      }
                                    });
                                  },
                                  child: refund.isRefund!
                                      ? Center(
                                          child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .primaryColor))
                                      : Container(
                                          margin: EdgeInsets.only(
                                              left: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          padding: EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL,
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          decoration: BoxDecoration(
                                            color: ColorResources.getPrimary(
                                                context),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions
                                                    .PADDING_SIZE_DEFAULT),
                                          ),
                                          child: Text(
                                              getTranslated(
                                                  'refund_request', context)!,
                                              style: titilliumRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                              )),
                                        ),
                                )
                              : SizedBox();
                        }),
                        Consumer<OrderProvider>(builder: (context, refund, _) {
                          return (Provider.of<OrderProvider>(context)
                                          .orderTypeIndex ==
                                      1 &&
                                  widget.orderDetailsModel!.refundReq != 0 &&
                                  widget.orderType != "POS")
                              ? InkWell(
                                  onTap: () {
                                    Provider.of<ProductDetailsProvider>(context,
                                            listen: false)
                                        .removeData();
                                    refund
                                        .getRefundReqInfo(context,
                                            widget.orderDetailsModel!.id)
                                        .then((value) {
                                      if (value.response!.statusCode == 200) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (_) => RefundResultBottomSheet(
                                                        product: widget
                                                            .orderDetailsModel!
                                                            .productDetails,
                                                        orderDetailsId: widget
                                                            .orderDetailsModel!
                                                            .id,
                                                        orderDetailsModel: widget
                                                            .orderDetailsModel!)));
                                      }
                                    });
                                  },
                                  child: refund.isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .primaryColor))
                                      : Container(
                                          margin: EdgeInsets.only(
                                              left: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          padding: EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL,
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          decoration: BoxDecoration(
                                            color: ColorResources.getPrimary(
                                                context),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions
                                                    .PADDING_SIZE_DEFAULT),
                                          ),
                                          child: Text(
                                              getTranslated('refund_status_btn',
                                                  context)!,
                                              style: titilliumRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_SMALL,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                              )),
                                        ),
                                )
                              : SizedBox();
                        }),
                      ],
                    ),
                    SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          PriceConverter.convertPrice(
                              context, widget.orderDetailsModel!.price),
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.getPrimary(context)),
                        ),
                        Text('x${widget.orderDetailsModel!.qty}',
                            style: titilliumSemiBold.copyWith(
                                color: ColorResources.getPrimary(context))),
                        widget.orderDetailsModel!.discount > 0
                            ? Container(
                                height: 20,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: ColorResources.getPrimary(
                                            context))),
                                child: Text(
                                  PriceConverter.percentageCalculation(
                                      context,
                                      (widget.orderDetailsModel!.price *
                                          widget.orderDetailsModel!.qty),
                                      widget.orderDetailsModel!.discount,
                                      'amount'),
                                  style: titilliumRegular.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      color:
                                          ColorResources.getPrimary(context)),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          (widget.orderDetailsModel!.variant != null &&
                  widget.orderDetailsModel!.variant.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_SMALL,
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Row(children: [
                    SizedBox(width: 65),
                    Text('${getTranslated('variations', context)}: ',
                        style: titilliumSemiBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL)),
                    Flexible(
                        child: Text(widget.orderDetailsModel!.variant,
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: Theme.of(context).disabledColor,
                            ))),
                  ]),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.only(left: 75, right: 75, top: 5),
            child: Row(
              children: [
                Text(
                    '${getTranslated('tax', context)} ${widget.orderDetailsModel!.productDetails.taxModel}(${widget.orderDetailsModel!.tax})'),
              ],
            ),
          ),
          SizedBox(
              height: (widget.orderDetailsModel!.productDetails != null &&
                      widget.orderDetailsModel!.productDetails?.productType ==
                          'digital' &&
                      widget.paymentStatus == 'paid')
                  ? Dimensions.PADDING_SIZE_EXTRA_LARGE
                  : 0),
          widget.orderDetailsModel!.productDetails?.productType == 'digital' &&
                  widget.paymentStatus == 'paid'
              ? Consumer<OrderProvider>(builder: (context, orderProvider, _) {
                  return InkWell(
                    onTap: () async {
                      if (widget.orderDetailsModel!.productDetails
                                  .digitalProductType ==
                              'ready_after_sell' &&
                          widget.orderDetailsModel!.digitalFileAfterSell ==
                              null) {
                        Fluttertoast.showToast(
                            msg: getTranslated(
                                'product_not_uploaded_yet', context)!,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT);
                      } else {
                        print(
                            'ios url click=====>${'${Provider.of<SplashProvider>(context, listen: false).baseUrls.digitalProductUrl}/${widget.orderDetailsModel!.digitalFileAfterSell}'}');
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          Directory? directory =
                              Directory('/storage/emulated/0/Download');
                          if (!await directory.exists())
                            directory = Platform.isAndroid
                                ? await getExternalStorageDirectory()
                                : await getApplicationSupportDirectory();
                          orderProvider.downloadFile(
                              widget.orderDetailsModel!.productDetails
                                          .digitalProductType ==
                                      'ready_after_sell'
                                  ? '${Provider.of<SplashProvider>(context, listen: false).baseUrls.digitalProductUrl}/${widget.orderDetailsModel!.digitalFileAfterSell}'
                                  : '${Provider.of<SplashProvider>(context, listen: false).baseUrls.digitalProductUrl}/${widget.orderDetailsModel!.productDetails.digitalFileReady}',
                              directory!.path);
                        } else {
                          print('=====permission denied=====');
                        }
                      }
                    },
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.only(left: 5),
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.FONT_SIZE_EXTRA_SMALL),
                          color: Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${getTranslated('download', context)}',
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL,
                                color: Theme.of(context).cardColor),
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          Container(
                              width: Dimensions.ICON_SIZE_DEFAULT,
                              child: Image.asset(
                                Images.file_download,
                                color: Theme.of(context).cardColor,
                              ))
                        ],
                      )),
                    ),
                  );
                })
              : SizedBox(),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
        ],
      ),
    );
  }
}
