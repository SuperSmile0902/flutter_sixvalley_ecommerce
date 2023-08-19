import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';

class CartModel {
  int? _id;
  int? _productId;
  String? _image;
  String? _name;
  String? _thumbnail;
  int? _sellerId;
  String? _sellerIs;
  String? _seller;
  double? _price;
  double? _discountedPrice;
  int? _quantity;
  int? _maxQuantity;
  String? _variant;
  String? _color;
  Variation? _variation;
  double? _discount;
  String? _discountType;
  double? _tax;
  String? _taxModel;
  String? _taxType;
  int? shippingMethodId;
  String? _cartGroupId;
  String? _shopInfo;
  List<ChoiceOptions>? _choiceOptions;
  List<int>? _variationIndexes;
  double? _shippingCost;
  String? _shippingType;
  int? _minimumOrderQuantity;
  ProductInfo? _productInfo;
  String? _productType;
  String? _slug;

  CartModel(
      this._id,
      this._productId,
      this._thumbnail,
      this._name,
      this._seller,
      this._price,
      this._discountedPrice,
      this._quantity,
      this._maxQuantity,
      this._variant,
      this._color,
      this._variation,
      this._discount,
      this._discountType,
      this._tax,
      this._taxModel,
      this._taxType,
      this.shippingMethodId,
      this._cartGroupId,
      this._sellerId,
      this._sellerIs,
      this._image,
      this._shopInfo,
      this._choiceOptions,
      this._variationIndexes,
      this._shippingCost,
      this._minimumOrderQuantity,
      this._productType,
      this._slug);

  String? get variant => _variant;
  String? get color => _color;
  Variation? get variation => _variation;
  // ignore: unnecessary_getters_setters
  int get quantity => _quantity!;
  // ignore: unnecessary_getters_setters
  set quantity(int value) {
    _quantity = value;
  }

  int? get maxQuantity => _maxQuantity;
  double? get price => _price;
  double? get discountedPrice => _discountedPrice;
  String? get name => _name;
  String? get seller => _seller;
  String? get image => _image;
  int? get id => _id;
  int? get productId => _productId;
  double? get discount => _discount;
  String? get discountType => _discountType;
  double? get tax => _tax;
  String? get taxModel => _taxModel;
  String? get taxType => _taxType;
  String? get cartGroupId => _cartGroupId;
  String? get sellerIs => _sellerIs;
  int? get sellerId => _sellerId;
  String? get thumbnail => _thumbnail;
  String? get shopInfo => _shopInfo;
  List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  List<int>? get variationIndexes => _variationIndexes;
  double? get shippingCost => _shippingCost;
  String? get shippingType => _shippingType;
  int? get minimumOrderQuantity => _minimumOrderQuantity;
  ProductInfo? get productInfo => _productInfo;
  String? get productType => _productType;
  String? get slug => _slug;

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = int.parse(json['product_id'].toString());
    _name = json['name'];
    _seller = json['seller'];
    _thumbnail = json['thumbnail'];
    _sellerId = int.parse(json['seller_id'].toString());
    _sellerIs = json['seller_is'];
    _image = json['image'];
    _price = json['price'].toDouble();
    _discountedPrice = json['discounted_price'];
    _quantity = int.parse(json['quantity'].toString());
    _maxQuantity = json['max_quantity'];
    _variant = json['variant'];
    _color = json['color'];
    _variation = json['variation'] != null
        ? Variation.fromJson(json['variation'])
        : null;
    _discount = json['discount'].toDouble();
    _discountType = json['discount_type'];
    _tax = json['tax'].toDouble();
    _taxModel = json['tax_model'];
    _taxType = json['tax_type'];
    shippingMethodId = json['shipping_method_id'];
    _cartGroupId = json['cart_group_id'];
    _shopInfo = json['shop_info'];
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      json['choice_options'].forEach((v) {
        _choiceOptions!.add(new ChoiceOptions.fromJson(v));
      });
    }
    _variationIndexes = json['variation_indexes'] != null
        ? json['variation_indexes'].cast<int>()
        : [];
    if (json['shipping_cost'] != null) {
      _shippingCost = double.parse(json['shipping_cost'].toString());
    }
    if (json['shipping_type'] != null) {
      _shippingType = json['shipping_type'];
    }
    _productInfo = json['product'] != null
        ? new ProductInfo.fromJson(json['product'])
        : null;
    _productType = json['product_type'];
    _slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['product_id'] = this._productId;
    data['name'] = this._name;
    data['seller'] = this._seller;
    data['image'] = this._image;
    data['price'] = this._price;
    data['discounted_price'] = this._discountedPrice;
    data['quantity'] = this._quantity;
    data['max_quantity'] = this._maxQuantity;
    data['variant'] = this._variant;
    data['color'] = this._color;
    data['variation'] = this._variation;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['tax'] = this._tax;
    data['tax_model'] = this._taxModel;
    data['tax_type'] = this._taxType;
    data['shipping_method_id'] = this.shippingMethodId;
    data['cart_group_id'] = this._cartGroupId;
    data['thumbnail'] = this._thumbnail;
    data['seller_id'] = this._sellerId;
    data['seller_is'] = this._sellerIs;
    data['shop_info'] = this._shopInfo;
    if (this._choiceOptions != null) {
      data['choice_options'] =
          this._choiceOptions!.map((v) => v.toJson()).toList();
    }
    data['variation_indexes'] = this._variationIndexes;
    data['shipping_cost'] = this._shippingCost;
    data['_shippingType'] = this._shippingType;
    data['product_type'] = this._productType;
    data['slug'] = this._slug;

    return data;
  }
}

class ProductInfo {
  int minimumOrderQty = 0;
  int totalCurrentStock = 0;

  ProductInfo({required this.minimumOrderQty, required this.totalCurrentStock});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    if (json['minimum_order_qty'] != null) {
      try {
        minimumOrderQty = json['minimum_order_qty'];
      } catch (e) {
        minimumOrderQty = int.parse(json['minimum_order_qty'].toString());
      }
    }
    totalCurrentStock = json['total_current_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum_order_qty'] = this.minimumOrderQty;
    data['total_current_stock'] = this.totalCurrentStock;
    return data;
  }
}
