import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

class ShippingInfo extends StatelessWidget {
  final OrderProvider? order;
  const ShippingInfo({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('${getTranslated('shipping_info', context)}', style: robotoBold),
        SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${getTranslated('delivery_service_name', context)} : ',
              style: titilliumRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL)),
          Text(
            (order!.trackingModel.thirdPartyServiceName != null &&
                    order!.trackingModel.thirdPartyServiceName.isNotEmpty)
                ? order!.trackingModel.thirdPartyServiceName
                : '',
            style:
                titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
          ),
        ]),
        SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${getTranslated('tracking_id', context)} : ',
              style: titilliumRegular.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL)),
          Text(
              order!.trackingModel.thirdPartyTrackingId != null
                  ? order!.trackingModel.thirdPartyTrackingId
                  : '',
              style: titilliumRegular.copyWith(
                fontSize: Dimensions.FONT_SIZE_SMALL,
              )),
        ]),
      ]),
    );
  }
}
