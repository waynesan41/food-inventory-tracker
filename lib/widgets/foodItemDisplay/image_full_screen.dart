//==

import 'dart:io';

import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen(this._imgUrl, {super.key});
  final _imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: InteractiveViewer(
          child: Center(
            child: Hero(
              tag: 'imageHero',
              child: Image.file(File(_imgUrl)),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
        onDoubleTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
