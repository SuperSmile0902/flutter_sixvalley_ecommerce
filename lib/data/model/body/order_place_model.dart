import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';

class OrderPlaceModel {
  String _paymentMethod = '';
  double _discount = 0.0;

  OrderPlaceModel(String paymentMethod, double discount) {
    this._paymentMethod = paymentMethod;
    this._discount = discount;
  }

  String get paymentMethod => _paymentMethod;
  double get discount => _discount;

  OrderPlaceModel.fromJson(Map<String, dynamic> json) {
    _paymentMethod = json['payment_method'];
    _discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['payment_method'] = this._paymentMethod;
    data['discount'] = this._discount;
    return data;
  }
}
