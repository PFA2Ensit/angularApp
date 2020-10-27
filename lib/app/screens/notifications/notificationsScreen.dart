import 'package:comptabli_blog/app/screens/notifications/widgets/notificationItem.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postImage;

  NotificationsPage({this.postId, this.postOwnerId, this.postImage});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Notifications page",style: TextStyle(color:kColorBlack),),
          elevation: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Expanded(
              child: NotifItem(postId: widget.postId),
            ),
          ],
        ));
  }
}
