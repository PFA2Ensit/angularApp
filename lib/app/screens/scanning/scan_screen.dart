
import 'dart:io';

//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'confirm_scan_screen.dart';






// A screen that allows users to take a picture using a given camera.
class ScanScreen extends StatefulWidget {
  // final CameraDescription camera;

  const ScanScreen({
    Key key,
    this.userEmail,
  }) : super(key: key);

  final String userEmail;

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  //CameraController _controller;
  //Future<void> _initializeControllerFuture;
  //List<CameraDescription> cameras;

  File imageFile;
  Future<File> image;

  File _image;
  final picker = ImagePicker();

Future getImage() async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
}
  pickImageFromGallery(ImageSource source) async  {
          var imageFile = await ImagePicker.pickImage(source: source);

    setState(() {
      imageFile  = imageFile;
      image = ImagePicker.pickImage(source: source);
    });
  }

  
  bool isClicked = false;
  bool showCamera = true;
  @override
  void initState() {
    super.initState();
    //setupCameras();

    // To display the current output from the Camera,
    // create a CameraController.
    // _controller = CameraController(
    //   // Get a specific camera from the list of available cameras.
    //   widget.camera,
    //   // Define the resolution to use.
    //   ResolutionPreset.medium,
    // );

    // Next, initialize the controller. This returns a Future.
    // _initializeControllerFuture = _controller.initialize();
  }

  /*Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      _controller = new CameraController(cameras[0], ResolutionPreset.high);
      _initializeControllerFuture =  _controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }*/

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    //_controller.dispose();
    super.dispose();
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: image,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 150,
            height: 70,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body:Container(child:isClicked ?Column(children: [Image.file(_image),RaisedButton(onPressed: () {  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScanConfirm(imageFile:_image,),
              ),
            ); },
      child: Text("go to scan"),)],) : Text("hello") ,), /*FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            print('Preview');
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            print('loading');

            return Center(child: CircularProgressIndicator());
          }
        },
      ),*/
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            //await _initializeControllerFuture;

            // Construct the path where the image should be saved using the 
            // pattern package.
            /*final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );*/
             getImage();
             setState(() {
               isClicked = true;
             });

             

            // Attempt to take a picture and log where it's been saved.
            //await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
           
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}