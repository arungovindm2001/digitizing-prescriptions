import 'dart:io';

import 'package:flutter/material.dart';
import 'package:digitizing_prescriptions/camera.dart';
import 'package:digitizing_prescriptions/textRecognize.dart';
import './sign-in.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () async {
                MyHomePage().signOutGoogle();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyHomePage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ), //AppBar
      body: Row(
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
                      child: Icon(
                    Icons.camera_alt,
                    color: Colors.blueAccent,
                    size: 50,
                  )),
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
                      // ignore: deprecated_member_use
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
                      child: Icon(
                    Icons.image_outlined,
                    color: Colors.blueAccent,
                    size: 50,
                  )),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ),
          ]),
    );
  }
}
