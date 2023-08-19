import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeVideoWidget extends StatelessWidget {
  final String url;
  YoutubeVideoWidget({required this.url});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return url.isNotEmpty
        ? Container(
            height: width / 1.55,
            width: width,
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            child: WebView(
              initialUrl: Uri.dataFromString(
                      '<html><body><iframe width="1920" height="1080" src="$url"  frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></body></html>',
                      mimeType: 'text/html')
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
            ),
          )
        : SizedBox.shrink();
  }
}
