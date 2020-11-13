import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagingDemo extends StatefulWidget {
  @override
  _MessagingDemoState createState() => _MessagingDemoState();
}

class _MessagingDemoState extends State<MessagingDemo> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  TextEditingController _editingController = TextEditingController();
  bool _isEnabled = false;

  _getToken() {
    // _firebaseMessaging.deleteInstanceID();
    _firebaseMessaging.getToken().then((token) {
      print("Device Token: $token");
    });
  }

  @override
  void initState() {
    super.initState();
    //_getToken();
    //_configureFirebaseListeners();
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("demo"),
        ),
        body: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: _editTitleTextField(),

                trailing: InkWell(
                  child: new Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      _isEnabled = !_isEnabled;
                    });
                    print(_isEnabled);
                  },
                ),
              );
            }));
  }
}

class _editTitleTextField extends StatefulWidget{
bool _isEnabled = false;
TextEditingController _editingController = TextEditingController();

  

  @override
  __editTitleTextFieldState createState() => __editTitleTextFieldState();
}

class __editTitleTextFieldState extends State<_editTitleTextField> {
  @override
  Widget build(BuildContext context) {
   if (widget._isEnabled)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              widget._editingController.text = newValue;
               widget._isEnabled= false;
            });
          },
          autofocus: true,
          controller: widget._editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            widget._isEnabled = true;
          });
        },
        child: Text(
          'hello',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
}