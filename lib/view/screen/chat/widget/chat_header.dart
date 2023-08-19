import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_search_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/chat_type_button.dart';
import 'package:provider/provider.dart';

class ChatHeader extends StatefulWidget {
  const ChatHeader({Key? key}) : super(key: key);

  @override
  State<ChatHeader> createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, chat, _) {
      return Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(Dimensions.topSpace),
            ),
            child: Stack(
              children: [
                Positioned(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ChatTypeButton(
                            text: getTranslated('seller', context)!, index: 0),
                        ChatTypeButton(
                            text: getTranslated('delivery-man', context)!,
                            index: 1),
                      ],
                    ),
                  ),
                ),
                AnimSearchBar(
                  width: MediaQuery.of(context).size.width,
                  textController: _textEditingController,
                  onSuffixTap: () {},
                  color: Theme.of(context).cardColor,
                  helpText: "Search Text...",
                  autoFocus: true,
                  closeSearchOnSuffixTap: true,
                  animationDurationInMilli: 200,
                  rtl: false,
                ),
              ],
            )),
      );
    });
  }
}
