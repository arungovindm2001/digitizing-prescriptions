import 'dart:io';

import 'package:digitizing_prescriptions/camera.dart';
import 'package:digitizing_prescriptions/textRecognize.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  File pickedImage;
  var text = '';

  Future pickImage() async {
    var awaitImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = awaitImage;
    });
    String image = pickedImage.path;
    print(image);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(image),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: TextButton.icon(
              icon: Icon(
                Icons.image_outlined,
                size: 100,
              ),
              label: Text(''),
              // textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                pickImage();
              },
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(height: 10.0),
          Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SelectableText(text, toolbarOptions: ToolbarOptions(copy: true, selectAll: true),),
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}