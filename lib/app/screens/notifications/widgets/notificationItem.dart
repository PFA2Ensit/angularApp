import 'package:comptabli_blog/app/modules/notifications/bloc/notifications_bloc.dart';
import 'package:comptabli_blog/app/modules/notifications/data/model/notifications.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as tAgo;

class NotifItem extends StatefulWidget {
  final String postId;
  const NotifItem({Key key, this.postId}) : super(key: key);

  @override
  _NotifItemtate createState() => _NotifItemtate();
}

class _NotifItemtate extends State<NotifItem> {
  NotificationsBloc bloc;
  String notificationItemText;
  Widget media;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<NotificationsBloc>(context);
    bloc.add(RetrieveNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
        if (state is NotifFetchErrorState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else {
          return Container();
        }
      },
      child: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsInitial) {
            return buildLoading();
          } else if (state is NotifLoadingState) {
            return buildLoading();
          } else if (state is NotifLoadedState) {
            return buildCommentsList(state.notif);
          } else if (state is NotifFetchErrorState) {
            return buildErrorUi(state.message);
          } else
            return Container();
        },
      ),
    );
  }

  Widget buildCommentsList(List<Notifications> notif) {
    return ListView.builder(
        itemCount: notif.length,
        itemBuilder: (ctx, pos) {
          if (notif[pos].type == "like") {
            notificationItemText = "liked your post";
          } else if (notif[pos].type == "comment") {
            notificationItemText = "commented your post";
          } else {
            notificationItemText = "shared new post";
          }
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Container (
            decoration: new BoxDecoration (
                color: Colors.grey),
            child:ListTile(
                title: RichText(
                  overflow: TextOverflow.ellipsis,
                  text:
                      TextSpan(style: TextStyle(color: kColorBlack), children: [
                    TextSpan(
                        text: notif[pos].username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "$notificationItemText"),
                  ]),
                ),
                subtitle: Text(
                  tAgo.format(notif[pos].timestamp.toDate()),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                    width: 50.0,
                    height: 50.0,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        child: Image.network(
                          notif[pos].url,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),
                /*leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(comment[pos].url)),
            ),*/
              )));
        });
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
