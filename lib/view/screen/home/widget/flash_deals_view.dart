import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/flash_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'featured_deal_view.dart';

class FlashDealsView extends StatelessWidget {
  final bool isHomeScreen;
  FlashDealsView({this.isHomeScreen = true});

  @override
  Widget build(BuildContext context) {
    return isHomeScreen
        ? Consumer<FlashDealProvider>(
            builder: (context, megaProvider, child) {
              double _width = MediaQuery.of(context).size.width;
              return Provider.of<FlashDealProvider>(context)
                          .flashDealList
                          .length !=
                      0
                  ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection:
                          isHomeScreen ? Axis.horizontal : Axis.vertical,
                      itemCount: megaProvider.flashDealList.length == 0
                          ? 2
                          : megaProvider.flashDealList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: _width,
                          child: megaProvider.flashDealList != null
                              ? megaProvider.flashDealList.length != 0
                                  ? Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        CarouselSlider.builder(
                                          options: CarouselOptions(
                                            viewportFraction: .55,
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            disableCenter: true,
                                            onPageChanged: (index, reason) {
                                              Provider.of<FlashDealProvider>(
                                                      context,
                                                      listen: false)
                                                  .setCurrentIndex(index);
                                            },
                                          ),
                                          itemCount: megaProvider
                                                      .flashDealList.length ==
                                                  0
                                              ? 1
                                              : megaProvider
                                                  .flashDealList.length,
                                          itemBuilder: (context, index, _) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      transitionDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  1000),
                                                      pageBuilder: (context,
                                                              anim1, anim2) =>
                                                          ProductDetails(
                                                        productId: megaProvider
                                                            .flashDealList[
                                                                index]
                                                            .id,
                                                        slug: megaProvider
                                                            .flashDealList[
                                                                index]
                                                            .slug,
                                                      ),
                                                    ));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Theme.of(context)
                                                        .highlightColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          spreadRadius: 1,
                                                          blurRadius: 5)
                                                    ]),
                                                child: Stack(children: [
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.2,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          .2),
                                                                  width: .1),
                                                              color: ColorResources
                                                                  .getIconBg(
                                                                      context),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              child: FadeInImage
                                                                  .assetNetwork(
                                                                placeholder: Images
                                                                    .placeholder,
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}'
                                                                    '/${megaProvider.flashDealList[index].thumbnail}',
                                                                imageErrorBuilder:
                                                                    (c, o, s) =>
                                                                        Image
                                                                            .asset(
                                                                  Images
                                                                      .placeholder,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height:
                                                                      _width *
                                                                          .50,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .all(Dimensions
                                                                  .PADDING_SIZE_SMALL),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                megaProvider
                                                                    .flashDealList[
                                                                        index]
                                                                    .name,
                                                                style:
                                                                    robotoRegular,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              SizedBox(
                                                                  height: Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              Row(children: [
                                                                Text(
                                                                  megaProvider
                                                                              .flashDealList[
                                                                                  index]
                                                                              .rating!
                                                                              .length !=
                                                                          0
                                                                      ? double.parse(megaProvider
                                                                              .flashDealList[index]
                                                                              .rating![0]
                                                                              .average)
                                                                          .toStringAsFixed(1)
                                                                      : '0.0',
                                                                  style: robotoRegular.copyWith(
                                                                      color: Provider.of<ThemeProvider>(context).darkTheme
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .orange,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .FONT_SIZE_SMALL),
                                                                ),
                                                                Icon(Icons.star,
                                                                    color: Provider.of<ThemeProvider>(
                                                                                context)
                                                                            .darkTheme
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .orange,
                                                                    size: 15),
                                                                Text(
                                                                    '(${megaProvider.flashDealList[index].reviewCount.toString() ?? 0})',
                                                                    style: robotoRegular
                                                                        .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .FONT_SIZE_SMALL,
                                                                    )),
                                                                Spacer(),
                                                                Text(
                                                                  megaProvider.flashDealList[index].discount >
                                                                          0
                                                                      ? PriceConverter.convertPrice(
                                                                          context,
                                                                          megaProvider
                                                                              .flashDealList[index]
                                                                              .unitPrice)
                                                                      : '',
                                                                  style: robotoBold
                                                                      .copyWith(
                                                                    color: ColorResources
                                                                        .HINT_TEXT_COLOR,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .FONT_SIZE_EXTRA_SMALL,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: Dimensions
                                                                        .PADDING_SIZE_SMALL),
                                                                Text(
                                                                  PriceConverter.convertPrice(
                                                                      context,
                                                                      megaProvider
                                                                          .flashDealList[
                                                                              index]
                                                                          .unitPrice,
                                                                      discountType: megaProvider
                                                                          .flashDealList[
                                                                              index]
                                                                          .discountType,
                                                                      discount: megaProvider
                                                                          .flashDealList[
                                                                              index]
                                                                          .discount),
                                                                  style: robotoBold
                                                                      .copyWith(
                                                                          color:
                                                                              ColorResources.getPrimary(context)),
                                                                ),
                                                              ]),
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                  megaProvider
                                                              .flashDealList[
                                                                  index]
                                                              .discount >=
                                                          1
                                                      ? Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        Dimensions
                                                                            .PADDING_SIZE_SMALL),
                                                            height: 25,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorResources
                                                                  .getPrimary(
                                                                      context),
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Text(
                                                              PriceConverter
                                                                  .percentageCalculation(
                                                                context,
                                                                megaProvider
                                                                    .flashDealList[
                                                                        index]
                                                                    .unitPrice,
                                                                megaProvider
                                                                    .flashDealList[
                                                                        index]
                                                                    .discount,
                                                                megaProvider
                                                                    .flashDealList[
                                                                        index]
                                                                    .discountType,
                                                              ),
                                                              style: robotoRegular.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .highlightColor,
                                                                  fontSize:
                                                                      Dimensions
                                                                          .FONT_SIZE_SMALL),
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox.shrink(),
                                                ]),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  enabled: megaProvider.flashDealList == null,
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorResources.WHITE,
                                      )),
                                ),
                        );
                      },
                    )
                  : MegaDealShimmer(isHomeScreen: isHomeScreen);
            },
          )
        : Consumer<FlashDealProvider>(
            builder: (context, megaProvider, child) {
              return Provider.of<FlashDealProvider>(context)
                          .flashDealList
                          .length !=
                      0
                  ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection:
                          isHomeScreen ? Axis.horizontal : Axis.vertical,
                      itemCount: megaProvider.flashDealList.length == 0
                          ? 2
                          : megaProvider.flashDealList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 1000),
                                  pageBuilder: (context, anim1, anim2) =>
                                      ProductDetails(
                                    productId:
                                        megaProvider.flashDealList[index].id,
                                    slug:
                                        megaProvider.flashDealList[index].slug,
                                  ),
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: isHomeScreen ? 300 : null,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).highlightColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ]),
                            child: Stack(children: [
                              Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                          color:
                                              ColorResources.getIconBg(context),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder,
                                          fit: BoxFit.cover,
                                          image:
                                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}'
                                              '/${megaProvider.flashDealList[index].thumbnail}',
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(Images.placeholder,
                                                  fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              megaProvider
                                                  .flashDealList[index].name,
                                              style: robotoRegular,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT,
                                            ),
                                            Row(children: [
                                              Text(
                                                megaProvider
                                                            .flashDealList[
                                                                index]
                                                            .rating!
                                                            .length !=
                                                        0
                                                    ? double.parse(megaProvider
                                                            .flashDealList[
                                                                index]
                                                            .rating![0]
                                                            .average)
                                                        .toStringAsFixed(1)
                                                    : '0.0',
                                                style: robotoRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL),
                                              ),
                                              Icon(Icons.star,
                                                  color:
                                                      Provider.of<ThemeProvider>(
                                                                  context)
                                                              .darkTheme
                                                          ? Colors.white
                                                          : Colors.orange,
                                                  size: 15),
                                              Text(
                                                  '(${megaProvider.flashDealList[index].reviewCount.toString() ?? 0})',
                                                  style: robotoRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL,
                                                  )),
                                            ]),
                                            SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  megaProvider
                                                              .flashDealList[
                                                                  index]
                                                              .discount >
                                                          0
                                                      ? PriceConverter
                                                          .convertPrice(
                                                              context,
                                                              megaProvider
                                                                  .flashDealList[
                                                                      index]
                                                                  .unitPrice)
                                                      : '',
                                                  style: robotoRegular.copyWith(
                                                    color:
                                                        ColorResources.getRed(
                                                            context),
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions
                                                      .PADDING_SIZE_DEFAULT,
                                                ),
                                                Text(
                                                  PriceConverter.convertPrice(
                                                      context,
                                                      megaProvider
                                                          .flashDealList[index]
                                                          .unitPrice,
                                                      discountType: megaProvider
                                                          .flashDealList[index]
                                                          .discountType,
                                                      discount: megaProvider
                                                          .flashDealList[index]
                                                          .discount),
                                                  style: titleRegular.copyWith(
                                                      color: ColorResources
                                                          .getPrimary(context),
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_LARGE),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),

                              // Off
                              megaProvider.flashDealList[index].discount >= 1
                                  ? Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorResources.getPrimary(
                                              context),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          child: Text(
                                            PriceConverter
                                                .percentageCalculation(
                                              context,
                                              megaProvider.flashDealList[index]
                                                  .unitPrice,
                                              megaProvider.flashDealList[index]
                                                  .discount,
                                              megaProvider.flashDealList[index]
                                                  .discountType,
                                            ),
                                            style: robotoRegular.copyWith(
                                                color: Theme.of(context)
                                                    .highlightColor,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ]),
                          ),
                        );
                      },
                    )
                  : MegaDealShimmer(isHomeScreen: isHomeScreen);
            },
          );
  }
}
