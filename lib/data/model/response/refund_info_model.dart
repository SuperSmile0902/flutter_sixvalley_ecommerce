class RefundInfoModel {
  bool? alreadyRequested;
  bool? expired;
  Refund? refund;

  RefundInfoModel({this.alreadyRequested, this.expired, this.refund});

  RefundInfoModel.fromJson(Map<String, dynamic> json) {
    alreadyRequested = json['already_requested'];
    expired = json['expired'];
    refund =
        (json['refund'] != null ? new Refund.fromJson(json['refund']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['already_requested'] = this.alreadyRequested;
    data['expired'] = this.expired;
    if (this.refund != null) {
      data['refund'] = this.refund!.toJson();
    }
    return data;
  }
}

class Refund {
  double? productPrice;
  int? quntity;
  double? productTotalDiscount;
  double? productTotalTax;
  double? subtotal;
  double? couponDiscount;
  double? refundAmount;

  Refund(
      {this.productPrice,
      this.quntity,
      this.productTotalDiscount,
      this.productTotalTax,
      this.subtotal,
      this.couponDiscount,
      this.refundAmount});

  Refund.fromJson(Map<String, dynamic> json) {
    productPrice = json['product_price'].toDouble();
    quntity = json['quntity'];
    productTotalDiscount = json['product_total_discount'].toDouble();
    productTotalTax = json['product_total_tax'].toDouble();
    subtotal = json['subtotal'].toDouble();
    couponDiscount = json['coupon_discount'].toDouble();
    refundAmount = json['refund_amount'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_price'] = this.productPrice;
    data['quntity'] = this.quntity;
    data['product_total_discount'] = this.productTotalDiscount;
    data['product_total_tax'] = this.productTotalTax;
    data['subtotal'] = this.subtotal;
    data['coupon_discount'] = this.couponDiscount;
    data['refund_amount'] = this.refundAmount;
    return data;
  }
}
