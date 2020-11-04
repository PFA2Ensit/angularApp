import 'package:comptabli_blog/app/modules/compte/data/model/compte.dart';
import 'package:comptabli_blog/app/shared_widgets/custom_input_field.dart';
import 'package:comptabli_blog/app/shared_widgets/fade_slide_transition.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:comptabli_blog/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/input_tags.dart';

import 'interests_screen.dart';

/*void main() => runApp(
      new MaterialApp(
        home: new ResponsavelProfilePage(),
      ),
    );*/

class CompteForm extends StatefulWidget {
  CompteForm({Key key}) : super(key: key);
  @override
  @override
  _CompteFormState createState() => new _CompteFormState();
}

class _CompteFormState extends State<CompteForm>
    with SingleTickerProviderStateMixin {
  int count = 1;

  List<String> chips = List();
  TextEditingController controller;
  final _fullnameController = TextEditingController();
  final _positionController = TextEditingController();
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
    _fullnameController.dispose();
    _positionController.dispose();
    controller.dispose();
    super.dispose();
  }

    List<String> _tags = [];


  // ignore: non_constant_identifier_names
  Widget ExpertiseRow() {
    void _addNewExpertiseRow() {
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
                onPressed: _addNewExpertiseRow,
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
              child: IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: _addNewExpertiseRow)),
        ]));
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
          title: new Center(
              child: new Text(
            "Compte Entrepreneur",
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
                          label: 'Votre nom',
                          prefixIcon: Icons.person,
                          obscureText: false,
                          textController: _fullnameController,
                          validator: ValidatorService.fullNameValidate,
                          onChanged: (text) {
                            compte.fullname = text;
                            print(compte.fullname);
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
                            print(compte.position);
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
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(20, 20)),
                                  border: Border.all(
                                    width: 3,
                                  ),
                                ),
                                height: 130.0,
                                width: 370.0,
                                child: InputTags(
                                  color: kColorBlack,
                                  tags: _tags,
                                  onDelete: (tag) {
                                    print(tag);
                                  },
                                  onInsert: (tag) {
                                    print(tag);
                                    _tags.add(tag);
                                    compte.expertises = _tags;
                                  },
                                )

                                /*ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: count,
                              itemBuilder: (context, index) {
                                return CategorieRow();
                              }),*/
                                )
                        
                        
                        
                        
                        /*new Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(20, 20)),
                            border: Border.all(
                              width: 3,
                            ),
                          ),
                          height: 130.0,
                          width: 370.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: count,
                              itemBuilder: (context, index) {
                                return ExpertiseRow();
                              }),
                        )*/),
                    new Container(
                      padding: new EdgeInsets.all(55.0),
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
                                          builder: (context) =>
                                              InterestsPage(compte: compte),
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
