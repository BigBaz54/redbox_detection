import 'package:camera/camera.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'package:image_picker/image_picker.dart';
import "dart:io";
import 'package:flutter/material.dart';
import 'home_page.dart';

class ImagePage extends StatefulWidget {
  final ImageProvider image;

  const ImagePage({required this.image, required this.cameras, required this.objectModel, Key? key}) : super(key: key);
  final List<CameraDescription> cameras;
  final ModelObjectDetection objectModel;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late List<CameraDescription> cameras = widget.cameras;
  late ModelObjectDetection objectModel = widget.objectModel;
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
                MaterialPageRoute(builder: (context) => HomePage(cameras: cameras, objectModel: objectModel)),
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
