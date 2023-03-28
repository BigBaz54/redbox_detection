import 'package:camera/camera.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:image_picker/image_picker.dart';
import "dart:io";
import 'package:flutter/material.dart';
import 'home_page.dart';

class ImagePage extends StatefulWidget {

  const ImagePage({required this.image, required this.cameras, required this.objectModel, Key? key}) : super(key: key);
  final File image;
  final List<CameraDescription> cameras;
  final ModelObjectDetection objectModel;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late List<CameraDescription> cameras = widget.cameras;
  late ModelObjectDetection objectModel = widget.objectModel;
  late File image = widget.image;
  List<ResultObjectDetection?> objDetect = [];

  Future runObjectDetection() async {
    objDetect = await objectModel.getImagePrediction(
        await image.readAsBytes(),
        minimumScore: 0.1,
        IOUThershold: 0.3);
    objDetect.forEach((element) {
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    });
    setState(() {
      image = File(image.path);
    });
  }

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
      body: Stack(
        children: [
          Center(
            child: Image(image: FileImage(widget.image)),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 30),
                  // moves the button at the bottom of the screen
                  
                ),
                onPressed: () {
                  runObjectDetection();
                },
                child: const Text('Detect'),
              ),)
        ],
      ),
    );
  }
}


