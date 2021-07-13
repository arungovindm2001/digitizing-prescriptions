import 'dart:io';

import 'package:flutter/material.dart';
import 'package:digitizing_prescriptions/camera.dart';
import 'package:digitizing_prescriptions/textRecognize.dart';
import 'package:image_picker/image_picker.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
  
//imported google's material design library
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.greenAccent[400],
        centerTitle: true,
      ), //AppBar
      body: Container(
            child: Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 8,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(),
                          ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt),
                          label:Text('Camera'),
                          onPressed: () async {
                            Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Camera()),
                        );
                              }
                          ),
                          ElevatedButton.icon(
                          icon: const Icon(Icons.image_outlined),
                          label:Text('Pick from Gallery'),
                          onPressed: () async {
                            File awaitImage = await ImagePicker.pickImage(source: ImageSource.gallery);
                            String image = awaitImage.path;
                            print(image);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(image),
                              ),
                            );
                              }
                          )
                    ],
                  ),
                ),
              ),
            ),
          ),
    ); //Scaffold
  }
}