import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/login_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/register_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/response_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/social_login_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/auth_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo});

  bool _isLoading = false;
  bool _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isRemember => _isRemember;

  void updateRemember(bool? value) {
    _isRemember = value!;
    notifyListeners();
  }

  Future socialLogin(SocialLoginModel socialLogin, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.socialLogin(socialLogin);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String message = '';
      String token = '';
      String temporaryToken = '';
      try {
        message = map['error_message'];
      } catch (e) {}
      try {
        token = map['token'];
      } catch (e) {}
      try {
        temporaryToken = map['temporary_token'];
      } catch (e) {}

      if (token != null) {
        authRepo.saveUserToken(token);
        await authRepo.updateToken();
      }
      callback(true, token, temporaryToken, message);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        log("Else......");
        ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, '', '', errorMessage);
      notifyListeners();
    }
  }

  Future registration(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registration(register);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String temporaryToken = '';
      String token = '';
      String message = '';
      try {
        message = map["message"];
      } catch (e) {}
      try {
        token = map["token"];
      } catch (e) {}
      try {
        temporaryToken = map["temporary_token"];
      } catch (e) {}
      if (token != null && token.isNotEmpty) {
        authRepo.saveUserToken(token);
        await authRepo.updateToken();
      }
      callback(true, token, temporaryToken, message);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, '', '', errorMessage);
      notifyListeners();
    }
  }

  Future authToken(String authToken) async {
    authRepo.saveAuthToken(authToken);
    notifyListeners();
  }

  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse? apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    if (apiResponse!.response != null &&
        apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String temporaryToken = '';
      String token = '';
      String message = '';
      // String token = map["token"];

      try {
        message = map["message"];
      } catch (e) {}
      try {
        token = map["token"];
      } catch (e) {}
      try {
        temporaryToken = map["temporary_token"];
      } catch (e) {}

      if (token != null && token.isNotEmpty) {
        authRepo.saveUserToken(token);
        await authRepo.updateToken();
      }
      log("Token In Auth Provider $token");
      callback(true, token, temporaryToken, message);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        // ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors.message);
        // errorMessage = errorResponse.errors[0].message;
      }
      callback(false, '', '', "login errorMessage");
      notifyListeners();
    }
  }

  Future<void> updateToken(BuildContext context) async {
    ApiResponse apiResponse = await authRepo.updateToken();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
  }

  //email
  Future<ResponseModel> checkEmail(String email, String temporaryToken) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.checkEmail(email, temporaryToken);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response!.data['token'], true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        // ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        // errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel("checkEmail errorMessage", false);
      _verificationMsg = "checkEmail errorMessage";
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyEmail(String email, String token) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo.verifyEmail(email, _verificationCode, token);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      authRepo.saveUserToken(apiResponse.response!.data['token']);
      await authRepo.updateToken();
      responseModel = ResponseModel('Successful', true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        // ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        // errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel("verifyEmail errorMessage", false);
      _verificationMsg = "verifyEmail errorMessage";

      // _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  //phone

  Future<ResponseModel> checkPhone(String phone, String temporaryToken) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse = await authRepo.checkPhone(phone, temporaryToken);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response!.data["token"], true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        // ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        // errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel("Check Phone Error", false);
      _verificationMsg = "Check Phone Error";
      // _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyPhone(String phone, String token) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo.verifyPhone(phone, token, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel =
          ResponseModel(apiResponse.response!.data["message"], true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        // ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        // errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel("verify Phonr", false);
      _verificationMsg = "verify Phonr";
      // _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> verifyOtp(String phone) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo.verifyOtp(phone, _verificationCode);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel =
          ResponseModel(apiResponse.response!.data["message"], true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        // ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        // errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel("Verify Error", false);
      // _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> resetPassword(String identity, String otp,
      String password, String confirmPassword) async {
    _isPhoneNumberVerificationButtonLoading = true;
    _verificationMsg = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo.resetPassword(identity, otp, password, confirmPassword);
    _isPhoneNumberVerificationButtonLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel =
          ResponseModel(apiResponse.response!.data["message"], true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        // ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        // errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel("REset Error", false);
      _verificationMsg = "REset Error";
      // _verificationMsg = errorMessage;
    }
    notifyListeners();
    return responseModel;
  }

  // for phone verification
  bool _isPhoneNumberVerificationButtonLoading = false;

  bool get isPhoneNumberVerificationButtonLoading =>
      _isPhoneNumberVerificationButtonLoading;
  String _verificationMsg = '';

  String get verificationMessage => _verificationMsg;
  String _email = '';
  String _phone = '';

  String get email => _email;
  String get phone => _phone;

  updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  updatePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void clearVerificationMessage() {
    _verificationMsg = '';
  }

  // for verification Code
  String _verificationCode = '';

  String get verificationCode => _verificationCode;
  bool _isEnableVerificationCode = false;

  bool get isEnableVerificationCode => _isEnableVerificationCode;

  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }

  // for user Section
  String? getUserToken() {
    return authRepo.getUserToken();
  }

  //get auth token
  // for user Section
  String getAuthToken() {
    return authRepo.getAuthToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authRepo.getUserEmail() ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserEmailAndPassword();
  }

  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.forgetPassword(email);
    _isLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      responseModel =
          ResponseModel(apiResponse.response!.data["message"], true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        // ErrorResponse errorResponse = apiResponse.error;
        // print(errorResponse.errors[0].message);
        // errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel("forgot message Error", false);
    }
    return responseModel;
  }
}
