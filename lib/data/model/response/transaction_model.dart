class TransactionModel {
  int? _limit;
  int? _offset;
  double? _totalWalletBalance;
  int? _totalWalletTransactio;
  List<WalletTransactioList>? _walletTransactioList;

  TransactionModel(
      {int? limit,
      int? offset,
      double? totalWalletBalance,
      int? totalWalletTransactio,
      List<WalletTransactioList>? walletTransactioList}) {
    if (limit != null) {
      this._limit = limit;
    }
    if (offset != null) {
      this._offset = offset;
    }
    if (totalWalletBalance != null) {
      this._totalWalletBalance = totalWalletBalance;
    }
    if (totalWalletTransactio != null) {
      this._totalWalletTransactio = totalWalletTransactio;
    }
    if (walletTransactioList != null) {
      this._walletTransactioList = walletTransactioList;
    }
  }

  int get limit => _limit!;
  int get offset => _offset!;
  double get totalWalletBalance => _totalWalletBalance!;
  int get totalWalletTransactio => _totalWalletTransactio!;
  List<WalletTransactioList> get walletTransactioList => _walletTransactioList!;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['total_wallet_balance'] != null) {
      _totalWalletBalance = json['total_wallet_balance'].toDouble();
    } else {
      _totalWalletBalance = 0.0;
    }

    _totalWalletTransactio = json['total_wallet_transactio'];
    if (json['wallet_transactio_list'] != null) {
      _walletTransactioList = <WalletTransactioList>[];
      json['wallet_transactio_list'].forEach((v) {
        _walletTransactioList!.add(new WalletTransactioList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this._limit;
    data['offset'] = this._offset;
    data['total_wallet_balance'] = this._totalWalletBalance;
    data['total_wallet_transactio'] = this._totalWalletTransactio;
    if (this._walletTransactioList != null) {
      data['wallet_transactio_list'] =
          this._walletTransactioList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactioList {
  int? _id;
  int? _userId;
  String? _transactionId;
  double? _credit;
  double? _debit;
  double? _adminBonus;
  double? _balance;
  String? _transactionType;
  String? _reference;
  String? _createdAt;
  String? _updatedAt;

  WalletTransactioList(
      {int? id,
      int? userId,
      String? transactionId,
      double? credit,
      double? debit,
      double? adminBonus,
      double? balance,
      String? transactionType,
      String? reference,
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
    if (adminBonus != null) {
      this._adminBonus = adminBonus;
    }
    if (balance != null) {
      this._balance = balance;
    }
    if (transactionType != null) {
      this._transactionType = transactionType;
    }
    if (reference != null) {
      this._reference = reference;
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
  double get credit => _credit!;
  double get debit => _debit!;
  double get adminBonus => _adminBonus!;
  double get balance => _balance!;
  String get transactionType => _transactionType!;
  String get reference => _reference!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;

  WalletTransactioList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _transactionId = json['transaction_id'];
    _credit = json['credit'].toDouble();
    _debit = json['debit'].toDouble();
    _adminBonus = json['admin_bonus'].toDouble();
    _balance = json['balance'].toDouble();
    _transactionType = json['transaction_type'];
    _reference = json['reference'];
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
    data['admin_bonus'] = this._adminBonus;
    data['balance'] = this._balance;
    data['transaction_type'] = this._transactionType;
    data['reference'] = this._reference;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
