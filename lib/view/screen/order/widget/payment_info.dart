import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/payment/payment_screen.dart';
import 'package:provider/provider.dart';

class PaymentInfo extends StatelessWidget {
  final OrderProvider? order;
  const PaymentInfo({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(getTranslated('PAYMENT', context)!, style: robotoBold),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(getTranslated('PAYMENT_STATUS', context)!,
                style: titilliumRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_SMALL)),
            Text(
              (order!.trackingModel.paymentStatus != null &&
                      order!.trackingModel.paymentStatus.isNotEmpty)
                  ? order!.trackingModel.paymentStatus
                  : 'Digital Payment',
              style: titilliumRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL),
            ),
          ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(getTranslated('PAYMENT_PLATFORM', context)!,
              style: titilliumRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL)),
          Text(
              order!.trackingModel.paymentMethod != null
                  ? getTranslated(order!.trackingModel.paymentMethod, context)!
                  : '',
              style: titilliumBold.copyWith(
                color: Theme.of(context).primaryColor,
              )),
        ]),
      ]),
    );
  }
}
