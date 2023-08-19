import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class InboxShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
            child: Row(children: [
              CircleAvatar(child: Icon(Icons.person), radius: 30),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    Container(height: 15, color: ColorResources.WHITE),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container(height: 15, color: ColorResources.WHITE),
                  ]),
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(height: 10, width: 30, color: ColorResources.WHITE),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                ),
              ])
            ]),
          ),
        );
      },
    );
  }
}
