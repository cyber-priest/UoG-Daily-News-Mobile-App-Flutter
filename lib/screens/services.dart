import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<CustomeTheme>(context).theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Text(
          lang.services,
          style: TextStyle(
            color: theme.textTheme.headline1.color,
            fontFamily: 'monte',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
		  height: 600,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            String url = 'http://10.139.8.236';
                            await launch(url);
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 110,
                                        child: Image(
                                          fit: BoxFit.fitHeight,
                                          image: AssetImage(
                                              "assets/images/register.png"),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          lang.onlineReg,
                                          style: TextStyle(
                                              color:
                                                  theme.textTheme.headline2.color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "monte"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async {
                                    String url = 'http://10.139.8.225';
                                    await launch(url);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.background,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 60,
                                          child: Image(
                                            fit: BoxFit.fitHeight,
                                            image: AssetImage(
                                                "assets/images/grade.png"),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            lang.studentInfo,
                                            style: TextStyle(
                                                color:
                                                    theme.textTheme.headline2.color,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                fontFamily: "monte"),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            String url = 'http://www.uog.edu.et/library';
                            await launch(url);
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.background,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 60,
                                        child: Image(
                                          fit: BoxFit.fitHeight,
                                          image: AssetImage(
                                              "assets/images/library.png"),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                         lang.library,
                                          style: TextStyle(
                                              color:
                                                  theme.textTheme.headline2.color,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              fontFamily: "monte"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () async {
                                    String url = 'http://E-Learning.elearning.uog';
                                    await launch(url);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.background,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 110,
                                          child: Image(
                                            fit: BoxFit.fitHeight,
                                            image: AssetImage(
                                                "assets/images/teacher.png"),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            lang.eLearning,
                                            style: TextStyle(
                                                color:
                                                    theme.textTheme.headline2.color,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                fontFamily: "monte"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      String url = 'http://www.uog.edu.et';
                      await launch(url);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 80,
                              child: Image(
                                fit: BoxFit.fitHeight,
                                image: AssetImage("assets/images/logo.png"),
                              ),
                            ),
                            Text(
                              lang.web,
                              style: TextStyle(
                                  color: theme.textTheme.headline2.color,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "monte"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
