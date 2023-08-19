import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_details_model.dart'
    as pd;
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ProductTitleView extends StatelessWidget {
  final pd.ProductDetailsModel productModel;
  final String? averageRatting;
  ProductTitleView({required this.productModel, this.averageRatting});

  @override
  Widget build(BuildContext context) {
    double _startingPrice = 0;
    double? _endingPrice;
    if (productModel.variation != null && productModel.variation.length != 0) {
      List<double> _priceList = [];
      productModel.variation
          .forEach((variation) => _priceList.add(variation.price));
      _priceList.sort((a, b) => a.compareTo(b));
      _startingPrice = _priceList[0];
      if (_priceList[0] < _priceList[_priceList.length - 1]) {
        _endingPrice = _priceList[_priceList.length - 1];
      }
    } else {
      _startingPrice = productModel.unitPrice;
    }

    return productModel != null
        ? Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Consumer<ProductDetailsProvider>(
              builder: (context, details, child) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                            child: Text(productModel.name ?? '',
                                style: titleRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_LARGE),
                                maxLines: 2)),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Column(
                          children: [
                            productModel.discount != null &&
                                    productModel.discount > 0
                                ? Text(
                                    '${PriceConverter.convertPrice(context, _startingPrice)}'
                                    '${_endingPrice! != null ? ' - ${PriceConverter.convertPrice(context, _endingPrice!)}' : ''}',
                                    style: titilliumRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                : SizedBox(),
                            SizedBox(
                                height:
                                    Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                            Text(
                              '${_startingPrice != null ? PriceConverter.convertPrice(context, _startingPrice, discount: productModel.discount, discountType: productModel.discountType) : ''}'
                              '${_endingPrice != null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: productModel.discount, discountType: productModel.discountType)}' : ''}',
                              style: titilliumBold.copyWith(
                                  color: ColorResources.getPrimary(context),
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                          ],
                        ),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Row(children: [
                        Text(
                            '${details.reviewList != null ? details.reviewList.length : 0} reviews | ',
                            style: titilliumRegular.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            )),
                        Text('${details.orderCount} orders | ',
                            style: titilliumRegular.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            )),
                        Text('${details.wishCount} wish',
                            style: titilliumRegular.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            )),
                        Expanded(child: SizedBox.shrink()),
                        SizedBox(width: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            Text(
                                '${productModel.reviews != null ? productModel.reviews.length > 0 ? double.parse(averageRatting!) : 0.0 : 0.0}')
                          ],
                        ),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      productModel.colors != null &&
                              productModel.colors.length > 0
                          ? Row(children: [
                              Text(
                                  '${getTranslated('select_variant', context)} : ',
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE)),
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    itemCount: productModel.colors.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      String colorString = '0xff' +
                                          productModel.colors[index].code
                                              .substring(1, 7);
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            padding: EdgeInsets.all(Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color:
                                                  Color(int.parse(colorString)),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ])
                          : SizedBox(),
                      productModel.colors != null &&
                              productModel.colors.length > 0
                          ? SizedBox(height: Dimensions.PADDING_SIZE_SMALL)
                          : SizedBox(),
                      productModel.choiceOptions != null &&
                              productModel.choiceOptions.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: productModel.choiceOptions.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          '${getTranslated('available', context)}' +
                                              ' ' +
                                              '${productModel.choiceOptions[index].title} :',
                                          style: titilliumRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_LARGE)),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 6,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5,
                                              childAspectRatio: (1 / .7),
                                            ),
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: productModel
                                                .choiceOptions[index]
                                                .options
                                                .length,
                                            itemBuilder: (context, i) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: .3,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      productModel
                                                          .choiceOptions[index]
                                                          .options[i]
                                                          .trim(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: titilliumRegular
                                                          .copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_DEFAULT,
                                                      )),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ]);
                              },
                            )
                          : SizedBox(),
                    ]);
              },
            ),
          )
        : SizedBox();
  }
}
