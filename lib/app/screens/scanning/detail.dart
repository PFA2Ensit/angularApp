import 'package:comptabli_blog/app/screens/scanning/getItems.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:async';

class DetailScreen extends StatefulWidget {
  final File image;
  DetailScreen(this.image);

  @override
  _DetailScreenState createState() => new _DetailScreenState(image);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState(this.image);

  final File image;

  Size _imageSize;
  dynamic recognizedText = "";
  dynamic total;
  dynamic email;
  String address;
  String companyName;
  var finalLines = new List();

  void _initializeVision() async {
    if (image != null) {
      await _getImageSize(image);
    }

    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);

    /*final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();*/

    VisionText visionText;

    try {
      // Try to analize the image using the onDevice model
      final TextRecognizer textRecognizer =
          FirebaseVision.instance.textRecognizer();
      visionText = await textRecognizer.processImage(visionImage);
    } catch (_) {
      try {
        // If the onDevice fails, we use the cloud model
        final TextRecognizer textRecognizer =
            FirebaseVision.instance.cloudTextRecognizer();
        visionText = await textRecognizer.processImage(visionImage);
        print(visionText);
      } catch (e) {
        // The cloud model will fail if the device hasn't internet connection
        print(e);
        // Code to manage the error...
      }
    }

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        finalLines.add(line.text + '\n');

        for (TextElement word in line.elements) {
          setState(() {
            recognizedText = recognizedText + word.text + ' ';
          });
        }
        recognizedText = recognizedText + '\n';
      }
    }

    total = GetItems.findTotalHT(finalLines);
    address = GetItems.findAddress(finalLines);
    email = GetItems.findEmail(finalLines);
    companyName = GetItems.findName(finalLines);
    //test = "Rue Hedi Nouira, 102 3 Tunis";
    //result = GetItems.testAddress(test);

    /*String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regEx = RegExp(pattern);*/
    //RegExp addressExp = new RegExp(r"([0-9]{1}\,)?(Rue|Avenue|Complexe)\t([aA-zZ]\t)+(-|,)\t[0-9]{2,4}\t[Aa-zZ]");

    /*String mailAddress = "";
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        if (addressExp.hasMatch(line.text)) {
          mailAddress += line.text + '\n';
          print(mailAddress);
          for (TextElement element in line.elements) {
            _elements.add(element);
          }
        }
      }
    }

    if (this.mounted) {
      setState(() {
        recognizedText = mailAddress;
      });
    }*/
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
    _initializeVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Details"),
        ),
        body: ListView(
          children: <Widget>[
            Text('recognized items'),
            Text("address : "+address),
            Text("name : "+companyName),
            Text("total ht : "+total.toString()),
            Text("email : "+email)
            //Text(recognizedText)
          ],
        )
        /*Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),*/
        );
  }
}

class TextDetectorPainter extends CustomPainter {
  TextDetectorPainter(this.absoluteImageSize, this.elements);

  final Size absoluteImageSize;
  final List<TextElement> elements;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(TextContainer container) {
      return Rect.fromLTRB(
        container.boundingBox.left * scaleX,
        container.boundingBox.top * scaleY,
        container.boundingBox.right * scaleX,
        container.boundingBox.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 2.0;

    for (TextElement element in elements) {
      canvas.drawRect(scaleRect(element), paint);
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return true;
  }
}
