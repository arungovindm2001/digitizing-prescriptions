import 'dart:async';
import 'dart:io';

import 'package:camerakit/CameraKitController.dart';
import 'package:camerakit/CameraKitView.dart';
import 'package:flutter/material.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class Camera extends StatefulWidget {
  CameraState cameraState = new CameraState();
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  String _platformVersion = 'Unknown';
  CameraKitView cameraKitView;
  CameraFlashMode _flashMode = CameraFlashMode.on;
  CameraKitController cameraKitController;
  bool _isFlashOn = false;

  get text => null;

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
    return Scaffold(
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
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: () async {
                    cameraKitController.takePicture().then((value) =>
                        print("Flutter take picture result: " + value));
                    var recognizedText = '';
                    pickImage();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextRecognize(text: recognizedText,)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
                  onPressed: () {
                    setState(() {
                      _isFlashOn = !_isFlashOn;
                      if (_isFlashOn) {
                        cameraKitController.changeFlashMode(CameraFlashMode.on);
                      } else {
                        cameraKitController
                            .changeFlashMode(CameraFlashMode.off);
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
    );
  }

  Future pickImage() async{
    var capturedImage =
        File('/data/user/0/com.example.digitizing_prescriptions/cache/pic.jpg');
    var recognizedText = '';
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(capturedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          recognizedText = recognizedText + word.text + ' ';
        }
        recognizedText = recognizedText + '\n';
      }
    }
    textRecognizer.close();
  }
}

class TextRecognize extends StatelessWidget {
  final String text;
  TextRecognize({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
      ),
      body: Column(
        children: <Widget>[
          Container(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SelectableText(
                  text!=null?text:'Default Value',
                  toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
