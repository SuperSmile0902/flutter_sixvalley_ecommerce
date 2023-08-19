import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wallet_transaction_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/loyaltyPoint/widget/loyalty_point_converter_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/loyaltyPoint/widget/loyalty_point_list.dart';
import 'package:provider/provider.dart';

class LoyaltyPointScreen extends StatefulWidget {
  const LoyaltyPointScreen({Key? key}) : super(key: key);

  @override
  State<LoyaltyPointScreen> createState() => _LoyaltyPointScreenState();
}

class _LoyaltyPointScreenState extends State<LoyaltyPointScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    bool isFirstTime = true;
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (isFirstTime) {
      if (!isGuestMode) {
        Provider.of<ProfileProvider>(context, listen: false)
            .getUserInfo(context);
        Provider.of<WalletTransactionProvider>(context, listen: false)
            .getLoyaltyPointList(context, 1);
      }

      isFirstTime = false;
    }
    return Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        body: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            Provider.of<WalletTransactionProvider>(context, listen: false)
                .getTransactionList(context, 1, reload: true);
            // return false;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                iconTheme:
                    IconThemeData(color: ColorResources.getTextTitle(context)),
                backgroundColor: Theme.of(context).cardColor,
                title: Text(
                  getTranslated('loyalty_point', context)!,
                  style: TextStyle(color: ColorResources.getTextTitle(context)),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    isGuestMode
                        ? NotLoggedInWidget()
                        : Column(
                            children: [
                              Consumer<ProfileProvider>(
                                  builder: (context, profile, _) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.HOME_PAGE_PADDING),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.PADDING_SIZE_SMALL),
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(.15)),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .PADDING_SIZE_EXTRA_LARGE),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(),
                                                Container(
                                                    width:
                                                        Dimensions.LOGO_HEIGHT,
                                                    height:
                                                        Dimensions.LOGO_HEIGHT,
                                                    child: Image.asset(
                                                        Images.loyalty_trophy)),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        '${(profile.userInfoModel != null && profile.userInfoModel.loyaltyPoint != null) ? profile.userInfoModel.loyaltyPoint ?? 0 : 0}',
                                                        style: robotoBold.copyWith(
                                                            color: ColorResources
                                                                .getTextTitle(
                                                                    context),
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_OVER_LARGE)),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_EXTRA_EXTRA_SMALL),
                                                    Text(
                                                        '${getTranslated('loyalty_point', context)} !',
                                                        style: robotoRegular.copyWith(
                                                            color: ColorResources
                                                                .getTextTitle(
                                                                    context))),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: Dimensions.LOGO_HEIGHT,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top:
                                            Dimensions.PADDING_SIZE_Thirty_Five,
                                        right: Dimensions.PADDING_SIZE_LARGE,
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (con) =>
                                                    LoyaltyPointConverterBottomSheet(
                                                        myPoint: profile
                                                                .userInfoModel
                                                                .loyaltyPoint ??
                                                            0));
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                    '${getTranslated('convert_to_currency', context)}'),
                                                Icon(Icons.keyboard_arrow_down)
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                );
                              }),
                              LoyaltyPointListView(
                                  scrollController: _scrollController),
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
