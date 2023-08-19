import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class CategoryRepo {
  final DioClient dioClient;
  CategoryRepo({required this.dioClient});

  Future<ApiResponse> getCategoryList() async {
    try {
      log("Get Category Listing");

      final response = await dioClient.get(AppConstants.CATEGORIES_URI);
      log("Get Category Listing${response.data}");

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
