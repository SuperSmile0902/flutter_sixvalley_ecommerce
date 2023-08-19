class RefundResultModel {
  double? productPrice;
  int? quntity;
  double? productTotalDiscount;
  double? productTotalTax;
  double? subtotal;
  double? couponDiscount;
  double? refundAmount;
  List<RefundRequest>? refundRequest;

  RefundResultModel(
      {this.productPrice,
      this.quntity,
      this.productTotalDiscount,
      this.productTotalTax,
      this.subtotal,
      this.couponDiscount,
      this.refundAmount,
      this.refundRequest});

  RefundResultModel.fromJson(Map<String, dynamic> json) {
    productPrice = json['product_price'].toDouble();
    quntity = json['quntity'];
    productTotalDiscount = json['product_total_discount'].toDouble();
    productTotalTax = json['product_total_tax'].toDouble();
    subtotal = json['subtotal'].toDouble();
    couponDiscount = json['coupon_discount'].toDouble();
    refundAmount = json['refund_amount'].toDouble();
    if (json['refund_request'] != null) {
      refundRequest = <RefundRequest>[];
      json['refund_request'].forEach((v) {
        refundRequest!.add(new RefundRequest.fromJson(v));
      });
    }
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
    if (this.refundRequest != null) {
      data['refund_request'] =
          this.refundRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefundRequest {
  int? id;
  int? orderDetailsId;
  int? customerId;
  String? status;
  double? amount;
  int? productId;
  int? orderId;
  String? refundReason;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  String? approvedNote;
  String? rejectedNote;
  String? paymentInfo;
  String? changeBy;

  RefundRequest(
      {this.id,
      this.orderDetailsId,
      this.customerId,
      this.status,
      this.amount,
      this.productId,
      this.orderId,
      this.refundReason,
      this.images,
      this.createdAt,
      this.updatedAt,
      this.approvedNote,
      this.rejectedNote,
      this.paymentInfo,
      this.changeBy});

  RefundRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDetailsId = json['order_details_id'];
    customerId = json['customer_id'];
    status = json['status'];
    amount = json['amount'].toDouble();
    productId = json['product_id'];
    orderId = json['order_id'];
    refundReason = json['refund_reason'];
    if (json['images'] != null) {
      images = json['images'].cast<String>();
    }

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    approvedNote = json['approved_note'];
    rejectedNote = json['rejected_note'];
    paymentInfo = json['payment_info'];
    changeBy = json['change_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_details_id'] = this.orderDetailsId;
    data['customer_id'] = this.customerId;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['refund_reason'] = this.refundReason;
    data['images'] = this.images;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['approved_note'] = this.approvedNote;
    data['rejected_note'] = this.rejectedNote;
    data['payment_info'] = this.paymentInfo;
    data['change_by'] = this.changeBy;
    return data;
  }
}
