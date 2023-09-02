import 'dart:io';

import 'package:camera_cp/page_one.dart';
import 'package:camera_cp/main.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body: Center(
        child: Image(image: FileImage(File(image),),),
       ),
    );
  }
}