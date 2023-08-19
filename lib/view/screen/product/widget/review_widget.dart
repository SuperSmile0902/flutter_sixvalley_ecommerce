import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/review_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/image_diaglog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewModel;
  ReviewWidget({required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder,
              height: Dimensions.chooseReviewImageSize,
              width: Dimensions.chooseReviewImageSize,
              fit: BoxFit.cover,
              image:
                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/${reviewModel.customer != null ? reviewModel.customer.image : ''}',
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                  height: Dimensions.chooseReviewImageSize,
                  width: Dimensions.chooseReviewImageSize,
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(
                '${reviewModel.customer == null ? getTranslated('user_not_exist', context) : reviewModel.customer.fName ?? ''} ${reviewModel.customer == null ? '' : reviewModel.customer.lName ?? ''}',
                style: titilliumRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_DEFAULT),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            ]),
            Row(children: [
              Icon(Icons.star, color: Colors.orange),
              Text(
                '${reviewModel.rating.toDouble()}' + ' ' + '/5',
                style: titilliumRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_DEFAULT),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ]),
          ]),
        ]),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text(
            reviewModel.comment ?? '',
            textAlign: TextAlign.left,
            style: titilliumRegular.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: Dimensions.FONT_SIZE_DEFAULT),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        (reviewModel.attachment != null && reviewModel.attachment.length > 0)
            ? SizedBox(
                height: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: reviewModel.attachment.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => ImageDialog(
                                imageUrl:
                                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.reviewImageUrl}/review/${reviewModel.attachment[index]}'));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_SMALL),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            height: Dimensions.chooseReviewImageSize,
                            width: Dimensions.chooseReviewImageSize,
                            fit: BoxFit.cover,
                            image:
                                '${Provider.of<SplashProvider>(context, listen: false).baseUrls.reviewImageUrl}/review/${reviewModel.attachment[index]}',
                            imageErrorBuilder: (c, o, s) => Image.asset(
                                Images.placeholder,
                                height: Dimensions.chooseReviewImageSize,
                                width: Dimensions.chooseReviewImageSize,
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : SizedBox(),
      ]),
    );
  }
}

class ReviewShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: Provider.of<ProductDetailsProvider>(context).reviewList == null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(
            maxRadius: 15,
            backgroundColor: ColorResources.SELLER_TXT,
            child: Icon(Icons.person),
          ),
          SizedBox(width: 5),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(height: 10, width: 50, color: ColorResources.WHITE),
              SizedBox(width: 5),
              RatingBar(rating: 0, size: 12),
            ]),
            Container(height: 10, width: 50, color: ColorResources.WHITE),
          ]),
        ]),
        SizedBox(height: 5),
        Container(height: 20, width: 200, color: ColorResources.WHITE),
      ]),
    );
  }
}
