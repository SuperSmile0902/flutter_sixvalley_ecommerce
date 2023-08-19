import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/loyalty_point_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

class LoyaltyPointWidget extends StatelessWidget {
  final LoyaltyPointList? loyaltyPointModel;
  const LoyaltyPointWidget({Key? key, this.loyaltyPointModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String type = loyaltyPointModel!.transactionType;
    String? reformatType;
    if (type.contains('_')) {
      reformatType = type.replaceAll('_', ' ');
    }
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.HOME_PAGE_PADDING,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${loyaltyPointModel!.credit > 0 ? loyaltyPointModel!.credit : loyaltyPointModel!.debit}',
                        style: robotoRegular.copyWith(
                            color: ColorResources.getTextTitle(context),
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                      ),
                      Text(
                        ' points',
                        style: robotoRegular.copyWith(
                            color: ColorResources.getHint(context)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
                  Text(
                    '${reformatType}',
                    style: robotoRegular.copyWith(
                        color: ColorResources.getHint(context)),
                  ),
                ],
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateConverter.localDateToIsoStringAMPM(
                        DateTime.parse(loyaltyPointModel!.createdAt)),
                    style: robotoRegular.copyWith(
                        color: ColorResources.getHint(context),
                        fontSize: Dimensions.FONT_SIZE_SMALL),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
                  Text(
                    '${loyaltyPointModel!.credit > 0 ? 'Credit' : 'Debit'}',
                    style: robotoRegular.copyWith(
                        color: loyaltyPointModel!.credit > 0
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: Divider(
              thickness: .4,
              color: Theme.of(context).hintColor.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}
