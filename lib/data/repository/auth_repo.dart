import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/login_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/social_login_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> socialLogin(SocialLoginModel socialLogin) async {
    // print("========socialLogin=========");
    try {
      Response response = await dioClient.post(
        AppConstants.SOCIAL_LOGIN_URI,
        data: socialLogin.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> registration(RegisterModel register) async {
    // print("=============registration============");
    try {
      Response response = await dioClient.post(
        AppConstants.REGISTRATION_URI,
        data: register.toJson(),
      );
      // print("=============registration====123123========");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse?> login(LoginModel loginBody) async {
    try {
      log("Login Model");
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: loginBody.toJson(),
      );
      log("Resposne in Login ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      log("Login Model Error");

      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateToken() async {
    try {
      String? _deviceToken = await _getDeviceToken();

      log("Device Token $_deviceToken");
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      print("==========updateToken====@#@#@#=====");
      Response response = await dioClient.post(
        AppConstants.TOKEN_URI,
        data: {
          "_method": "put",
          "cm_firebase_token": _deviceToken,
        },
      );
      print("==========ApiResponse.withSuccess(response)=========");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("==========updateToken====Error=r$e====");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String?> _getDeviceToken() async {
    String? _deviceToken;
    if (Platform.isIOS) {
      _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (_deviceToken != null) {
      // print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken;
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.updateHeader(token, '');
    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String? getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN);
  }

  //auth token
  // for  user token
  Future<void> saveAuthToken(String token) async {
    print('--------saveAuthToken---------- ');
    dioClient.token = token;
    dioClient.dio!.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getAuthToken() {
    // print('--------getAuthToken---------- ');
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    //sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CURRENCY);
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USER);
    FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    return true;
  }

  // for verify Email
  Future<ApiResponse> checkEmail(String email, String temporaryToken) async {
    try {
      Response response = await dioClient.post(AppConstants.CHECK_EMAIL_URI,
          data: {"email": email, "temporary_token": temporaryToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyEmail(
      String email, String token, String tempToken) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_EMAIL_URI,
          data: {"email": email, "token": token, 'temporary_token': tempToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //verify phone number

  Future<ApiResponse> checkPhone(String phone, String temporaryToken) async {
    try {
      Response response = await dioClient.post(AppConstants.CHECK_PHONE_URI,
          data: {"phone": phone, "temporary_token": temporaryToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPhone(
      String phone, String token, String otp) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_PHONE_URI,
          data: {"phone": phone.trim(), "temporary_token": token, "otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyOtp(String identity, String otp) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_OTP_URI,
          data: {"identity": identity.trim(), "otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String identity, String otp,
      String password, String confirmPassword) async {
    try {
      Response response =
          await dioClient.post(AppConstants.RESET_PASSWORD_URI, data: {
        "_method": "put",
        "identity": identity.trim(),
        "otp": otp,
        "password": password,
        "confirm_password": confirmPassword
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  Future<ApiResponse> forgetPassword(String identity) async {
    try {
      log("Response DAta In Forgot Password");
      Response response = await dioClient
          .post(AppConstants.FORGET_PASSWORD_URI, data: {"identity": identity});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
