import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_bloc.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_event.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_state.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/screens/article_screen/article_add.dart';
import 'package:comptabli_blog/app/shared_widgets/bottom_navigation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:uuid/uuid.dart';
import 'package:zefyr/zefyr.dart';

// ignore: must_be_immutable
class EditorPage extends StatefulWidget {
  Future<File> imageFile;
  Item item;
  EditorPage({@required this.imageFile, this.item});
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage>
    with SingleTickerProviderStateMixin {
  /// Allows to control the editor and the document.
  ZefyrController _controller;
  TabController _tabController;
  String text;
  bool uploading = false;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _tabController = TabController(length: 2, vsync: this);
    _focusNode = FocusNode();
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: widget.imageFile,
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

  _onCreateButtonPressed() {
    //String downloadUrl = await uploadPhotos(widget.imageFile);
    //widget.item.imageUrl = downloadUrl;
    //print(widget.item.imageUrl);
    String content = jsonEncode(_controller.document);
    widget.item.text = content;
    print(widget.item.text);

    BlocProvider.of<BlogBloc>(context).add(
      AddPost(item: widget.item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(color: Colors.black);
        String content = jsonEncode(_controller.document);

    widget.item.text = content;

    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ArticleForm(item: widget.item,)),
  );
                })
          ],
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Center(child: Text("Ajouter article", style: style)),
          backgroundColor: Colors.white,
          bottom: TabBar(controller: _tabController, tabs: [
            Tab(
              child: Text("Editer", style: style),
            ),
            Tab(
              child: Text("Preview", style: style),
            )
          ])),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Container(
            margin: EdgeInsets.all(20),
            child: 
                ZefyrScaffold(
              child: ZefyrEditor(
                padding: EdgeInsets.all(16),
                controller: _controller,
                focusNode: _focusNode,
              ),
            )),
             Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            ZefyrView(
              document: _controller.document,
            ),
            showImage(),
            
          ],
        ))
       
            ]));
    
   
  }

  NotusDocument _loadDocument() {
   
    final Delta delta = Delta()..insert("Text à ajouter\n");
    return NotusDocument.fromDelta(delta);
  }

  Future<String> uploadPhotos(Future<File> file) async {
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("posts photos");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(await file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
