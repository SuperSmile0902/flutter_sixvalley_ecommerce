import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/MessageBody.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/chat_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/message_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/chat_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';


class ChatProvider extends ChangeNotifier {
  final ChatRepo chatRepo;
  ChatProvider({required this.chatRepo});


  bool _isSendButtonActive = false;
  bool get isSendButtonActive => _isSendButtonActive;
  List<Chat>? _chatList;
  List<Chat> get chatList => _chatList!;
  List<Message> _messageList = [];
  List<Message> get messageList => _messageList;
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  File? _imageFile;
  File get imageFile => _imageFile!;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _userTypeIndex = 0;
  int get userTypeIndex =>  _userTypeIndex;




  Future<void> getChatList(BuildContext context, int offset, {bool reload = true}) async {
    if(reload){
      _chatList = [];
    }
    _isLoading = true;
    ApiResponse apiResponse = await chatRepo.getChatList(_userTypeIndex == 0? 'seller' : 'delivery-man', offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _chatList = ChatModel.fromJson(apiResponse.response!.data).chat!;
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }


  Future<void> getMessageList(BuildContext context, int id, int offset, {bool reload = true}) async {
    if(reload){
      _messageList = [];
    }
    _isLoading = true;
    ApiResponse apiResponse = await chatRepo.getMessageList(_userTypeIndex == 0? 'seller' : 'delivery-man', id, offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _messageList = MessageModel.fromJson(apiResponse.response!.data).message!;

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isLoading = false;
    notifyListeners();
  }



  void sendMessage(MessageBody messageBody, BuildContext context) async {
    _isSendButtonActive = true;
    ApiResponse apiResponse = await chatRepo.sendMessage(messageBody, _userTypeIndex == 0? 'seller' : 'delivery-man');
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getMessageList(context, messageBody.id!, 1);

    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    _isSendButtonActive = false;
    notifyListeners();
  }

  void toggleSendButtonActivity() {
    _isSendButtonActive = !_isSendButtonActive;
    notifyListeners();
  }

  void setImage(File image) {
    _imageFile = image;
    _isSendButtonActive = true;
    notifyListeners();
  }

  void removeImage(String text) {
    _imageFile = null;
    text.isEmpty ? _isSendButtonActive = false : _isSendButtonActive = true;
    notifyListeners();
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    notifyListeners();
  }
  void setUserTypeIndex(BuildContext context, int index) {
    _userTypeIndex = index;
    getChatList(context, 1);
    notifyListeners();
  }

}
