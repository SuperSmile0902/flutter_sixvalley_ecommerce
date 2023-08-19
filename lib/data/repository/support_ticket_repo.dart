import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class SupportTicketRepo {
  final DioClient dioClient;
  SupportTicketRepo({required this.dioClient});

  Future<ApiResponse> sendSupportTicket(
      SupportTicketBody supportTicketModel) async {
    try {
      Response response = await dioClient.post(AppConstants.SUPPORT_TICKET_URI,
          data: supportTicketModel.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSupportTicketList() async {
    try {
      final response = await dioClient.get(AppConstants.SUPPORT_TICKET_GET_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSupportReplyList(String ticketID) async {
    try {
      final response = await dioClient
          .get('${AppConstants.SUPPORT_TICKET_CONV_URI}$ticketID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendReply(String ticketID, String message) async {
    try {
      final response = await dioClient.post(
          '${AppConstants.SUPPORT_TICKET_REPLY_URI}$ticketID',
          data: {'message': message});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
