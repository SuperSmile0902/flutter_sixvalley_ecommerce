class SellerModel {
  Seller? _seller;
  int? _avgRating;
  int? _totalReview;
  int? _totalOrder;
  int? _totalProduct;

  SellerModel(
      {Seller? seller,
      int? avgRating,
      int? totalReview,
      int? totalOrder,
      int? totalProduct}) {
    if (seller != null) {
      this._seller = seller;
    }
    if (avgRating != null) {
      this._avgRating = avgRating;
    }
    if (totalReview != null) {
      this._totalReview = totalReview;
    }
    if (totalOrder != null) {
      this._totalOrder = totalOrder;
    }
    if (totalProduct != null) {
      this._totalProduct = totalProduct;
    }
  }

  Seller get seller => _seller!;
  int get avgRating => _avgRating!;
  int get totalReview => _totalReview!;
  int get totalOrder => _totalOrder!;
  int get totalProduct => _totalProduct!;

  SellerModel.fromJson(Map<String, dynamic> json) {
    _seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    _avgRating = json['avg_rating'];
    _totalReview = json['total_review'];
    _totalOrder = json['total_order'];
    _totalProduct = json['total_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._seller != null) {
      data['seller'] = this._seller!.toJson();
    }
    data['avg_rating'] = this._avgRating;
    data['total_review'] = this._totalReview;
    data['total_order'] = this._totalOrder;
    data['total_product'] = this._totalProduct;
    return data;
  }
}

class Seller {
  int? _id;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _image;
  Shop? _shop;

  Seller(
      {int? id,
      String? fName,
      String? lName,
      String? phone,
      String? image,
      Shop? shop}) {
    if (id != null) {
      this._id = id;
    }
    if (fName != null) {
      this._fName = fName;
    }
    if (lName != null) {
      this._lName = lName;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (image != null) {
      this._image = image;
    }
    if (shop != null) {
      this._shop = shop;
    }
  }

  int get id => _id!;
  String get fName => _fName!;
  String get lName => _lName!;
  String get phone => _phone!;
  String get image => _image!;
  Shop get shop => _shop!;

  Seller.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _image = json['image'];
    _shop = (json['shop'] != null ? new Shop.fromJson(json['shop']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['f_name'] = this._fName;
    data['l_name'] = this._lName;
    data['phone'] = this._phone;
    data['image'] = this._image;
    if (this._shop != null) {
      data['shop'] = this._shop!.toJson();
    }
    return data;
  }
}

class Shop {
  int? _id;
  int? _sellerId;
  String? _name;
  String? _address;
  String? _contact;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _banner;
  int? _temporaryClose;
  String? _vacationEndDate;
  String? _vacationStartDate;
  int? _vacationStatus;

  Shop(
      {int? id,
      int? sellerId,
      String? name,
      String? address,
      String? contact,
      String? image,
      String? createdAt,
      String? updatedAt,
      String? banner,
      int? temporaryClose,
      String? vacationEndDate,
      String? vacationStartDate,
      int? vacationStatus}) {
    if (id != null) {
      this._id = id;
    }
    if (sellerId != null) {
      this._sellerId = sellerId;
    }
    if (name != null) {
      this._name = name;
    }
    if (address != null) {
      this._address = address;
    }
    if (contact != null) {
      this._contact = contact;
    }
    if (image != null) {
      this._image = image;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (banner != null) {
      this._banner = banner;
    }
    this._temporaryClose = temporaryClose;
    this._vacationEndDate = vacationEndDate;
    this._vacationStartDate = vacationStartDate;
    this._vacationStatus = vacationStatus;
  }

  int get id => _id!;
  int get sellerId => _sellerId!;
  String get name => _name!;
  String get address => _address!;
  String get contact => _contact!;
  String get image => _image!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;
  String get banner => _banner!;
  int get temporaryClose => _temporaryClose!;
  String get vacationEndDate => _vacationEndDate!;
  String get vacationStartDate => _vacationStartDate!;
  int get vacationStatus => _vacationStatus!;

  Shop.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _sellerId = int.parse(json['seller_id'].toString());
    _name = json['name'];
    _address = json['address'];
    _contact = json['contact'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _banner = json['banner'];
    _temporaryClose = json['temporary_close'] != null
        ? int.parse(json['temporary_close'].toString())
        : 0;
    _vacationEndDate = json['vacation_end_date'];
    _vacationStartDate = json['vacation_start_date'];
    _vacationStatus = json['vacation_status'] != null
        ? int.parse(json['vacation_status'].toString())
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['seller_id'] = this._sellerId;
    data['name'] = this._name;
    data['address'] = this._address;
    data['contact'] = this._contact;
    data['image'] = this._image;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['banner'] = this._banner;
    data['temporary_close'] = this._temporaryClose;
    data['vacation_end_date'] = this._vacationEndDate;
    data['vacation_start_date'] = this._vacationEndDate;
    data['vacation_status'] = this._vacationStatus;

    return data;
  }
}
