import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/seller_model.dart';

import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/rating_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/search_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:provider/provider.dart';

class SellerScreen extends StatefulWidget {
  final SellerModel seller;
  SellerScreen({required this.seller});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  ScrollController _scrollController = ScrollController();

  void _load() {
    Provider.of<ProductProvider>(context, listen: false).removeFirstLoading();
    Provider.of<ProductProvider>(context, listen: false).clearSellerData();
    Provider.of<ProductProvider>(context, listen: false)
        .initSellerProductList(widget.seller.seller.id.toString(), 1, context);
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    String ratting = widget.seller != null && widget.seller.avgRating != null
        ? widget.seller.avgRating.toString()
        : "0";

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(
              title: '${widget.seller.seller.fName}' +
                  ' ' '${widget.seller.seller.lName}'),
          Expanded(
            child: ListView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              children: [
                // Banner
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      height: 120,
                      fit: BoxFit.cover,
                      image:
                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/banner/${widget.seller.seller.shop != null ? widget.seller.seller.shop.banner : ''}',
                      imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.placeholder,
                          height: 120,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),

                Container(
                  color: Theme.of(context).highlightColor,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    // Seller Info
                    Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          image:
                              '${Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/${widget.seller.seller.shop.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(
                              Images.placeholder,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.seller.seller.shop.name,
                              style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                RatingBar(rating: double.parse(ratting)),
                                Text(
                                  '(${widget.seller.totalReview.toString()})',
                                  style: titilliumRegular.copyWith(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            Row(
                              children: [
                                Text(
                                  widget.seller.totalReview.toString() +
                                      ' ' +
                                      '${getTranslated('reviews', context)}',
                                  style: titleRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color:
                                          ColorResources.getReviewRattingColor(
                                              context)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT),
                                Text('|'),
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT),
                                Text(
                                  widget.seller.totalProduct.toString() +
                                      ' ' +
                                      '${getTranslated('products', context)}',
                                  style: titleRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color:
                                          ColorResources.getReviewRattingColor(
                                              context)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!Provider.of<AuthProvider>(context, listen: false)
                              .isLoggedIn()) {
                            showAnimatedDialog(context, GuestDialog(),
                                isFlip: true);
                          } else if (widget.seller != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                          id: widget.seller.seller.id,
                                          name: widget.seller.seller.shop.name,
                                        )));
                          }
                        },
                        icon: Image.asset(Images.chat_image,
                            color: ColorResources.SELLER_TXT,
                            height: Dimensions.ICON_SIZE_DEFAULT),
                      ),
                    ]),
                  ]),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_SMALL,
                      right: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                  child: SearchWidget(
                    hintText: 'Search product...',
                    onTextChanged: (String newText) =>
                        Provider.of<ProductProvider>(context, listen: false)
                            .filterData(newText),
                    onClearPressed: () {},
                    isSeller: true,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: ProductView(
                      isHomePage: false,
                      productType: ProductType.SELLER_PRODUCT,
                      scrollController: _scrollController,
                      sellerId: widget.seller.seller.id.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
