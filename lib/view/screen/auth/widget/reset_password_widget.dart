import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class ResetPasswordWidget extends StatefulWidget {
  final String mobileNumber;
  final String otp;
  const ResetPasswordWidget(
      {Key? key, required this.mobileNumber, required this.otp})
      : super(key: key);

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FocusNode _newPasswordNode = FocusNode();
  FocusNode _confirmPasswordNode = FocusNode();
  GlobalKey<FormState> _formKeyReset = GlobalKey();

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  void resetPassword() async {
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();

    if (_password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
        backgroundColor: Colors.red,
      ));
    } else if (_confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text(getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)!),
        backgroundColor: Colors.red,
      ));
    } else if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
        backgroundColor: Colors.red,
      ));
    } else {
      Provider.of<AuthProvider>(context, listen: false)
          .resetPassword(
              widget.mobileNumber, widget.otp, _password, _confirmPassword)
          .then((value) {
        if (value.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(getTranslated('password_reset_successfully', context)!),
            backgroundColor: Colors.green,
          ));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => AuthScreen()),
              (route) => false);
        } else {
          showCustomSnackBar(value.message, context);
        }
      });
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyReset,
        child: ListView(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          children: [
            Padding(
              padding: EdgeInsets.all(50),
              child: Image.asset(Images.logo_with_name_image,
                  height: 150, width: 200),
            ),

            Padding(
              padding: const EdgeInsets.all(Dimensions.MARGIN_SIZE_LARGE),
              child: Text(getTranslated('password_reset', context)!,
                  style: titilliumSemiBold),
            ),
            // for new password
            Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_LARGE,
                    right: Dimensions.MARGIN_SIZE_LARGE,
                    bottom: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('new_password', context),
                  focusNode: _newPasswordNode,
                  nextNode: _confirmPasswordNode,
                  controller: _passwordController,
                )),

            // for confirm Password
            Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_LARGE,
                    right: Dimensions.MARGIN_SIZE_LARGE,
                    bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('confirm_password', context),
                  textInputAction: TextInputAction.done,
                  focusNode: _confirmPasswordNode,
                  controller: _confirmPasswordController,
                )),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
              child: Provider.of<AuthProvider>(context).isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : CustomButton(
                      onTap: resetPassword,
                      buttonText: getTranslated('reset_password', context)!,
                      backgroundColor: null,
                      radius: null,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
