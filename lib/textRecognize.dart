import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';
import 'dart:ui';
import 'dart:async';

import './sign-in.dart';

Future<String> futureEmail() async {
  final FirebaseUser currentUser = await firebaseAuth.currentUser();
  final String fEmail = currentUser.email;
  return fEmail;
}

class DetailScreen extends StatefulWidget {
  final String imagePath;
  DetailScreen(this.imagePath);

  @override
  _DetailScreenState createState() => new _DetailScreenState(imagePath);
}

class _DetailScreenState extends State<DetailScreen> {
  final _firebaseStorage = FirebaseStorage.instance;
  _DetailScreenState(this.path);
  String formattedDateTime = DateFormat.yMMMd()
      .addPattern('-')
      .add_Hms()
      .format(DateTime.now())
      .toString();

  final String path;

  Size _imageSize;
  String recognizedText = "Loading ...";

  void initializeVision() async {
    final File imageFile = File(path);
    final email = await futureEmail();
    if (imageFile != null) {
      var snapshot = await _firebaseStorage
          .ref()
          .child('$email/images/$formattedDateTime')
          .putFile(imageFile)
          .onComplete;
      var downloadUrl = await snapshot.ref.getDownloadURL();
    } else {
      print('No Image Path Received');
    }

    if (imageFile != null) {
      await _getImageSize(imageFile);
    }

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();

    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    String text = "";
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        text += line.text + '\n';
      }
    }

    if (this.mounted) {
      setState(() {
        recognizedText = text;
      });
    }
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  @override
  void initState() {
    initializeVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" "), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: recognizedText))
                .then((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Copied to clipboard')));
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            Share.share(recognizedText);
          },
        ),
        IconButton(
          icon: Icon(Icons.picture_as_pdf_outlined),
          onPressed: () async {
            final email = await futureEmail();
            final pdf = pw.Document();

            pdf.addPage(pw.Page(
                pageFormat: PdfPageFormat.a4,
                build: (pw.Context context) {
                  return (pw.Text(recognizedText));
                }));
            final output = await getApplicationDocumentsDirectory();
            final file = File("${output.path}/$formattedDateTime.pdf");
            await file.writeAsBytes(await pdf.save());

            var sspdf = await _firebaseStorage
                .ref()
                .child('$email/pdfs/$formattedDateTime')
                .putFile(file)
                .onComplete;
            var downloadUrl = await sspdf.ref.getDownloadURL();
            Share.shareFiles(["${output.path}/$formattedDateTime.pdf"]);
          },
        ),
      ]),
      body: _imageSize != null
          ? Container(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topCenter,
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Identified Text",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: SingleChildScrollView(
                              child: Text(
                                recognizedText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
