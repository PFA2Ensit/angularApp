import 'dart:io';
import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:comptabli_blog/app/screens/compte_screen/interests_screen.dart';
import 'package:comptabli_blog/app/shared_widgets/custom_input_field.dart';
import 'package:comptabli_blog/app/shared_widgets/fade_slide_transition.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final Compte compte;

  EditProfilePage({Key key, this.compte}) : super(key: key);
  @override
  @override
  _CompteFormState createState() => new _CompteFormState();
}

class _CompteFormState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  int count = 1;
  List<String> _tags = [];
  File profileImage;

  TextEditingController controller;
  TextEditingController _fullnameController;
  TextEditingController _positionController;

  final _formKey = GlobalKey<FormState>();
  AnimationController _animationController;
  Animation<double> _formElementAnimation;
  var name = "";
  var position = "";
  Compte compte = new Compte();
  double width = 100.0;
  double height = 35.0;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "ecrire ici");
    _fullnameController = TextEditingController(text: widget.compte.fullname);
    _positionController = TextEditingController(text: widget.compte.position);

    _tags = widget.compte.expertises.cast<String>().toList();

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
    //_fullnameController.dispose();
    //_positionController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future pickImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profileImage = image;
    });
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        child: GestureDetector(
            onTap: () {
              pickImageFromGallery();
            },
            child: profileImage == null
                ? Icon(Icons.add_a_photo)
                : Container(
                    decoration: BoxDecoration(
                        color: kColorBlack,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Image.file(
                      profileImage,
                      fit: BoxFit.cover,
                    ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: new Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.black,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Form(
            key: _formKey,
            child: new LayoutBuilder(builder: (context, constraint) {
              return new Center(
                child: new ListView(
                  padding: EdgeInsets.all(15),
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    _buildProfileImage(),
                    new Text(
                      "Nom et prénom",
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
                          //label: 'Votre nom',
                          prefixIcon: Icons.person,
                          obscureText: false,
                          textController: _fullnameController,
                          validator: ValidatorService.fullNameValidate,
                          onChanged: (text) {
                            compte.fullname = text;
                          },
                        )),
                    new Container(
                      padding: new EdgeInsets.all(30.0),
                    ),
                    new Text(
                      "Position",
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
                          label: 'Position',
                          prefixIcon: Icons.work,
                          obscureText: false,
                          textController: _positionController,
                          validator: ValidatorService.positionValidate,
                          onChanged: (text) {
                            compte.position = text;
                          },
                        )),
                    new Container(
                      padding: new EdgeInsets.all(30.0),
                    ),
                    new Text(
                      "Expertises",
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
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(20, 20)),
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
                                compte.expertises = _tags;
                              },
                            ))),
                    new Container(
                      padding: new EdgeInsets.all(40.0),
                    ),
                    new Container(
                        width: 350,
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InterestsPage(
                                              compte: compte,
                                              profileImage: profileImage),
                                        ),
                                      );
                                    }
                                  }))
                        ])),
                  ],
                ),
              );
            })));
  }
}
