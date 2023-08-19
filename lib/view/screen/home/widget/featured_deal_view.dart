import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedDealsView extends StatelessWidget {
  final bool isHomePage;
  FeaturedDealsView({this.isHomePage = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<FeaturedDealProvider>(
      builder: (context, featuredDealProvider, child) {
        return featuredDealProvider.featuredDealProductList.length > 0
            ? ListView.builder(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    featuredDealProvider.featuredDealProductList.length > 4 &&
                            isHomePage
                        ? 4
                        : featuredDealProvider.featuredDealProductList.length,
                itemBuilder: (context, index) {
                  print(
                      '---ff-------${featuredDealProvider.featuredDealProductList[index].id}-=====================>${featuredDealProvider.featuredDealProductList[0].name}');
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1000),
                            pageBuilder: (context, anim1, anim2) =>
                                ProductDetails(
                              productId: featuredDealProvider
                                  .featuredDealProductList[index].id,
                              slug: featuredDealProvider
                                  .featuredDealProductList[index].slug,
                            ),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: isHomePage ? 300 : null,
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).highlightColor,
                        // boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.10),
                        //     spreadRadius: 1, blurRadius: 12)]
                      ),
                      child: Stack(children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorResources.getIconBg(context),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      bottomLeft: Radius.circular(
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      bottomLeft: Radius.circular(
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: Images.placeholder,
                                      fit: BoxFit.cover,
                                      image:
                                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}'
                                          '/${featuredDealProvider.featuredDealProductList[index].thumbnail}',
                                      imageErrorBuilder: (c, o, s) =>
                                          Image.asset(Images.placeholder,
                                              fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        featuredDealProvider
                                            .featuredDealProductList[index]
                                            .name,
                                        style: robotoRegular.copyWith(
                                            height: 1.3,
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      Row(children: [
                                        Text(
                                          featuredDealProvider
                                                          .featuredDealProductList[
                                                              index]
                                                          .rating !=
                                                      null &&
                                                  featuredDealProvider
                                                      .featuredDealProductList[
                                                          index]
                                                      .rating!
                                                      .isNotEmpty
                                              ? double.parse(featuredDealProvider
                                                      .featuredDealProductList[
                                                          index]
                                                      .rating![0]
                                                      .average)
                                                  .toStringAsFixed(1)
                                              : '0.0',
                                          style: robotoRegular.copyWith(
                                              color: Provider.of<ThemeProvider>(
                                                          context)
                                                      .darkTheme
                                                  ? Colors.white
                                                  : Colors.orange,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL),
                                        ),
                                        Icon(Icons.star,
                                            color: Provider.of<ThemeProvider>(
                                                        context)
                                                    .darkTheme
                                                ? Colors.white
                                                : Colors.orange,
                                            size: 15),
                                        Text(
                                            '(${featuredDealProvider.featuredDealProductList[index].reviewCount.toString() ?? 0})',
                                            style: robotoRegular.copyWith(
                                              color: Provider.of<ThemeProvider>(
                                                          context)
                                                      .darkTheme
                                                  ? Colors.white
                                                  : Colors.orange,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                            )),
                                      ]),
                                      SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              featuredDealProvider
                                                          .featuredDealProductList[
                                                              index]
                                                          .discount >
                                                      0
                                                  ? PriceConverter.convertPrice(
                                                      context,
                                                      featuredDealProvider
                                                          .featuredDealProductList[
                                                              index]
                                                          .unitPrice
                                                          .toDouble())
                                                  : '',
                                              style: robotoRegular.copyWith(
                                                color: ColorResources.getRed(
                                                    context),
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL,
                                              ),
                                            ),
                                            featuredDealProvider
                                                        .featuredDealProductList[
                                                            index]
                                                        .discount >
                                                    0
                                                ? SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_DEFAULT)
                                                : SizedBox(),
                                            Text(
                                              PriceConverter
                                                  .convertPrice(
                                                      context,
                                                      featuredDealProvider
                                                          .featuredDealProductList[
                                                              index]
                                                          .unitPrice
                                                          .toDouble(),
                                                      discountType:
                                                          featuredDealProvider
                                                              .featuredDealProductList[
                                                                  index]
                                                              .discountType,
                                                      discount: featuredDealProvider
                                                          .featuredDealProductList[
                                                              index]
                                                          .discount
                                                          .toDouble()),
                                              style: robotoBold.copyWith(
                                                  color:
                                                      ColorResources.getPrimary(
                                                          context),
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_LARGE),
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ]),

                        // Off
                        featuredDealProvider
                                    .featuredDealProductList[index].discount >
                                0
                            ? Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: ColorResources.getPrimary(context),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Text(
                                    PriceConverter.percentageCalculation(
                                      context,
                                      featuredDealProvider
                                          .featuredDealProductList[index]
                                          .unitPrice
                                          .toDouble(),
                                      featuredDealProvider
                                          .featuredDealProductList[index]
                                          .discount
                                          .toDouble(),
                                      featuredDealProvider
                                          .featuredDealProductList[index]
                                          .discountType,
                                    ),
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).highlightColor,
                                        fontSize: Dimensions.FONT_SIZE_SMALL),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ]),
                    ),
                  );
                },
              )
            : MegaDealShimmer(isHomeScreen: isHomePage);
      },
    );
  }
}

class MegaDealShimmer extends StatelessWidget {
  final bool isHomeScreen;
  MegaDealShimmer({required this.isHomeScreen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: isHomeScreen ? Axis.horizontal : Axis.vertical,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.WHITE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5)
              ]),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: Provider.of<FeaturedDealProvider>(context)
                    .featuredDealProductList
                    .length ==
                0,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.ICON_BG,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, color: ColorResources.WHITE),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 20,
                                      width: 50,
                                      color: ColorResources.WHITE),
                                ]),
                          ),
                          Container(
                              height: 10,
                              width: 50,
                              color: ColorResources.WHITE),
                          Icon(Icons.star, color: Colors.orange, size: 15),
                        ]),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
