import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/search_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:provider/provider.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  @override
  _SearchFilterBottomSheetState createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  final TextEditingController _firstPriceController = TextEditingController();
  final FocusNode _firstFocus = FocusNode();
  final TextEditingController _lastPriceController = TextEditingController();
  final FocusNode _lastFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        Consumer<SearchProvider>(
          builder: (context, search, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Text(getTranslated('PRICE_RANGE', context)!,
                        style: titilliumSemiBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE)),
                    SizedBox(
                      width: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_lastFocus),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        focusNode: _firstFocus,
                        controller: _firstPriceController,
                        style: titilliumBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL),
                        decoration: new InputDecoration(
                          hintText: getTranslated('min', context),
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Text(getTranslated('to', context)!),
                    ),
                    Expanded(
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: _lastPriceController,
                          maxLines: 1,
                          focusNode: _lastFocus,
                          textInputAction: TextInputAction.done,
                          style: titilliumBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          ),
                          decoration: new InputDecoration(
                            hintText: getTranslated('max', context),
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Theme.of(context).primaryColor)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Divider(),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Text(
                getTranslated('SORT_BY', context)!,
                style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE),
              ),
              MyCheckBox(
                  title: getTranslated('latest_products', context)!, index: 0),
              MyCheckBox(
                  title: getTranslated('alphabetically_az', context)!,
                  index: 1),
              MyCheckBox(
                  title: getTranslated('alphabetically_za', context)!,
                  index: 2),
              MyCheckBox(
                  title: getTranslated('low_to_high_price', context)!,
                  index: 3),
              MyCheckBox(
                  title: getTranslated('high_to_low_price', context)!,
                  index: 4),
              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: CustomButton(
                  buttonText: getTranslated('APPLY', context)!,
                  onTap: () {
                    double minPrice = 0.0;
                    double maxPrice = 0.0;
                    if (_firstPriceController.text.isNotEmpty &&
                        _lastPriceController.text.isNotEmpty) {
                      minPrice = double.parse(_firstPriceController.text);
                      maxPrice = double.parse(_lastPriceController.text);
                    }
                    Provider.of<SearchProvider>(context, listen: false)
                        .sortSearchList(minPrice, maxPrice);
                    Navigator.pop(context);
                  },
                  backgroundColor: null,
                  radius: null,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class MyCheckBox extends StatelessWidget {
  final String title;
  final int index;
  MyCheckBox({required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title,
          style:
              titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
      checkColor: Theme.of(context).primaryColor,
      activeColor: Colors.transparent,
      value: Provider.of<SearchProvider>(context).filterIndex == index,
      onChanged: (isChecked) {
        if (isChecked!) {
          Provider.of<SearchProvider>(context, listen: false)
              .setFilterIndex(index);
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
