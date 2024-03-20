import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/engine/route.dart';

class GetStarted extends StatelessWidget {
  final SharedPreferences pref = UsePreferences.pref;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xff3E4685),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: width,
                  child: Stack(children: [
                    Positioned(
                      bottom: 130,
                      right: 20,
                      child: Column(
                        children: [
                          Container(
                              height: 80,
                              child: Image(
                                image: AssetImage(
                                    "assets/images/Icon UoG-Daily.png"),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "UoG-Daily",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "monte",
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "monte",
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 300,
                        child: Image(
                          image: AssetImage("assets/images/jano.png"),
                        ))
                  ])),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    pref.setBool("firstTime", false);
                    Navigator.pushNamed(context, RouteGenerator.homePage);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        color: Color(0xff3E4685),
                        fontSize: 17,
                        fontFamily: "monte"),
                  ))
            ],
          ),
        ));
  }
}
