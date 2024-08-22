import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class CachedNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final Duration retryDuration;
  final int maxRetries;

  const CachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.retryDuration = const Duration(seconds: 2),
    this.maxRetries = 3,
  }) : super(key: key);

  @override
  CachedNetworkImageState createState() => CachedNetworkImageState();
}

class CachedNetworkImageState extends State<CachedNetworkImage> {
  late Future<File> _imageFile;
  int _retryCount = 0;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() {
    setState(() {
      _imageFile = _downloadAndCacheImage();
    });
  }

  Future<File> _downloadAndCacheImage() async {
    final directory = await getTemporaryDirectory();
    final fileName = widget.imageUrl.split('/').last;
    final file = File('${directory.path}/$fileName');

    if (await file.exists()) {
      return file;
    }

    try {
      final response = await Dio().get(
        widget.imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      await file.writeAsBytes(response.data);
      return file;
    } catch (e) {
      if (_retryCount < widget.maxRetries) {
        _retryCount++;
        await Future.delayed(widget.retryDuration);
        return _downloadAndCacheImage();
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<File>(
      future: _imageFile,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.placeholder ??
              Container(
                width: widget.width,
                height: widget.height,
                color: colorScheme.surfaceBright,
              );
        } else if (snapshot.hasError) {
          return widget.errorWidget ??
              Container(
                width: widget.width,
                height: widget.height,
                color: colorScheme.errorContainer,
                child: Icon(Icons.error, color: colorScheme.onError),
              );
        } else {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: widget.fadeInDuration,
            child: Image.file(
              snapshot.data!,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
            ),
          );
        }
      },
    );
  }
}
