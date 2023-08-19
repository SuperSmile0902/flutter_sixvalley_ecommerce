class LoyaltyPointModel {
  int _limit = 0;
  int _offset = 0;
  int _totalLoyaltyPoint = 0;
  List<LoyaltyPointList> _loyaltyPointList = [];

  LoyaltyPointModel(
      {int? limit,
      int? offset,
      int? totalLoyaltyPoint,
      List<LoyaltyPointList>? loyaltyPointList}) {
    if (limit != null) {
      this._limit = limit;
    }
    if (offset != null) {
      this._offset = offset;
    }
    if (totalLoyaltyPoint != null) {
      this._totalLoyaltyPoint = totalLoyaltyPoint;
    }
    if (loyaltyPointList != null) {
      this._loyaltyPointList = loyaltyPointList;
    }
  }

  int get limit => _limit;
  int get offset => _offset;
  int get totalLoyaltyPoint => _totalLoyaltyPoint;
  List<LoyaltyPointList> get loyaltyPointList => _loyaltyPointList;

  LoyaltyPointModel.fromJson(Map<String, dynamic> json) {
    _limit = json['limit'];
    _offset = json['offset'];
    _totalLoyaltyPoint = json['total_loyalty_point'];
    if (json['loyalty_point_list'] != null) {
      _loyaltyPointList = <LoyaltyPointList>[];
      json['loyalty_point_list'].forEach((v) {
        _loyaltyPointList.add(new LoyaltyPointList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this._limit;
    data['offset'] = this._offset;
    data['total_loyalty_point'] = this._totalLoyaltyPoint;
    if (this._loyaltyPointList != null) {
      data['loyalty_point_list'] =
          this._loyaltyPointList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoyaltyPointList {
  int? _id;
  int? _userId;
  String? _transactionId;
  int? _credit;
  int? _debit;
  int? _balance;
  String? _reference;
  String? _transactionType;
  String? _createdAt;
  String? _updatedAt;

  LoyaltyPointList(
      {int? id,
      int? userId,
      String? transactionId,
      int? credit,
      int? debit,
      int? balance,
      String? reference,
      String? transactionType,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (transactionId != null) {
      this._transactionId = transactionId;
    }
    if (credit != null) {
      this._credit = credit;
    }
    if (debit != null) {
      this._debit = debit;
    }
    if (balance != null) {
      this._balance = balance;
    }
    if (reference != null) {
      this._reference = reference;
    }
    if (transactionType != null) {
      this._transactionType = transactionType;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int get id => _id!;
  int get userId => _userId!;
  String get transactionId => _transactionId!;
  int get credit => _credit!;
  int get debit => _debit!;
  int get balance => _balance!;
  String get reference => _reference!;
  String get transactionType => _transactionType!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;

  LoyaltyPointList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _transactionId = json['transaction_id'];
    _credit = json['credit'];
    _debit = json['debit'];
    _balance = json['balance'];
    _reference = json['reference'];
    _transactionType = json['transaction_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['transaction_id'] = this._transactionId;
    data['credit'] = this._credit;
    data['debit'] = this._debit;
    data['balance'] = this._balance;
    data['reference'] = this._reference;
    data['transaction_type'] = this._transactionType;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
