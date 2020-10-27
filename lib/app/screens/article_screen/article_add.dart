import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_bloc.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_event.dart';
import 'package:comptabli_blog/app/modules/blog/bloc/blog_state.dart';
import 'package:comptabli_blog/app/modules/blog/data/model/Item.dart';
import 'package:comptabli_blog/app/screens/article_screen/articleList.dart';
import 'package:comptabli_blog/app/screens/article_screen/widgets/zefyr.dart';
import 'package:comptabli_blog/app/screens/home/home_screen.dart';
import 'package:comptabli_blog/app/shared_widgets/custom_input_field.dart';
import 'package:comptabli_blog/app/shared_widgets/fade_slide_transition.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/core/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tags/input_tags.dart';

import '../home.dart';

class ArticleForm extends StatefulWidget {
  Item item;
  ArticleForm({Key key,this.item}) : super(key: key);
  @override
  @override
  _ArticleFormState createState() => new _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm>
    with SingleTickerProviderStateMixin {
  int count = 1;
  List<String> chips = List();
  bool isClicked;
  TextEditingController controller;
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AnimationController _animationController;
  Animation<double> _formElementAnimation;
  Item item = new Item();

  double width = 100.0;
  double height = 35.0;

  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Stack(
            children: <Widget>[
              Container(
                  decoration: new BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  width: 400,
                  height: 120,
                  child: Image.file(
                    snapshot.data,
                    width: 300,
                    height: 300,
                  )),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    print('delete image from List');
                    setState(() {
                      isClicked = false;
                    });
                  },
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ),
            ],
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
  void initState() {
    super.initState();
    controller = TextEditingController(text: "ecrire ici");
    isClicked = false;
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );

    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);

    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    controller.dispose();
    super.dispose();
  }

  List<String> _tags = [];

  // ignore: non_constant_identifier_names
  Widget CategorieRow() {
    void _addNewCategorieRow() {
      setState(() {
        count = count + 1;
      });
    }

    return new Container(
        width: 170.0,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          Chip(
            onDeleted: () {
              setState(() {
                chips.removeAt(count - 1);
                count = count - 1;
                print(chips.toList());
              });
            },
            deleteIcon: Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
            backgroundColor: Colors.black,
            avatar: Container(
              width: 450,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: _addNewCategorieRow,
              ),
            ),
            label: Container(
                width: width,
                height: height,
                child: EditableText(
                  onChanged: (value) {
                    height = 50;
                  },
                  controller: controller,
                  onSubmitted: (text) {
                    chips.add(text);
                    print(chips.toList());
                    setState(() {
                      height = 35;
                    });
                  },
                  focusNode: FocusNode(),
                  backgroundCursorColor: Colors.white,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                )),
          ),
          new Container(
              //padding: new EdgeInsets.all(10.0),
              child: IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: _addNewCategorieRow)),
        ]));
  }

  _onCreateButtonPressed() async {
    String downloadUrl = await uploadPhotos(imageFile);
    widget.item.imageUrl = downloadUrl;
    //print(widget.item.imageUrl);
    //String content = jsonEncode(_controller.document);
    //widget.item.text = content;
    // print(item.text);

    BlocProvider.of<BlogBloc>(context).add(
      AddPost(item: widget.item),
    );
    addFeed();
    
    
  }

  addFeed() async{
      final FirebaseAuth _auth = FirebaseAuth.instance;

    FirebaseUser currentUser = await _auth.currentUser();
    DocumentSnapshot documentSnapshot =
        await usersReference.document(currentUser.uid).get();
 bool isNotPostOwner = currentUser.uid != widget.item.ownerId;
      if (isNotPostOwner){
        applicationFeedRef.document(widget.item.ownerId).collection("feedItems").document(widget.item.id).setData({
          "type":"articleAdded",
          "username" : documentSnapshot.data['fullname'].toString(),
          "postId" :widget.item.id,
          "timestamp":timestamp,
          "url":widget.item.imageUrl
        });
  }}

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;
    return BlocListener<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is PostSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleScreen(),
              ),
            );
          }
          if (state is PostFailed) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: new Scaffold(

            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: new AppBar(
              actions: [
                  IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        _onCreateButtonPressed();
                      })
                ],
              iconTheme: IconThemeData(color: Colors.black),
              title: new Center(
                  child: new Text(
                "Ajouter article",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              )),
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            body: Form(
                key: _formKey,
                child: new LayoutBuilder(builder: (context, constraint) {
                  return new Center(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        new Text(
                          "Nom de l'article",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: space,
                            child: CustomInputField(
                              label: "Entrer nom",
                              prefixIcon: Icons.person,
                              obscureText: false,
                              textController: _nameController,
                              validator: ValidatorService.articleNameValidate,
                              onChanged: (text) {
                                item.name = text;
                              },
                            )),
                        new Container(
                          padding: new EdgeInsets.all(30.0),
                        ),
                        new Text(
                          "Image de l'article",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        FadeSlideTransition(
                          animation: _formElementAnimation,
                          additionalOffset: space,
                          child: isClicked
                              ? showImage()
                              : RaisedButton(
                                  child: Text("Choisir l'image de l'article"),
                                  onPressed: () {
                                    setState(() {
                                      isClicked = true;
                                    });
                                    pickImageFromGallery(ImageSource.gallery);
                                  },
                                ),
                        ),
                        new Container(
                          padding: new EdgeInsets.all(10.0),
                        ),
                        new Text(
                          "Catégories",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: space,
                            child: new Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(20, 20)),
                                  border: Border.all(
                                    width: 3,
                                  ),
                                ),
                                height: 130.0,
                                width: 370.0,
                                child: InputTags(
                                  tags: _tags,
                                  onDelete: (tag) {
                                    print(tag);
                                  },
                                  onInsert: (tag) {
                                    print(tag);
                                    _tags.add(tag);
                                    widget.item.category = _tags;
                                  },
                                )

                                /*ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: count,
                              itemBuilder: (context, index) {
                                return CategorieRow();
                              }),*/
                                )),
                        /* new Container(
                      padding: new EdgeInsets.all(55.0),
                    ),*/
                        new Container(
                            width: 350,
                            //color: Colors.blue,
                            //padding: new EdgeInsets.all(10.0),
                            child: Row(children: <Widget>[
                              Container(
                                width: 270,
                              ),
                              new Container(
                                  width: 60,
                                  color: Colors.black,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          //_onCreateButtonPressed();
                                           Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditorPage(
                                              item:item, imageFile:imageFile),
                                        ),
                                      );
                                        }
                                      }))
                            ])),
                      ],
                    ),
                  );
                }))));
  }

  Future<String> uploadPhotos(Future<File> file) async {
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("posts photos");
    StorageUploadTask uploadTask = firebaseStorageRef.child("post_$postId.jpg").putFile(await file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
