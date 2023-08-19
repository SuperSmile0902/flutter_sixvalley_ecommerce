import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/home_category_product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/top_seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class CurrencyDialog extends StatelessWidget {
  final bool isCurrency;
  CurrencyDialog({this.isCurrency = true});
  @override
  Widget build(BuildContext context) {
    int index;
    if (isCurrency) {
      index = Provider.of<SplashProvider>(context, listen: false).currencyIndex;
    } else {
      index = Provider.of<LocalizationProvider>(context, listen: false)
          .languageIndex;
    }

    return Dialog(
      backgroundColor: Theme.of(context).highlightColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(
                  isCurrency
                      ? getTranslated('currency', context)!
                      : getTranslated('language', context)!,
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            SizedBox(
                height: 150,
                child: Consumer<SplashProvider>(
                  builder: (context, splash, child) {
                    List<String> _valueList = [];
                    if (isCurrency) {
                      splash.configModel!.currencyList
                          .forEach((currency) => _valueList.add(currency.name));
                    } else {
                      AppConstants.languages.forEach(
                          (language) => _valueList.add(language.languageName));
                    }
                    return CupertinoPicker(
                      itemExtent: 40,
                      useMagnifier: true,
                      magnification: 1.2,
                      scrollController:
                          FixedExtentScrollController(initialItem: index),
                      onSelectedItemChanged: (int i) {
                        index = i;
                      },
                      children: _valueList.map((value) {
                        return Center(
                            child: Text(value,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color)));
                      }).toList(),
                    );
                  },
                )),
            Divider(
                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                color: ColorResources.HINT_TEXT_COLOR),
            Row(children: [
              Expanded(
                  child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(getTranslated('CANCEL', context)!,
                    style: robotoRegular.copyWith(
                        color: ColorResources.getYellow(context))),
              )),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: VerticalDivider(
                    width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    color: Theme.of(context).hintColor),
              ),
              Expanded(
                  child: TextButton(
                onPressed: () {
                  if (isCurrency) {
                    Provider.of<SplashProvider>(context, listen: false)
                        .setCurrency(index);
                  } else {
                    Provider.of<LocalizationProvider>(context, listen: false)
                        .setLanguage(Locale(
                      AppConstants.languages[index].languageCode,
                      AppConstants.languages[index].countryCode,
                    ));
                    Provider.of<CategoryProvider>(context, listen: false)
                        .getCategoryList(true, context);
                    Provider.of<HomeCategoryProductProvider>(context,
                            listen: false)
                        .getHomeCategoryProductList(true, context);
                    Provider.of<TopSellerProvider>(context, listen: false)
                        .getTopSellerList(true, context);
                    Provider.of<BrandProvider>(context, listen: false)
                        .getBrandList(true, context);
                    Provider.of<ProductProvider>(context, listen: false)
                        .getLatestProductList(1, context, reload: true);
                    Provider.of<ProductProvider>(context, listen: false)
                        .getFeaturedProductList('1', context, reload: true);
                    Provider.of<FeaturedDealProvider>(context, listen: false)
                        .getFeaturedDealList(true, context);
                    Provider.of<ProductProvider>(context, listen: false)
                        .getLProductList('1', context, reload: true);
                  }
                  Navigator.pop(context);
                },
                child: Text(getTranslated('ok', context)!,
                    style: robotoRegular.copyWith(
                        color: ColorResources.getGreen(context))),
              )),
            ]),
          ]),
    );
  }
}
