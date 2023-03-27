import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import "dart:io";
import 'package:flutter/material.dart';
import 'home_page.dart';

class ImagePage extends StatefulWidget {
  final ImageProvider image;

  const ImagePage({required this.image, required this.cameras, Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late List<CameraDescription> cameras = widget.cameras;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Processed image'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(cameras: cameras,)),
              );
            },
          ),
        ),
      body: Center(
        child: Image(image: widget.image),
      ),
    );
  }
}
