import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';

class FeaturedDealModel {
  Product? product;

  FeaturedDealModel({this.product});

  FeaturedDealModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
