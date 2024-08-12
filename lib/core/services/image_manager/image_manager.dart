import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String baseImagePath = 'assets/images/';

class ImageManager {
  static final ImageManager _instance = ImageManager._internal();

  ImageManager._internal();

  factory ImageManager() => _instance;

  final String nightBackground = '${baseImagePath}background/night.svg';

  Widget getImage(String path,
      {BoxFit fit = BoxFit.cover, double? width, double? height}) {
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }

  Widget getSvgImage(String path,
      {BoxFit fit = BoxFit.cover, double? width, double? height}) {
    return SvgPicture.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      placeholderBuilder: (BuildContext context) =>
          const Center(child: CircularProgressIndicator()),
    );
  }
}
