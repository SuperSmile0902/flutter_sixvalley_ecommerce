import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/MessageBody.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/message_model.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/chat_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/widget/message_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final int? id;
  final String name;
  ChatScreen({this.id, required this.name});

  final ImagePicker picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<ChatProvider>(context, listen: false)
        .getMessageList(context, id!, 1);

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Consumer<ChatProvider>(builder: (context, chatProvider, child) {
        return Column(children: [
          CustomAppBar(title: name),
          Expanded(
              child: chatProvider.messageList != null
                  ? chatProvider.messageList.length != 0
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          itemCount: chatProvider.messageList.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            List<Message> messages =
                                chatProvider.messageList.reversed.toList();
                            return MessageBubble(message: messages[index]);
                          },
                        )
                      : SizedBox.shrink()
                  : ChatShimmer()),

          // Bottom TextField
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                child: Card(
                  color: Theme.of(context).highlightColor,
                  shadowColor: Colors.grey[200],
                  elevation: 2,
                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: titilliumRegular,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: 'Type here...',
                            hintStyle: titilliumRegular.copyWith(
                                color: ColorResources.HINT_TEXT_COLOR),
                            border: InputBorder.none,
                          ),
                          onChanged: (String newText) {
                            if (newText.isNotEmpty &&
                                !Provider.of<ChatProvider>(context,
                                        listen: false)
                                    .isSendButtonActive) {
                              Provider.of<ChatProvider>(context, listen: false)
                                  .toggleSendButtonActivity();
                            } else if (newText.isEmpty &&
                                Provider.of<ChatProvider>(context,
                                        listen: false)
                                    .isSendButtonActive) {
                              Provider.of<ChatProvider>(context, listen: false)
                                  .toggleSendButtonActivity();
                            }
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (Provider.of<ChatProvider>(context, listen: false)
                              .isSendButtonActive) {
                            MessageBody messageBody =
                                MessageBody(id: id!, message: _controller.text);
                            Provider.of<ChatProvider>(context, listen: false)
                                .sendMessage(messageBody, context);
                            _controller.text = '';
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: Provider.of<ChatProvider>(context)
                                  .isSendButtonActive
                              ? Theme.of(context).primaryColor
                              : ColorResources.HINT_TEXT_COLOR,
                          size: Dimensions.ICON_SIZE_DEFAULT,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ]);
      }),
    );
  }
}
