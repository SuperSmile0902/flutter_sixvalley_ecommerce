import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getSearchProductList(String query) async {
    try {
      final response = await dioClient
          .get(AppConstants.SEARCH_URI + base64.encode(utf8.encode(query)));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for save home address
  Future<void> saveSearchAddress(String searchAddress) async {
    try {
      List<String>? searchKeywordList =
          sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS);
      if (!searchKeywordList!.contains(searchAddress)) {
        searchKeywordList.add(searchAddress);
      }
      await sharedPreferences.setStringList(
          AppConstants.SEARCH_ADDRESS, searchKeywordList);
    } catch (e) {
      throw e;
    }
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.SEARCH_ADDRESS) ?? [];
  }

  Future<bool> clearSearchAddress() async {
    return sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, []);
  }
}
