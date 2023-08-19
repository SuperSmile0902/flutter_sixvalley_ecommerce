import 'package:flutter/cupertino.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String placeholder;
  CustomImage({@required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = Images.placeholder});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: Images.placeholder, image: image!, fit: BoxFit.contain,
      imageErrorBuilder: (c, o, s) => Image.asset(
        Images.placeholder, height: height,
        width: width, fit: BoxFit.cover,
      ),
    );
  }
}
