// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'home_page.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({required this.cameras, required this.objectModel, Key? key}) : super(key: key);

  final List<CameraDescription> cameras;
  final ModelObjectDetection objectModel;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  late List<CameraDescription> cameras = widget.cameras;
  late CameraController cameraController;
  late ModelObjectDetection objectModel = widget.objectModel;

  int direction = 0;

  @override
  void initState() {
    super.initState();
    startCamera(direction);
  }

  void startCamera(int direction) async {
    cameraController = CameraController(cameras[direction], ResolutionPreset.high, enableAudio: false);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Live detection'),
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
        body: Center(child: SizedBox(
                                    height: MediaQuery.of(context).size.height/1.5,
                                    child: CameraPreview(cameraController))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              direction = direction == 0 ? 1 : 0;
              startCamera(direction);
            });
          },
          child: const Icon(Icons.flip_camera_android),
        ),
      );
    } else {
      return const Center(
          child:
            CircularProgressIndicator(),
        );
    }
  }
}
