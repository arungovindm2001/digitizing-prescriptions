import 'dart:async';

import 'package:camerakit/CameraKitController.dart';
import 'package:camerakit/CameraKitView.dart';
import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class Camera extends StatefulWidget {
  CameraState cameraState = new CameraState();
  @override
  CameraState createState() => CameraState();
  void cameraInitialize() {
    cameraState.initState();
  }
}

class CameraState extends State<Camera> {
  String _platformVersion = 'Unknown';
  CameraKitView cameraKitView;
  CameraFlashMode _flashMode = CameraFlashMode.on;
  CameraKitController cameraKitController;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    cameraKitController = CameraKitController();
    print("cameraKitController" + cameraKitController.toString());
    cameraKitView = CameraKitView(
      previewFlashMode: CameraFlashMode.auto,
      cameraKitController: cameraKitController,
    );
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: 2000,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: CameraKitView(
                previewFlashMode: CameraFlashMode.auto,
                cameraKitController: cameraKitController,
                androidCameraMode: AndroidCameraMode.API_X,
                cameraSelector: CameraSelector.back,
              )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      cameraKitController.takePicture().then((value) =>
                      print("Flutter take picture result: " + value));
                    },
                  ),
                  IconButton(
                    icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
                    onPressed: () {
                      setState(() {
                        _isFlashOn = !_isFlashOn;
                        if(_isFlashOn) {
                          cameraKitController.changeFlashMode(CameraFlashMode.on);
                        }
                        else {
                          cameraKitController.changeFlashMode(CameraFlashMode.off);
                        }
                        _platformVersion = "bbasda";
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}