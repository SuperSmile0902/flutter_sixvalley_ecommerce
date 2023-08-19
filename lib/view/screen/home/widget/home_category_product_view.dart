import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/home_category_product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/brand_and_category_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class HomeCategoryProductView extends StatelessWidget {
  final bool isHomePage;
  HomeCategoryProductView({required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeCategoryProductProvider>(
      builder: (context, homeCategoryProductProvider, child) {
        return homeCategoryProductProvider.homeCategoryProductList.length != 0
            ? ListView.builder(
                itemCount:
                    homeCategoryProductProvider.homeCategoryProductList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isHomePage
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(
                                  5,
                                  Dimensions.PADDING_SIZE_DEFAULT,
                                  Dimensions.PADDING_SIZE_SMALL,
                                  Dimensions.PADDING_SIZE_SMALL),
                              child: TitleRow(
                                title: homeCategoryProductProvider
                                    .homeCategoryProductList[index].name,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              BrandAndCategoryProductScreen(
                                                isBrand: false,
                                                id: homeCategoryProductProvider
                                                    .homeCategoryProductList[
                                                        index]
                                                    .id
                                                    .toString(),
                                                name: homeCategoryProductProvider
                                                    .homeCategoryProductList[
                                                        index]
                                                    .name!,
                                              )));
                                },
                              ),
                            )
                          : SizedBox(),
                      ConstrainedBox(
                        constraints: homeCategoryProductProvider
                                    .homeCategoryProductList[index]
                                    .products!
                                    .length >
                                0
                            ? BoxConstraints(maxHeight: Dimensions.CARD_HEIGHT)
                            : BoxConstraints(maxHeight: 0),
                        child: ListView.builder(
                            itemCount: homeCategoryProductProvider
                                .homeCategoryProductList[index]
                                .products!
                                .length,
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            Duration(milliseconds: 1000),
                                        pageBuilder: (context, anim1, anim2) =>
                                            ProductDetails(
                                          productId: homeCategoryProductProvider
                                              .productList[i].id,
                                          slug: homeCategoryProductProvider
                                              .productList[i].slug,
                                        ),
                                      ));
                                },
                                child: Container(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        20,
                                    child: ProductWidget(
                                        productModel:
                                            homeCategoryProductProvider
                                                .homeCategoryProductList[index]
                                                .products![i])),
                              );
                            }),
                      )
                    ],
                  );
                })
            : SizedBox();
      },
    );
  }
}
