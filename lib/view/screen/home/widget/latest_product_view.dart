import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:provider/provider.dart';

class LatestProductView extends StatelessWidget {
  final ScrollController? scrollController;
  LatestProductView({this.scrollController});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController!.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .lProductList!
                  .length !=
              0 &&
          !Provider.of<ProductProvider>(context, listen: false).isLoading) {
        int pageSize;
        pageSize =
            Provider.of<ProductProvider>(context, listen: false).lPageSize!;

        if (offset < pageSize) {
          offset++;
          print('end of the page');
          Provider.of<ProductProvider>(context, listen: false)
              .showBottomLoader();
          Provider.of<ProductProvider>(context, listen: false)
              .getLatestProductList(offset, context);
        }
      }
    });

    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        productList = prodProvider.lProductList!;

        return Column(children: [
          !prodProvider.firstLoading
              ? productList.length != 0
                  ? Container(
                      height: Dimensions.CARD_HEIGHT,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    20,
                                child: ProductWidget(
                                    productModel: productList[index]));
                          }),
                    )
                  : SizedBox.shrink()
              : ProductShimmer(
                  isHomePage: true, isEnabled: prodProvider.firstLoading),
          // prodProvider.isLoading ? Center(child: Padding(
          //   padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
          //   child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          // )) : SizedBox.shrink(),
        ]);
      },
    );
  }
}
