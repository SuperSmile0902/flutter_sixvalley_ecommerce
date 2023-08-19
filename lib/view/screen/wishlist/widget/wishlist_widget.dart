import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wishlist_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class WishListWidget extends StatelessWidget {
  final Product? product;
  final int? index;
  WishListWidget({this.product, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      margin: EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              right: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          border: Border.all(
                              width: .5,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.25)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            fit: BoxFit.scaleDown,
                            width: 80,
                            height: 80,
                            image:
                                '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}/${product!.thumbnail}',
                            imageErrorBuilder: (c, o, s) => Image.asset(
                                Images.placeholder,
                                fit: BoxFit.scaleDown,
                                width: 80,
                                height: 80),
                          ),
                        ),
                      ),
                      product!.unitPrice != null && product!.discount > 0
                          ? Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 20,
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                        bottomRight: Radius.circular(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL)),
                                    color: Theme.of(context).primaryColor),
                                child: Text(
                                  product!.unitPrice != null &&
                                          product!.discount != null &&
                                          product!.discountType != null
                                      ? PriceConverter.percentageCalculation(
                                          context,
                                          product!.unitPrice,
                                          product!.discount,
                                          product!.discountType)
                                      : '',
                                  style: titilliumRegular.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      color: Theme.of(context).cardColor),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product!.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: titilliumSemiBold.copyWith(
                                  color: ColorResources.getReviewRattingColor(
                                      context),
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => new CupertinoAlertDialog(
                                            title: new Text(getTranslated(
                                                'ARE_YOU_SURE_WANT_TO_REMOVE_WISH_LIST',
                                                context)!),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(getTranslated(
                                                    'YES', context)!),
                                                onPressed: () {
                                                  Provider.of<WishListProvider>(
                                                          context,
                                                          listen: false)
                                                      .removeWishList(
                                                          product!.id,
                                                          index: index);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text(getTranslated(
                                                    'NO', context)!),
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                              ),
                                            ],
                                          ));
                                },
                                child: Image.asset(
                                  Images.delete,
                                  scale: 3,
                                  color: ColorResources.getRed(context)
                                      .withOpacity(.90),
                                )),
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Row(
                          children: [
                            product!.discount != null && product!.discount > 0
                                ? Text(
                                    product!.unitPrice != null
                                        ? PriceConverter.convertPrice(
                                            context, product!.unitPrice)
                                        : '',
                                    style: titilliumSemiBold.copyWith(
                                        color: ColorResources.getRed(context),
                                        decoration: TextDecoration.lineThrough),
                                  )
                                : SizedBox(),
                            product!.discount != null && product!.discount > 0
                                ? SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT)
                                : SizedBox(),
                            Text(
                              PriceConverter.convertPrice(
                                  context, product!.unitPrice,
                                  discount: product!.discount,
                                  discountType: product!.discountType),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: titilliumRegular.copyWith(
                                  color: ColorResources.getPrimary(context),
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${getTranslated('qty', context)}:' +
                                  ' ' +
                                  '${product!.minQty}',
                              style: titleRegular.copyWith(
                                  color: ColorResources.getReviewRattingColor(
                                      context)),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 1000),
                                      pageBuilder: (context, anim1, anim2) =>
                                          ProductDetails(
                                              productId: product!.id,
                                              slug: product!.slug,
                                              isFromWishList: true),
                                    ));
                              },
                              child: Container(
                                height: 30,
                                margin: EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_SMALL),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).primaryColor,
                                      Theme.of(context).primaryColor,
                                    ]),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart,
                                        color: Colors.white, size: 15),
                                    SizedBox(
                                      width:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    ),
                                    FittedBox(
                                      child: Text(
                                          getTranslated(
                                              'add_to_cart', context)!,
                                          style: titleRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
