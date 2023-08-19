import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/shimmer_loading.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/cal_chat_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/cancel_and_support_center.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/ordered_product_list.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/payment_info.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/seller_section.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/shipping_info.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/amount_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final bool isNotification;
  final int orderId;
  final String? orderType;
  final double? extraDiscount;
  final String? extraDiscountType;
  OrderDetailsScreen(
      {required this.orderId,
      required this.orderType,
      this.extraDiscount,
      this.extraDiscountType,
      this.isNotification = false});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  void _loadData(BuildContext context) async {
    await Provider.of<OrderProvider>(context, listen: false)
        .initTrackingInfo(widget.orderId.toString(), context);
    await Provider.of<OrderProvider>(context, listen: false)
        .getOrderFromOrderId(widget.orderId.toString(), context);
    await Provider.of<OrderProvider>(context, listen: false).getOrderDetails(
      widget.orderId.toString(),
      context,
      Provider.of<LocalizationProvider>(context, listen: false)
          .locale
          .countryCode!,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData(context);
    Provider.of<OrderProvider>(context, listen: false).digitalOnly(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.isNotification
            ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => DashBoardScreen()))
            : Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        appBar: AppBar(
            iconTheme:
                IconThemeData(color: ColorResources.getTextTitle(context)),
            backgroundColor: Theme.of(context).cardColor,
            leading: InkWell(
                onTap: () {
                  widget.isNotification
                      ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => DashBoardScreen()))
                      : Navigator.pop(context);
                },
                child: Icon(Icons.keyboard_backspace)),
            title: Text(
              getTranslated('ORDER_DETAILS', context)!,
              style: robotoRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<OrderProvider>(
                builder: (context, order, child) {
                  double _order = 0;
                  double _discount = 0;
                  double eeDiscount = 0;
                  double _tax = 0;

                  if (order.orderDetails != null) {
                    order.orderDetails.forEach((orderDetails) {
                      if (orderDetails.productDetails.productType != null &&
                          orderDetails.productDetails.productType !=
                              "physical") {
                        order.digitalOnly(false, isUpdate: false);
                      }
                    });

                    order.orderDetails.forEach((orderDetails) {
                      print('---> ${orderDetails.taxModel}');
                      _order = _order + (orderDetails.price * orderDetails.qty);
                      _discount = _discount + orderDetails.discount;
                      _tax = _tax + orderDetails.tax;
                    });

                    if (widget.orderType == 'POS') {
                      if (widget.extraDiscountType == 'percent') {
                        eeDiscount = _order * (widget.extraDiscount! / 100);
                      } else {
                        eeDiscount = widget.extraDiscount!;
                      }
                    }
                  }

                  return order.orderDetails != null
                      ? ListView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          children: [
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: Dimensions.PADDING_SIZE_DEFAULT,
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: getTranslated(
                                                'ORDER_ID', context),
                                            style: titilliumRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_LARGE,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color,
                                            )),
                                        TextSpan(
                                            text: order.trackingModel.id
                                                .toString(),
                                            style: titilliumRegular.copyWith(
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE,
                                                color:
                                                    ColorResources.getPrimary(
                                                        context))),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Text(
                                      DateConverter.localDateToIsoStringAMPM(
                                          DateTime.parse(
                                              order.trackingModel.createdAt)),
                                      style: titilliumRegular.copyWith(
                                          color:
                                              ColorResources.getHint(context),
                                          fontSize:
                                              Dimensions.FONT_SIZE_SMALL)),
                                ],
                              ),
                            ),

                            Container(
                              padding:
                                  EdgeInsets.all(Dimensions.MARGIN_SIZE_SMALL),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor),
                              child: Column(
                                children: [
                                  widget.orderType == 'POS'
                                      ? Text(
                                          getTranslated('pos_order', context)!)
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              order.onlyDigital!
                                                  ? Text(
                                                      '${getTranslated('SHIPPING_TO', context)} : ',
                                                      style: titilliumRegular
                                                          .copyWith(
                                                              fontSize: Dimensions
                                                                  .FONT_SIZE_DEFAULT))
                                                  : SizedBox(),
                                              order.onlyDigital!
                                                  ? Expanded(
                                                      child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 1),
                                                      child: Text(
                                                          ' ${order.orderModel != null && order.orderModel.shippingAddressData != null ? order.orderModel.shippingAddressData.address : ''}',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: titilliumRegular
                                                              .copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .FONT_SIZE_SMALL)),
                                                    ))
                                                  : SizedBox(),
                                            ]),
                                  SizedBox(
                                      height: order.onlyDigital!
                                          ? Dimensions.PADDING_SIZE_LARGE
                                          : 0),
                                  order.orderModel != null &&
                                          order.orderModel.billingAddressData !=
                                              null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${getTranslated('billing_address', context)} :',
                                                style: titilliumRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_DEFAULT)),
                                            Expanded(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1),
                                              child: Text(
                                                  ' ${order.orderModel.billingAddressData != null ? order.orderModel.billingAddressData.address : ''}',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_SMALL)),
                                            )),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),

                            order.orderModel != null &&
                                    order.orderModel.orderNote != null
                                ? Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.MARGIN_SIZE_SMALL),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text:
                                                  '${getTranslated('order_note', context)} : ',
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_LARGE,
                                                  color: ColorResources
                                                      .getReviewRattingColor(
                                                          context))),
                                          TextSpan(
                                              text:
                                                  '${order.orderModel.orderNote != null ? order.orderModel.orderNote ?? '' : ""}',
                                              style: titilliumRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_SMALL)),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                  vertical: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Text(
                                  getTranslated('ORDERED_PRODUCT', context)!,
                                  style: titilliumSemiBold.copyWith()),
                            ),

                            SellerSection(order: order),

                            OrderProductList(
                                order: order, orderType: widget.orderType),

                            SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                            // Amounts
                            Container(
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              color: Theme.of(context).highlightColor,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      child: TitleRow(
                                          title:
                                              getTranslated('TOTAL', context)),
                                    ),
                                    AmountWidget(
                                        title: getTranslated('ORDER', context)!,
                                        amount: PriceConverter.convertPrice(
                                            context, _order)),
                                    widget.orderType == "POS"
                                        ? SizedBox()
                                        : AmountWidget(
                                            title: getTranslated(
                                                'SHIPPING_FEE', context)!,
                                            amount: PriceConverter.convertPrice(
                                                context,
                                                order.trackingModel
                                                    .shippingCost)),
                                    AmountWidget(
                                        title:
                                            getTranslated('DISCOUNT', context)!,
                                        amount: PriceConverter.convertPrice(
                                            context, _discount)),
                                    widget.orderType == "POS"
                                        ? AmountWidget(
                                            title: getTranslated(
                                                'EXTRA_DISCOUNT', context)!,
                                            amount: PriceConverter.convertPrice(
                                                context, eeDiscount))
                                        : SizedBox(),
                                    AmountWidget(
                                      title: getTranslated(
                                          'coupon_voucher', context)!,
                                      amount: PriceConverter.convertPrice(
                                          context,
                                          order.trackingModel.discountAmount),
                                    ),
                                    AmountWidget(
                                        title: getTranslated('TAX', context)!,
                                        amount: PriceConverter.convertPrice(
                                            context, _tax)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      child: Divider(
                                          height: 2,
                                          color:
                                              ColorResources.HINT_TEXT_COLOR),
                                    ),
                                    AmountWidget(
                                      title: getTranslated(
                                          'TOTAL_PAYABLE', context)!,
                                      amount: PriceConverter.convertPrice(
                                          context,
                                          (_order +
                                              order.trackingModel.shippingCost -
                                              eeDiscount -
                                              order.trackingModel
                                                  .discountAmount -
                                              _discount +
                                              _tax)),
                                    ),
                                  ]),
                            ),

                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),

                            order.trackingModel.deliveryMan != null
                                ? Container(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_DEFAULT),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).highlightColor,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 10)
                                      ],
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${getTranslated('shipping_info', context)}',
                                              style: robotoBold),
                                          SizedBox(
                                              height: Dimensions
                                                  .MARGIN_SIZE_EXTRA_SMALL),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${getTranslated('delivery_man', context)} : ',
                                                    style: titilliumRegular
                                                        .copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_SMALL)),
                                                Text(
                                                  (order.trackingModel
                                                              .deliveryMan !=
                                                          null)
                                                      ? '${order.trackingModel.deliveryMan.fName} ${order.trackingModel.deliveryMan.lName}'
                                                      : '',
                                                  style:
                                                      titilliumRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_SMALL),
                                                ),
                                              ]),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CallAndChatWidget(
                                                  orderProvider: order,
                                                  orderModel:
                                                      order.trackingModel),
                                            ],
                                          )
                                        ]),
                                  )
                                :
                                //third party
                                order.trackingModel.thirdPartyServiceName !=
                                        null
                                    ? ShippingInfo(order: order)
                                    : SizedBox(),

                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                            // Payment
                            PaymentInfo(order: order),

                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            CancelAndSupport(orderModel: order.orderModel),
                          ],
                        )
                      : LoadingPage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
