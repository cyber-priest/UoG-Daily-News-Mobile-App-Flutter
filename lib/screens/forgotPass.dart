import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:uog_daily/engine/auth_provider.dart';
import 'package:uog_daily/engine/langProvider.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController emailController = TextEditingController();

  String errorEmail;
  String errorPassword;
  bool onProgress = false;
  bool isValidEmail(email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    var theme = Theme.of(context);
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return SafeArea(
        child: Scaffold(
            body: onProgress
                ? Center(
                    child:
                        SpinKitDoubleBounce(color: theme.colorScheme.primary))
                : ListView(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xff3E4685),
                          radius: 50,
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              lang.restText,
                              style: TextStyle(
                                fontFamily: "monte",
                              ),
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 5,
                                color: Colors.black12,
                              )
                            ],
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang.email,
                                  style: TextStyle(
                                    fontFamily: 'monte',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: emailController,
                                  autocorrect: true,
                                  onChanged: (email) {
                                    bool isValid = isValidEmail(email);
                                    setState(() {
                                      errorEmail =
                                          isValid ? null : lang.emailError;
                                      print(errorEmail);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "youremail@mail.com",
                                      hintStyle: TextStyle(
                                          fontFamily: "monte", fontSize: 14),
                                      prefixIcon:
                                          Icon(FontAwesomeIcons.userCircle),
                                      errorText: errorEmail),
                                ),
                              ]),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              onProgress = true;
                            });

                            context
                                .read<AuthProvider>()
                                .forgotPass(
                                  emailController.text,
                                )
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Container(
                                          margin: EdgeInsets.only(bottom: 30),
                                          child: Text(lang.restText))));
                              setState(() {
                                onProgress = false;
                                emailController.text = "";
                              });
                              Navigator.pop(context);
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Container(
                                          margin: EdgeInsets.only(bottom: 30),
                                          child:
                                              Text(error.message.toString()))));
                              setState(() {
                                onProgress = false;
                              });
                            });
                          },
                          child: Text(
                            lang.resetPass,
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 110, vertical: 15)),
                              backgroundColor: MaterialStateProperty.all(
                                  theme.colorScheme.background)),
                        )
                      ],
                    ),
                  ])));
  }
}
