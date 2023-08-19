import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class ChatTypeButton extends StatelessWidget {
  final String text;
  final int? index;
  const ChatTypeButton({Key? key, required this.text, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<ChatProvider>(context, listen: false)
            .setUserTypeIndex(context, index!);
      },
      child: Consumer<ChatProvider>(
        builder: (context, chat, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: chat.userTypeIndex == index
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).hintColor.withOpacity(.25),
                borderRadius:
                    BorderRadius.circular(Dimensions.PADDING_SIZE_OVER_LARGE),
              ),
              child: Text(text,
                  style: chat.userTypeIndex == index
                      ? robotoRegular.copyWith(
                          color: chat.userTypeIndex == index!
                              ? Colors.white
                              : Colors.red)
                      : robotoRegular.copyWith(
                          color: chat.userTypeIndex == index
                              ? Theme.of(context).cardColor
                              : Theme.of(context).cardColor)),
            ),
          );
        },
      ),
    );
  }
}
