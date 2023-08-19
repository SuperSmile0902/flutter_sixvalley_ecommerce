import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/cart/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BottomCartView extends StatefulWidget {
  final ProductDetailsModel product;
  BottomCartView({required this.product});

  @override
  State<BottomCartView> createState() => _BottomCartViewState();
}

class _BottomCartViewState extends State<BottomCartView> {
  bool vacationIsOn = false;
  bool temporaryClose = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null &&
        widget.product.seller.shop.vacationEndDate != null) {
      DateTime vacationDate =
          DateTime.parse(widget.product.seller.shop.vacationEndDate);
      DateTime vacationStartDate =
          DateTime.parse(widget.product.seller.shop.vacationStartDate);
      final today = DateTime.now();
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if (difference >= 0 &&
          widget.product.seller.shop.vacationStatus == 1 &&
          startDate <= 0) {
        vacationIsOn = true;
      } else {
        vacationIsOn = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor,
              blurRadius: .5,
              spreadRadius: .1)
        ],
      ),
      child: Row(children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Stack(children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CartScreen()));
                    },
                    child: Image.asset(Images.cart_arrow_down_image,
                        color: ColorResources.getPrimary(context))),
                Positioned(
                  top: 0,
                  right: 15,
                  child:
                      Consumer<CartProvider>(builder: (context, cart, child) {
                    return Container(
                      height: 17,
                      width: 17,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.getPrimary(context),
                      ),
                      child: Text(
                        cart.cartList.length.toString(),
                        style: titilliumSemiBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            color: Theme.of(context).highlightColor),
                      ),
                    );
                  }),
                )
              ]),
            )),
        Expanded(
            flex: 11,
            child: InkWell(
              onTap: () {
                if (vacationIsOn || temporaryClose) {
                  showCustomSnackBar(
                      getTranslated('this_shop_is_close_now', context)!,
                      context,
                      isToaster: true);
                } else {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0),
                      builder: (con) => CartBottomSheet(
                            product: widget.product,
                            callback: () {
                              showCustomSnackBar(
                                  getTranslated('added_to_cart', context)!,
                                  context,
                                  isError: false);
                            },
                          ));
                }
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.getPrimary(context),
                ),
                child: Text(
                  getTranslated('add_to_cart', context)!,
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: Theme.of(context).highlightColor),
                ),
              ),
            )),
      ]),
    );
  }
}
