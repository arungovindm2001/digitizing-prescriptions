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
        centerTitle: true,
      ), //AppBar
      body:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
        Card(
          elevation: 8,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Camera()),
              );
            },
            child: Container(
              child: Center(
                child: Icon(Icons.camera_alt,color: Colors.blueAccent, size: 50,)
                ),
              width: 100.0,
              height: 100.0,
            ),
          ),
        ),
        Card(
          elevation: 8,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () async {
              File awaitImage =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              String image = awaitImage.path;
              print(image);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(image),
                ),
              );
            },
            child: Container(
              child: Center(
                child: Icon(Icons.image_outlined,
                    color: Colors.blueAccent,
                    size: 50,
                  )
              ),
              width: 100.0,
              height: 100.0,
            ),
          ),
        ),
      ]
      ),
    );
  }
}