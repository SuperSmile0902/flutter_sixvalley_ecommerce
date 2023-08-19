import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = true, bool isToaster = false}) {
  if(isToaster){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? ColorResources.getRed(context) : Colors.green,
      content: Text(message),
    ));
  }

}
