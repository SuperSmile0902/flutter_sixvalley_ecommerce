import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class WalletTransactionRepo {
  final DioClient dioClient;
  WalletTransactionRepo({required this.dioClient});

  Future<ApiResponse> getWalletTransactionList(int offset) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.WALLET_TRANSACTION_URI}$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getLoyaltyPointList(int offset) async {
    try {
      Response response =
          await dioClient.get('${AppConstants.LOYALTY_POINT_URI}$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> convertPointToCurrency(int point) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOYALTY_POINT_CONVERT_URI,
        data: {"point": point},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
