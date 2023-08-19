import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';

class WalletPayment extends StatelessWidget {
  final double rotateAngle;
  final Function onTap;
  final double? orderAmount;
  final double? currentBalance;

  WalletPayment(
      {this.rotateAngle = 0,
      required this.onTap,
      this.orderAmount,
      this.currentBalance});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated('wallet_payment', context)!,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        child: Icon(Icons.clear),
                      )),
                ],
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
              ),
              Text(
                getTranslated('your_current_balance', context)!,
                style: robotoRegular,
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(Dimensions.FONT_SIZE_EXTRA_SMALL),
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(.1),
                    border: Border.all(
                        width: .5, color: Theme.of(context).hintColor),
                    borderRadius: BorderRadius.circular(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                child:
                    Text(PriceConverter.convertPrice(context, currentBalance!)),
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              Text(
                getTranslated('order_amount', context)!,
                style: robotoRegular,
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(Dimensions.FONT_SIZE_EXTRA_SMALL),
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(.1),
                    border: Border.all(
                        width: .5, color: Theme.of(context).hintColor),
                    borderRadius: BorderRadius.circular(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                child: Text(PriceConverter.convertPrice(context, orderAmount!)),
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              Text(
                getTranslated('remaining_balance', context)!,
                style: robotoRegular,
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(Dimensions.FONT_SIZE_EXTRA_SMALL),
                decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(.1),
                    border: Border.all(
                        width: .5, color: Theme.of(context).hintColor),
                    borderRadius: BorderRadius.circular(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                child: Text(PriceConverter.convertPrice(
                    context, (currentBalance! - orderAmount!))),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    buttonText: getTranslated('cancel', context)!,
                    backgroundColor: Theme.of(context).hintColor,
                    onTap: () => Navigator.of(context).pop(),
                    radius: null,
                  )),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  Expanded(
                      child: CustomButton(
                    buttonText: getTranslated('submit', context)!,
                    onTap: onTap(),
                    backgroundColor: null,
                    radius: null,
                  )),
                ],
              )
            ]),
      ),
    );
  }
}
