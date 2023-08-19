import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';

class OfflinePaymentDialog extends StatelessWidget {
  final double rotateAngle;
  final Function onTap;
  final TextEditingController? paymentBy;
  final TextEditingController? transactionId;
  final TextEditingController? paymentNote;
  OfflinePaymentDialog(
      {this.rotateAngle = 0,
      required this.onTap,
      this.paymentBy,
      this.transactionId,
      this.paymentNote});

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
                    getTranslated('offline_payment', context)!,
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
                getTranslated('payment_by', context)!,
                style: robotoRegular,
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              CustomTextField(
                textAlign: TextAlign.start,
                isBorder: true,
                controller: paymentBy,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              Text(
                getTranslated('transaction_id', context)!,
                style: robotoRegular,
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              CustomTextField(
                textAlign: TextAlign.start,
                isBorder: true,
                controller: transactionId,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              Text(
                getTranslated('payment_note', context)!,
                style: robotoRegular,
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              CustomTextField(
                textAlign: TextAlign.start,
                isBorder: true,
                controller: paymentNote,
                textInputAction: TextInputAction.done,
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
