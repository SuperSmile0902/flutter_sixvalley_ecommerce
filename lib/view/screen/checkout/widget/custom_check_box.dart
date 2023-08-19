import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class CustomCheckBox extends StatelessWidget {
  final int index;
  final bool isDigital;
  final String? icon;
  CustomCheckBox({required this.index, this.isDigital = false, this.icon});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        return InkWell(
          onTap: () => order.setPaymentMethod(index),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                  color: order.paymentMethodIndex == index
                      ? Theme.of(context).primaryColor.withOpacity(.5)
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(
                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  boxShadow: [
                    BoxShadow(
                        color: order.paymentMethodIndex == index
                            ? Theme.of(context).hintColor.withOpacity(.2)
                            : Theme.of(context).hintColor.withOpacity(.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1))
                  ]),
              child: Row(children: [
                Checkbox(
                  shape: CircleBorder(),
                  value: order.paymentMethodIndex == index,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool? isChecked) => order.setPaymentMethod(index),
                ),
                SizedBox(width: 100, child: Image.asset(icon!))
              ]),
            ),
          ),
        );
      },
    );
  }
}
