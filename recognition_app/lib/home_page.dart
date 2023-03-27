// ignore_for_file: avoid_print

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'camera_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.cameras, Key? key}) : super(key: key);

  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Red box detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton "Prendre une photo"
                print('Prendre une photo');
              },
              child: const Text('Take a picture'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton "Choisir une photo dans la pellicule"
                print('Choisir une photo dans la pellicule');
              },
              child: const Text('Chose from gallery'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Action à effectuer lors du clic sur le bouton "Détection en direct"
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen(cameras: cameras)),
                );
              },
              child: const Text('Live detection'),
            ),
          ],
        ),
      ),
    );
  }
}

