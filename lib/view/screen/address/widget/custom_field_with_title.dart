import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

class CustomFieldWithTitle extends StatelessWidget {
  final Widget customTextField;
  final String? title;
  final bool requiredField;
  final bool isPadding;
  final bool isSKU;
  final bool limitSet;
  final String? setLimitTitle;
  final Function? onTap;
  const CustomFieldWithTitle({
    Key? key,
    required this.customTextField,
    this.title,
    this.setLimitTitle,
    this.requiredField = false,
    this.isPadding = true,
    this.isSKU = false,
    this.limitSet = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding
          ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
          : EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: robotoRegular.copyWith(
                      color: Theme.of(context).primaryColor),
                  children: <TextSpan>[
                    requiredField
                        ? TextSpan(
                            text: '  *',
                            style: robotoBold.copyWith(color: Colors.red))
                        : TextSpan(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          customTextField,
        ],
      ),
    );
  }
}
