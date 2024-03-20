import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:uog_daily/engine/auth_provider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/screens/profile.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController usernameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController comfirmPassCon = TextEditingController();
  bool hasUsername = false;
  bool hasEmail = false;
  bool hasPassword = false;
  bool isUpdating = false;
  String usernameError;
  String emailError;
  String passwordError;
  bool isValidEmail(email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  Future<void> showPopUp() async {
    var theme = context.read<CustomeTheme>().theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: false).lang;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(lang.askLogout),
            content: Container(child: Text(lang.logOutEffect)),
            actions: <Widget>[
              TextButton(
                child: Text(lang.logOut.toUpperCase()),
                onPressed: () async {
                  await context.read<AuthProvider>().singOut();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(lang.cancel.toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var user = context.watch<User>();
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          lang.updateProfile,
          style: TextStyle(
            color: theme.textTheme.headline1.color,
            fontFamily: "monte",
            fontSize: 16,
          ),
        ),
      ),
      body: isUpdating || user == null
          ? Center(
              child: SpinKitDoubleBounce(
                color: theme.colorScheme.primary,
              ),
            )
          : ListView(
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Container(
                            color: theme.colorScheme.primary.withOpacity(0.05),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: theme.colorScheme.primary,
                                  child: Text(
                                    user.displayName[0],
                                    style: TextStyle(
                                        color: theme.colorScheme.secondary,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: Text(
                                    user.displayName,
                                    style: TextStyle(
                                      color: theme.textTheme.headline1.color,
                                      fontFamily: "monte",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    user.email,
                                    style: TextStyle(
                                      color: theme.textTheme.headline2.color,
                                      fontFamily: "monte",
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          child: Text(
                            lang.leaveItBlank,
                            style: TextStyle(
                              color: theme.textTheme.headline2.color,
                              fontFamily: "monte",
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        TextField(
                          controller: usernameCont,
                          onChanged: (text) {
                            if (text.length > 0) {
                              setState(() {
                                hasUsername = true;
                              });
                            } else {
                              setState(() {
                                hasUsername = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            errorText: usernameError,
                            labelText: lang.changeUserName,
                            labelStyle:
                                TextStyle(fontFamily: "monte", fontSize: 12),
                            prefixIcon: Icon(FontAwesomeIcons.user, size: 16),
                            // errorText: errorPassword,
                          ),
                        ),
                        hasUsername
                            ? TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        theme.colorScheme.primary
                                            .withOpacity(0.05))),
                                onPressed: () async {
                                  if (usernameCont.text.length >= 4) {
                                    setState(() {
                                      isUpdating = true;
                                      usernameError = null;
                                    });
                                    await user
                                        .updateDisplayName(usernameCont.text)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 30),
                                                  child:
                                                      Text(lang.usernameSuc))));
                                    }).catchError((error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 30),
                                                  child: Text(error.message
                                                      .toString()))));
                                    });
                                    setState(() {
                                      isUpdating = false;
                                      hasUsername = false;
                                      usernameCont.text = "";
                                    });
                                    await showPopUp();
                                  } else {
                                    setState(() {
                                      usernameError = lang.usernameErr;
                                    });
                                  }
                                },
                                icon: Icon(
                                  FontAwesomeIcons.check,
                                  size: 15,
                                  color: theme.colorScheme.primary,
                                ),
                                label: Text(
                                  lang.update.toUpperCase(),
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontFamily: 'monte',
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        TextField(
                          controller: emailCont,
                          onChanged: (text) {
                            if (text.length > 0) {
                              setState(() {
                                hasEmail = true;
                              });
                            } else {
                              setState(() {
                                hasEmail = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            errorText: emailError,
                            labelText: lang.changeEmail,
                            labelStyle:
                                TextStyle(fontFamily: "monte", fontSize: 12),
                            prefixIcon: Icon(Icons.email, size: 17),
                            // errorText: errorPassword,
                          ),
                        ),
                        hasEmail
                            ? TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        theme.colorScheme.primary
                                            .withOpacity(0.05))),
                                onPressed: () async {
                                  bool isValid = isValidEmail(emailCont.text);
                                  if (isValid) {
                                    setState(() {
                                      isUpdating = true;
                                      emailError = null;
                                    });
                                    await user
                                        .updateEmail(emailCont.text)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 30),
                                                  child: Text(lang.emailSuc))));
                                    }).catchError((error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 30),
                                                  child: Text(error.message
                                                      .toString()))));
                                    });
                                    setState(() {
                                      isUpdating = false;
                                      hasEmail = false;
                                      emailCont.text = "";
                                    });
                                    await showPopUp();
                                  } else {
                                    setState(() {
                                      emailError = lang.emailError;
                                    });
                                  }
                                },
                                icon: Icon(
                                  FontAwesomeIcons.check,
                                  size: 15,
                                  color: theme.colorScheme.primary,
                                ),
                                label: Text(
                                  lang.update.toUpperCase(),
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontFamily: 'monte',
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        TextField(
                          controller: passwordCont,
                          obscureText: true,
                          onChanged: (pass) {
                            if (pass.length > 0) {
                              setState(() {
                                hasPassword = true;
                              });
                            } else {
                              setState(() {
                                hasPassword = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            errorText: passwordError,
                            labelText: lang.newPassword,
                            labelStyle:
                                TextStyle(fontFamily: "monte", fontSize: 12),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        TextField(
                          controller: comfirmPassCon,
                          obscureText: true,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            labelText: lang.confirmPassword,
                            labelStyle:
                                TextStyle(fontFamily: "monte", fontSize: 12),
                            prefixIcon: Icon(Icons.lock),
                            errorText: passwordError,
                          ),
                        ),
                        hasPassword
                            ? TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        theme.colorScheme.primary
                                            .withOpacity(0.05))),
                                onPressed: () async {
                                  if (passwordCont.text ==
                                      comfirmPassCon.text) {
                                    if (passwordCont.text.length >= 6) {
                                      setState(() {
                                        isUpdating = true;
                                        passwordError = null;
                                      });
                                      await user
                                          .updatePassword(passwordCont.text)
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 30),
                                                    child: Text(
                                                        lang.passwordSuc))));
                                      }).catchError((error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 30),
                                                    child: Text(error.message
                                                        .toString()))));
                                      });
                                      setState(() {
                                        isUpdating = false;
                                        hasPassword = false;
                                        passwordCont.text = "";
                                        comfirmPassCon.text = "";
                                      });
                                      await showPopUp();
                                    } else {
                                      setState(() {
                                        passwordError = lang.passwordError;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      passwordError = lang.passwordErr;
                                    });
                                  }
                                },
                                icon: Icon(
                                  FontAwesomeIcons.check,
                                  size: 15,
                                  color: theme.colorScheme.primary,
                                ),
                                label: Text(
                                  lang.update.toUpperCase(),
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontFamily: 'monte',
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    )),
              ],
            ),
    );
  }
}
