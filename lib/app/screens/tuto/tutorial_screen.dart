
import 'package:comptabli_blog/app/screens/tuto/widgets/tuto_card_widget.dart';
import 'package:comptabli_blog/app/shared_widgets/logo.dart';
import 'package:comptabli_blog/app/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../app_routes.dart';


class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final List<Map<String, String>> cardsContentList = [
    {
      "title": "Scan.",
      "body":
          "Scannez vos pièces comptable et laissez le système IA de Comptabli.® détecter toutes les informations nécessaires.",
    },
    {
      "title": "Store.",
      "body":
          "Toutes vos données importantes seront sauvegardées d’une façon sécurisée dans votre cloud personnalisé.",
    },
    {
      "title": "Generate.",
      "body":
          "Vos déclarations fiscales et sociales sont générées et mises a votre disposition pour toutes les échéances.",
    }
  ];
  int _numPages = 0;

  @override
  void initState() {
    _numPages = cardsContentList.length;
    super.initState();
  }

  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 15,
      width: isActive ? 30 : 15,
      decoration: BoxDecoration(
        color: kColorBlack,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  navigateToLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(kLoginRoute, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 12,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: AppLogo(
                        dark: true,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: PageView.builder(
                        itemCount: cardsContentList.length,
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return TutoCard(
                            title: cardsContentList[index]["title"],
                            body: cardsContentList[index]["body"],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: 30,
                        child: Container(
                          child: _currentPage == 2
                              ? IconButton(
                                  color: kColorBlack,
                                  onPressed: () {
                                    navigateToLogin();
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward,
                                  ))
                              : FlatButton(
                                  textColor: kColorBlack,
                                  child: Text("Passer"),
                                  onPressed: () {
                                    navigateToLogin();
                                  },
                                ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildPageIndicator(),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
