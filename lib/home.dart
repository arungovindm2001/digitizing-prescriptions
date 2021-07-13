
import 'package:flutter/material.dart';
import 'package:digitizing_prescriptions/camera.dart';

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
                      Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt),
                          label:Text('Camera'),
                          onPressed: () async {
                                checkCameras();
                              }
                          )
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    ); //Scaffold
  }
}