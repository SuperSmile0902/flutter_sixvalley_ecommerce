import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/seller/seller_screen.dart';
import 'package:provider/provider.dart';

class SellerView extends StatelessWidget {
  final String sellerId;
  SellerView({required this.sellerId});

  @override
  Widget build(BuildContext context) {
    double sellerIconSize = 50;
    Provider.of<SellerProvider>(context, listen: false)
        .initSeller(sellerId, context);

    return Consumer<SellerProvider>(
      builder: (context, seller, child) {
        return seller.sellerModel != null
            ? Container(
                margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).cardColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: sellerIconSize,
                      height: sellerIconSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(sellerIconSize),
                          border: Border.all(
                              width: .5, color: Theme.of(context).hintColor)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(sellerIconSize),
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: Images.placeholder,
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          image:
                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/${seller.sellerModel.seller.shop.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(
                            Images.placeholder,
                            height: MediaQuery.of(context).size.width,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Expanded(
                      child: Column(children: [
                        Row(children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SellerScreen(
                                          seller: seller.sellerModel))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    seller.sellerModel != null
                                        ? '${seller.sellerModel.seller.shop.name ?? ''}'
                                        : '',
                                    style: titilliumSemiBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE),
                                  ),
                                  Text(
                                    seller.sellerModel != null
                                        ? '${seller.sellerModel.seller.fName ?? ''}' +
                                            ' ' +
                                            '${seller.sellerModel.seller.lName ?? ''}'
                                        : '',
                                    style: titleRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL,
                                        color: Theme.of(context).hintColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (!Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .isLoggedIn()) {
                                showAnimatedDialog(context, GuestDialog(),
                                    isFlip: true);
                              } else if (seller.sellerModel != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                              id: seller.sellerModel.seller.id,
                                              name: seller
                                                  .sellerModel.seller.shop.name,
                                            )));
                              }
                            },
                            child: Image.asset(Images.chat_image,
                                height: Dimensions.ICON_SIZE_DEFAULT),
                          ),
                        ]),
                        SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        seller.sellerModel != null
                            ? Row(children: [
                                Column(
                                  children: [
                                    Text(
                                      '${seller.sellerModel.totalReview.toString()}',
                                      style: titilliumSemiBold.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_LARGE),
                                    ),
                                    Text(
                                      getTranslated('reviews', context)!,
                                      style: titleRegular.copyWith(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                Column(
                                  children: [
                                    Text(
                                      '${seller.sellerModel.totalProduct.toString()}',
                                      style: titilliumSemiBold.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_LARGE),
                                    ),
                                    Text(
                                      getTranslated('products', context)!,
                                      style: titleRegular.copyWith(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SellerScreen(
                                              seller: seller.sellerModel))),
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color:
                                            ColorResources.visitShop(context),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions
                                                .PADDING_SIZE_EXTRA_LARGE)),
                                    child: Center(
                                        child: Text(
                                      getTranslated('visit_store', context)!,
                                      style: titleRegular.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    )),
                                  ),
                                )
                              ])
                            : SizedBox(),
                      ]),
                    ),
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }
}
