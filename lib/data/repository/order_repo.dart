import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';

class OrderRepo {
  final DioClient dioClient;

  OrderRepo({required this.dioClient});

  Future<ApiResponse> getOrderList() async {
    try {
      final response = await dioClient.get(AppConstants.ORDER_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails(
      String orderID, String languageCode) async {
    try {
      final response = await dioClient.get(
        AppConstants.ORDER_DETAILS_URI + orderID,
        options: Options(headers: {AppConstants.LANG_KEY: languageCode}),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderFromOrderId(String orderID) async {
    try {
      final response = await dioClient
          .get('${AppConstants.GET_ORDER_FROM_ORDER_ID}$orderID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShippingList() async {
    try {
      final response = await dioClient.get(AppConstants.SHIPPING_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> placeOrder(
      String addressID,
      String couponCode,
      String couponDiscountAmount,
      String billingAddressId,
      String orderNote) async {
    try {
      final response = await dioClient.get(AppConstants.ORDER_PLACE_URI +
          '?address_id=$addressID&coupon_code=$couponCode&coupon_discount=$couponDiscountAmount&billing_address_id=$billingAddressId&order_note=$orderNote');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> offlinePaymentPlaceOrder(
      String addressID,
      String couponCode,
      String couponDiscountAmount,
      String billingAddressId,
      String orderNote,
      String paymentBy,
      String transactionId,
      String paymentNote) async {
    try {
      print(
          '=address_id=$addressID/coupon_code=$couponCode/coupon_discount=$couponDiscountAmount/billing_address_id=$billingAddressId/order_note$orderNote/payment_by=$paymentBy/transaction_ref=$transactionId/payment_note=$paymentNote');
      final response = await dioClient.get(
          '${AppConstants.OFFLINE_PAYMENT}?address_id=$addressID&coupon_code=$couponCode&coupon_discount=$couponDiscountAmount&billing_address_id=$billingAddressId&order_note=$orderNote&payment_by=$paymentBy&transaction_ref=$transactionId&payment_note=$paymentNote');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> walletPaymentPlaceOrder(
      String addressID,
      String couponCode,
      String couponDiscountAmount,
      String billingAddressId,
      String orderNote) async {
    try {
      print(
          '=address_id=$addressID/coupon_code=$couponCode/coupon_discount=$couponDiscountAmount/billing_address_id=$billingAddressId/order_note$orderNote');
      final response = await dioClient.get(
        '${AppConstants.WALLET_PAYMENT}?address_id=$addressID&coupon_code=$couponCode&coupon_discount=$couponDiscountAmount&billing_address_id=$billingAddressId&order_note=$orderNote',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTrackingInfo(String orderID) async {
    try {
      final response = await dioClient.get(AppConstants.TRACKING_URI + orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShippingMethod(int sellerId) async {
    try {
      final response = sellerId == 1
          ? await dioClient
              .get('${AppConstants.GET_SHIPPING_METHOD}/$sellerId/admin')
          : await dioClient
              .get('${AppConstants.GET_SHIPPING_METHOD}/$sellerId/seller');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> refundRequest(int orderDetailsId, double amount,
      String refundReason, List<XFile> file, String token) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${AppConstants.BASE_URL}${AppConstants.REFUND_REQUEST_URI}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    for (int i = 0; i < file.length; i++) {
      if (file != null) {
        Uint8List _list = await file[i].readAsBytes();
        var part = http.MultipartFile(
            'images[]', file[i].readAsBytes().asStream(), _list.length,
            filename: basename(file[i].path),
            contentType: MediaType('image', 'jpg'));
        request.files.add(part);
      }
    }
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      'order_details_id': orderDetailsId.toString(),
      'amount': amount.toString(),
      'refund_reason': refundReason
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<ApiResponse> getRefundInfo(int orderDetailsId) async {
    try {
      final response = await dioClient.get(
          '${AppConstants.REFUND_REQUEST_PRE_REQ_URI}?order_details_id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRefundResult(int orderDetailsId) async {
    try {
      final response = await dioClient
          .get('${AppConstants.REFUND_RESULT_URI}?id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> cancelOrder(int orderId) async {
    try {
      final response = await dioClient
          .get('${AppConstants.CANCEL_ORDER_URI}?order_id=$orderId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
