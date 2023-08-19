import 'dart:convert';

class ProductModel {
  int? _totalSize;
  int? _limit;
  int? _offset;
  List<Product>? _products;

  ProductModel(
      {int? totalSize, int? limit, int? offset, List<Product>? products}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._products = products;
  }

  int get totalSize => _totalSize!;
  int get limit => _limit!;
  int get offset => _offset!;
  List<Product> get products => _products!;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this._totalSize;
    data['limit'] = this._limit;
    data['offset'] = this._offset;
    if (this._products != null) {
      data['products'] = this._products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? _id;
  String? _addedBy;
  int? _userId;
  String? _name;
  String? _slug;
  String? _productType;
  List<CategoryIds>? _categoryIds;
  String? _unit;
  List<String>? _images;
  String? _thumbnail;
  List<ProductColors>? _colors;
  List<String>? _attributes;
  List<ChoiceOptions>? _choiceOptions;
  List<Variation>? _variation;
  double? _unitPrice;
  double? _purchasePrice;
  double? _tax;
  String? _taxModel;
  int? _minQty;
  int? _refundable;
  String? _digitalProductType;
  String? _digitalFileReady;
  String? _taxType;
  double? _discount;
  String? _discountType;
  int? _currentStock;
  String? _details;
  String? _createdAt;
  String? _updatedAt;
  List<Rating>? _rating;
  double? _shippingCost;
  int? _isMultiPly;
  int? _reviewCount;
  String? _videoUrl;
  int? _minimumOrderQty;

  Product({
    int? id,
    String? addedBy,
    int? userId,
    String? name,
    String? slug,
    String? productType,
    List<CategoryIds>? categoryIds,
    String? unit,
    int? minQty,
    int? refundable,
    String? digitalProductType,
    String? digitalFileReady,
    List<String>? images,
    String? thumbnail,
    List<ProductColors>? colors,
    String? variantProduct,
    List<String>? attributes,
    List<ChoiceOptions>? choiceOptions,
    List<Variation>? variation,
    double? unitPrice,
    double? purchasePrice,
    double? tax,
    String? taxModel,
    String? taxType,
    double? discount,
    String? discountType,
    int? currentStock,
    String? details,
    String? attachment,
    String? createdAt,
    String? updatedAt,
    int? featuredStatus,
    List<Rating>? rating,
    double? shippingCost,
    int? isMultiPly,
    int? reviewCount,
    String? videoUrl,
    int? minimumOrderQty,
  }) {
    this._id = id!;
    this._addedBy = addedBy!;
    this._userId = userId!;
    this._name = name!;
    this._slug = slug!;
    this._categoryIds = categoryIds!;
    this._unit = unit!;
    this._minQty = minQty!;
    if (refundable != null) {
      this._refundable = refundable;
    }
    if (digitalProductType != null) {
      this._digitalProductType = digitalProductType;
    }
    if (digitalFileReady != null) {
      this._digitalFileReady = digitalFileReady;
    }
    this._images = images!;
    this._thumbnail = thumbnail!;
    this._colors = colors!;
    this._attributes = attributes!;
    this._choiceOptions = choiceOptions!;
    this._variation = variation!;
    this._unitPrice = unitPrice!;
    this._purchasePrice = purchasePrice!;
    this._tax = tax!;
    this._taxModel = taxModel!;
    this._taxType = taxType!;
    this._discount = discount!;
    this._discountType = discountType!;
    this._currentStock = currentStock!;
    this._details = details!;
    this._createdAt = createdAt!;
    this._updatedAt = updatedAt!;
    this._rating = rating!;
    this._shippingCost = shippingCost!;
    this._isMultiPly = isMultiPly!;
    this._reviewCount = reviewCount!;
    if (videoUrl != null) {
      this._videoUrl = videoUrl;
    }
    this._minimumOrderQty = minimumOrderQty!;
  }

  int get id => _id!;
  String get addedBy => _addedBy!;
  int get userId => _userId!;
  String get name => _name!;
  String get slug => _slug!;
  String get productType => _productType!;
  List<CategoryIds> get categoryIds => _categoryIds!;
  String get unit => _unit!;
  int get minQty => _minQty!;
  int get refundable => _refundable!;
  String get digitalProductType => _digitalProductType!;
  String get digitalFileReady => _digitalFileReady!;
  List<String> get images => _images!;
  String get thumbnail => _thumbnail!;
  List<ProductColors> get colors => _colors!;
  List<String> get attributes => _attributes!;
  List<ChoiceOptions> get choiceOptions => _choiceOptions!;
  List<Variation> get variation => _variation!;
  double get unitPrice => _unitPrice!;
  double get purchasePrice => _purchasePrice!;
  double get tax => _tax!;
  String get taxModel => _taxModel!;
  String get taxType => _taxType!;
  double get discount => _discount!;
  String get discountType => _discountType!;
  int get currentStock => _currentStock!;
  String get details => _details!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;
  List<Rating>? get rating => _rating;
  double get shippingCost => _shippingCost!;
  int get isMultiPly => _isMultiPly!;
  int get reviewCount => _reviewCount!;
  String get videoUrl => _videoUrl!;
  int get minimumOrderQuantity => _minimumOrderQty!;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addedBy = json['added_by'];
    _userId = json['user_id'];
    _name = json['name'];
    _slug = json['slug'];
    _productType = json['product_type'];
    if (json['category_ids'] != null) {
      _categoryIds = [];
      try {
        json['category_ids'].forEach((v) {
          _categoryIds!.add(new CategoryIds.fromJson(v));
        });
      } catch (e) {
        jsonDecode(json['category_ids']).forEach((v) {
          _categoryIds!.add(new CategoryIds.fromJson(v));
        });
      }
    }
    _unit = json['unit'];
    _minQty = json['min_qty'];

    if (json['refundable'] != null) {
      _refundable = int.parse(json['refundable'].toString());
    }
    if (json['digital_product_type'] != null) {
      _digitalProductType = json['digital_product_type'];
    }
    if (json['digital_file_ready'] != null) {
      _digitalFileReady = json['digital_file_ready'];
    }

    if (json['images'] != null) {
      try {
        _images = json['images'] != null ? json['images'].cast<String>() : [];
      } catch (e) {
        _images = json['images'] != null
            ? jsonDecode(json['images']).cast<String>()
            : [];
      }
    }

    _thumbnail = json['thumbnail'];
    if (json['colors_formatted'] != null) {
      _colors = [];
      try {
        json['colors_formatted'].forEach((v) {
          _colors!.add(new ProductColors.fromJson(v));
        });
      } catch (e) {
        jsonDecode(json['colors_formatted']).forEach((v) {
          _colors!.add(new ProductColors.fromJson(v));
        });
      }
    }
    if (json['attributes'] != null) {
      try {
        _attributes = json['attributes'].cast<String>();
      } catch (e) {
        _attributes = jsonDecode(json['attributes']).cast<String>();
      }
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      try {
        json['choice_options'].forEach((v) {
          _choiceOptions!.add(new ChoiceOptions.fromJson(v));
        });
      } catch (e) {
        jsonDecode(json['choice_options']).forEach((v) {
          _choiceOptions!.add(new ChoiceOptions.fromJson(v));
        });
      }
    }
    if (json['variation'] != null) {
      _variation = [];
      try {
        json['variation'].forEach((v) {
          _variation!.add(new Variation.fromJson(v));
        });
      } catch (e) {
        jsonDecode(json['variation']).forEach((v) {
          _variation!.add(new Variation.fromJson(v));
        });
      }
    }
    if (json['unit_price'] != null) {
      _unitPrice = json['unit_price'].toDouble();
    }
    if (json['purchase_price'] != null) {
      _purchasePrice = json['purchase_price'].toDouble();
    }

    if (json['tax'] != null) {
      _tax = json['tax'].toDouble();
    }

    if (json['tax_model'] != null) {
      _taxModel = json['tax_model'];
    }
    _taxType = json['tax_type'];
    if (json['discount'] != null) {
      _discount = json['discount'].toDouble();
    }
    _discountType = json['discount_type'];
    _currentStock = json['current_stock'];
    _details = json['details'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['rating'] != null) {
      _rating = [];
      json['rating'].forEach((v) {
        _rating!.add(new Rating.fromJson(v));
      });
    } else {}
    if (json['shipping_cost'] != null) {
      _shippingCost = double.parse(json['shipping_cost'].toString());
    }
    if (json['multiply_qty'] != null) {
      _isMultiPly = int.parse(json['multiply_qty'].toString());
    }
    if (json['reviews_count'] != null) {
      _reviewCount = int.parse(json['reviews_count'].toString());
    }
    _videoUrl = json['video_url'];
    if (json['minimum_order_qty'] != null) {
      try {
        _minimumOrderQty = json['minimum_order_qty'];
      } catch (e) {
        _minimumOrderQty = int.parse(json['minimum_order_qty'].toString());
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['added_by'] = this._addedBy;
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['slug'] = this._slug;
    data['product_type'] = this._productType;
    if (this._categoryIds != null) {
      data['category_ids'] = this._categoryIds!.map((v) => v.toJson()).toList();
    }
    data['unit'] = this._unit;
    data['min_qty'] = this._minQty;
    data['images'] = this._images;
    data['thumbnail'] = this._thumbnail;
    if (this._colors != null) {
      data['colors_formatted'] = this._colors!.map((v) => v.toJson()).toList();
    }
    data['attributes'] = this._attributes;
    if (this._choiceOptions != null) {
      data['choice_options'] =
          this._choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (this._variation != null) {
      data['variation'] = this._variation!.map((v) => v.toJson()).toList();
    }
    data['unit_price'] = this._unitPrice;
    data['purchase_price'] = this._purchasePrice;
    data['tax'] = this._tax;
    data['tax_model'] = this._taxModel;
    data['tax_type'] = this._taxType;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['current_stock'] = this._currentStock;
    data['details'] = this._details;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._rating != null) {
      data['rating'] = this._rating!.map((v) => v.toJson()).toList();
    }
    data['shipping_cost'] = this._shippingCost;
    data['multiply_qty'] = this._isMultiPly;
    data['reviews_count'] = this._reviewCount;
    data['video_url'] = this._videoUrl;
    data['minimum_order_qty'] = this._minimumOrderQty;
    return data;
  }
}

class CategoryIds {
  int? _position;

  CategoryIds({int? position}) {
    this._position = position;
  }

  int get position => _position!;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this._position;
    return data;
  }
}

class ProductColors {
  String? _name;
  String? _code;

  ProductColors({String? name, String? code}) {
    this._name = name;
    this._code = code;
  }

  String get name => _name!;
  String get code => _code!;

  ProductColors.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['code'] = this._code;
    return data;
  }
}

class ChoiceOptions {
  String? _name;
  String? _title;
  List<String>? _options;

  ChoiceOptions({String? name, String? title, List<String>? options}) {
    this._name = name;
    this._title = title;
    this._options = options;
  }

  String get name => _name!;
  String get title => _title!;
  List<String> get options => _options!;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    if (json['options'] != null) {
      _options = json['options'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['title'] = this._title;
    data['options'] = this._options;
    return data;
  }
}

class Variation {
  String? _type;
  double? _price;
  String? _sku;
  int? _qty;

  Variation({String? type, double? price, String? sku, int? qty}) {
    this._type = type;
    this._price = price;
    this._sku = sku;
    this._qty = qty;
  }

  String get type => _type!;
  double get price => _price!;
  String get sku => _sku!;
  int get qty => _qty!;

  Variation.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _price = json['price'].toDouble();
    _sku = json['sku'];
    _qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['price'] = this._price;
    data['sku'] = this._sku;
    data['qty'] = this._qty;
    return data;
  }
}

class Rating {
  String? _average;
  int? _productId;

  Rating({String? average, int? productId}) {
    this._average = average;
    this._productId = productId;
  }

  String get average => _average!;
  int get productId => _productId!;

  Rating.fromJson(Map<String, dynamic> json) {
    _average = json['average'].toString();
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this._average;
    data['product_id'] = this._productId;
    return data;
  }
}
