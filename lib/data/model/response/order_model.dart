class OrderModel {
  int? _id;
  int? _customerId;
  String? _customerType;
  String? _paymentStatus;
  String? _orderStatus;
  String? _paymentMethod;
  String? _transactionRef;
  double? _orderAmount;
  int?_shippingAddress;
  int?_billingAddress;
  ShippingAddressData? _shippingAddressData;
  BillingAddressData ?_billingAddressData;
  int? _sellerId;
  int? _shippingMethodId;
  double?_shippingCost;
  String?_createdAt;
  String?_updatedAt;
  double?_discountAmount;
  String?_discountType;
  String?_orderNote;
  String?_orderType;
  double?_extraDiscount;
  String?_extraDiscountType;
  String?_thirdPartyServiceName;
  String?_thirdPartyTrackingId;
  DeliveryMan ?_deliveryMan;


  OrderModel(
      {int ?id,
        int? customerId,
        String? customerType,
        String? paymentStatus,
        String? orderStatus,
        String? paymentMethod,
        String? transactionRef,
        double? orderAmount,
        int? shippingAddress,
        int? billingAddress,
        ShippingAddressData? shippingAddressData,
        BillingAddressData ?billingAddressData,
        int?sellerId,
        int?shippingMethodId,
        double? shippingCost,
        String? createdAt,
        String? updatedAt,
        double? discountAmount,
        String? discountType,
        String? orderNote,
        String? orderType,
        double? extraDiscount,
        String? extraDiscountType,
        String? thirdPartyServiceNam,
        String? thirdPartyTrackingId,
        DeliveryMan? deliveryMan
      }) {
    this._id = id;
    this._customerId = customerId;
    this._customerType = customerType;
    this._paymentStatus = paymentStatus;
    this._orderStatus = orderStatus;
    this._paymentMethod = paymentMethod;
    this._transactionRef = transactionRef;
    this._orderAmount = orderAmount;
    this._shippingAddress = shippingAddress;
    if (shippingAddressData != null) {
      this._shippingAddressData = shippingAddressData;
    }
    this._billingAddress = billingAddress;
    this._billingAddressData = billingAddressData;
    this._sellerId = sellerId;
    this._shippingCost = shippingCost;
    this._shippingMethodId = shippingMethodId;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._discountAmount = discountAmount;
    this._discountType = discountType;
    this._orderNote = orderNote;
    this._orderType = orderType;
    if (extraDiscount != null) {
      this._extraDiscount = extraDiscount;
    }
    if (extraDiscountType != null) {
      this._extraDiscountType = extraDiscountType;
    }
    if (thirdPartyServiceNam != null) {
      this._thirdPartyServiceName = thirdPartyServiceNam;
    }
    if (thirdPartyTrackingId != null) {
      this._thirdPartyTrackingId = thirdPartyTrackingId;
    }
    if (deliveryMan != null) {
      this._deliveryMan = deliveryMan;
    }

  }

  int get id => _id!;
  int get customerId => _customerId!;
  String get customerType => _customerType!;
  String get paymentStatus => _paymentStatus!;
  String get orderStatus => _orderStatus!;
  String get paymentMethod => _paymentMethod!;
  String get transactionRef => _transactionRef!;
  double get orderAmount => _orderAmount!;
  int get shippingAddress => _shippingAddress!;
  ShippingAddressData get shippingAddressData => _shippingAddressData!;
  int get billingAddress => _billingAddress!;
  BillingAddressData get billingAddressData => _billingAddressData!;
  int get shippingMethodId => _shippingMethodId!;
  int get sellerId => _sellerId!;
  double get shippingCost => _shippingCost!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;
  double get discountAmount => _discountAmount!;
  String get discountType => _discountType!;
  String get orderNote => _orderNote!;
  String get orderType => _orderType!;
  double get extraDiscount => _extraDiscount!;
  String get extraDiscountType => _extraDiscountType!;
  String get  thirdPartyServiceName => _thirdPartyServiceName!;
  String get  thirdPartyTrackingId => _thirdPartyTrackingId!;
  DeliveryMan get deliveryMan => _deliveryMan!;

  OrderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _customerType = json['customer_type'];
    _paymentStatus = json['payment_status'];
    _orderStatus = json['order_status'];
    _paymentMethod = json['payment_method'];
    _transactionRef = json['transaction_ref'];
    _orderAmount = json['order_amount'].toDouble();
    _shippingAddress = json['shipping_address'];
    _shippingAddressData = json['shipping_address_data'] != null
        ? new ShippingAddressData.fromJson(json['shipping_address_data'])
        : null;
    _billingAddress = json['billing_address'];
    _billingAddressData = json['billing_address_data'] != null
        ? new BillingAddressData.fromJson(json['billing_address_data'])
        : null;

    if(json['seller_id'] !=null && json['seller_id'] != ''){
      _sellerId = json['seller_id'];
    }
    _shippingMethodId = int.parse(json['shipping_method_id'].toString());
    _shippingCost = double.parse(json['shipping_cost'].toString());
    if(json['created_at'] != null){
      _createdAt = json['created_at'];
    }
    _updatedAt = json['updated_at'];
    _discountAmount = json['discount_amount'].toDouble();
    _discountType = json['discount_type'];
    _orderNote = json['order_note'];
    _orderType = json['order_type'];
    _extraDiscount = json['extra_discount'].toDouble();
    _extraDiscountType = json['extra_discount_type'];
    if(json['delivery_service_name']!=null && json['delivery_service_name']!= ""){
      _thirdPartyServiceName = json['delivery_service_name'];
    }
    if(json['third_party_delivery_tracking_id']!=null && json['third_party_delivery_tracking_id']!= ""){
      _thirdPartyTrackingId = json['third_party_delivery_tracking_id'];
    }
    _deliveryMan = json['delivery_man'] != null
        ? new DeliveryMan.fromJson(json['delivery_man'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['customer_id'] = this._customerId;
    data['customer_type'] = this._customerType;
    data['payment_status'] = this._paymentStatus;
    data['order_status'] = this._orderStatus;
    data['payment_method'] = this._paymentMethod;
    data['transaction_ref'] = this._transactionRef;
    data['order_amount'] = this._orderAmount;
    data['shipping_address'] = this._shippingAddress;
    if (this._shippingAddressData != null) {
      data['shipping_address_data'] = this._shippingAddressData!.toJson();
    }
    data['billing_address'] = this._billingAddress;
    if (this.billingAddressData != null) {
      data['billing_address_data'] = this.billingAddressData.toJson();
    }
    data['shipping_method_id'] = this._shippingMethodId;
    data['seller_id'] = this._sellerId;
    data['shipping_cost'] = this._shippingCost;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['discount_amount'] = this._discountAmount;
    data['discount_type'] = this._discountType;
    data['order_note'] = this._orderNote;
    data['order_type'] = this._orderType;
    data['extra_discount'] = this._extraDiscount;
    data['extra_discount_type'] = this._extraDiscountType;
    data['delivery_service_name'] = this._thirdPartyServiceName;
    data['third_party_delivery_tracking_id'] = this._thirdPartyTrackingId;
    if (this._deliveryMan != null) {
      data['delivery_man'] = this._deliveryMan!.toJson();
    }

    return data;
  }
}
class BillingAddressData {
  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? country;
  String? latitude;
  String? longitude;
  int ?isBilling;

  BillingAddressData(
      {this.id,
        this.customerId,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.country,
        this.latitude,
        this.longitude,
        this.isBilling});

  BillingAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isBilling = json['is_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['contact_person_name'] = this.contactPersonName;
    data['address_type'] = this.addressType;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_billing'] = this.isBilling;
    return data;
  }
}

class ShippingAddressData {
  int? _id;
  int? _customerId;
  String? _contactPersonName;
  String? _addressType;
  String? _address;
  String? _city;
  String? _zip;
  String? _phone;
  String? _createdAt;
  String? _updatedAt;
  String? _country;

  ShippingAddressData(
      {int ?id,
        int? customerId,
        String? contactPersonName,
        String? addressType,
        String? address,
        String? city,
        String? zip,
        String? phone,
        String? createdAt,
        String? updatedAt,
        Null state,
        String? country}) {
    if (id != null) {
      this._id = id;
    }
    if (customerId != null) {
      this._customerId = customerId;
    }
    if (contactPersonName != null) {
      this._contactPersonName = contactPersonName;
    }
    if (addressType != null) {
      this._addressType = addressType;
    }
    if (address != null) {
      this._address = address;
    }
    if (city != null) {
      this._city = city;
    }
    if (zip != null) {
      this._zip = zip;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }

    if (country != null) {
      this._country = country;
    }
  }

  int get id => _id!;
  int get customerId => _customerId!;
  String get contactPersonName => _contactPersonName!;
  String get addressType => _addressType!;
  String get address => _address!;
  String get city => _city!;
  String get zip => _zip!;
  String get phone => _phone!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;
  String get country => _country!;


  ShippingAddressData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _contactPersonName = json['contact_person_name'];
    _addressType = json['address_type'];
    _address = json['address'];
    _city = json['city'];
    _zip = json['zip'];
    _phone = json['phone'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['customer_id'] = this._customerId;
    data['contact_person_name'] = this._contactPersonName;
    data['address_type'] = this._addressType;
    data['address'] = this._address;
    data['city'] = this._city;
    data['zip'] = this._zip;
    data['phone'] = this._phone;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['country'] = this._country;
    return data;
  }
}

class DeliveryMan {
  int? _id;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _email;
  String? _image;
  DeliveryMan(
      {
        int? id,
        String? fName,
        String? lName,
        String? phone,
        String? email,
        String? image
      }) {

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
    if (email != null) {
      this._email = email;
    }

    if (image != null) {
      this._image = image;
    }

  }


  int get id => _id!;
  String get fName => _fName!;
  String get lName => _lName!;
  String get phone => _phone!;
  String get email => _email!;
  String get image => _image!;

  DeliveryMan.fromJson(Map<String, dynamic> json) {

    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _email = json['email'];
    _image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this._id;
    data['f_name'] = this._fName;
    data['l_name'] = this._lName;
    data['phone'] = this._phone;
    data['email'] = this._email;
    data['image'] = this._image;
    return data;
  }
}