import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/location_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ZipSearchDialog extends StatelessWidget {
  const ZipSearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, locationProvider, _) {
      return locationProvider.restrictedZipList != null &&
              locationProvider.restrictedZipList.length != 0
          ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Container(
                height: 200,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[
                              Provider.of<ThemeProvider>(context, listen: false)
                                      .darkTheme
                                  ? 800
                                  : 400]!,
                          spreadRadius: .5,
                          blurRadius: 12,
                          offset: Offset(3, 5))
                    ]),
                child: ListView.builder(
                    itemCount: locationProvider.restrictedZipList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          print(
                              'you are clicked in ====>${locationProvider.restrictedZipList[index].zipcode}');
                          locationProvider.setZip(locationProvider
                              .restrictedZipList[index].zipcode!);
                          locationProvider.getDeliveryRestrictedZipBySearch(
                              context,
                              'xfbdhfdbgdfsbgsdfbgsgbsgfbsgbsfdgbsdgbsdgbsdf');
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    locationProvider
                                        .restrictedZipList[index].zipcode!,
                                    style: robotoRegular.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_DEFAULT)),
                                SizedBox(
                                  height: Dimensions.PADDING_SIZE_SMALL,
                                ),
                                Divider(
                                    height: .5,
                                    color: Theme.of(context).hintColor),
                              ],
                            )),
                      );
                    }),
              ),
            )
          : SizedBox.shrink();
    });
  }
}
