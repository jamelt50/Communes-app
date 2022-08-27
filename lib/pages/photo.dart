import 'dart:io';

import 'package:flutter/material.dart';

class Photo extends StatefulWidget {
  final String imagePath;
  const Photo({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<Photo> createState() => _PhotoState(this.imagePath);
}

class _PhotoState extends State<Photo> {
  final String imagePath;

  _PhotoState(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Photo"),
          backgroundColor: Colors.amber[900],
        ),
        body: Column(
          children: [
            Container(
              child: Image.file(File(imagePath)),
            )
          ],
        ));
  }
}
