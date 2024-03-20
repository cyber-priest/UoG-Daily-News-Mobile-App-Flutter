import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/auth_provider.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/screens/login.dart';
import 'package:uog_daily/screens/updateProfile.dart';
import 'package:uog_daily/screens/yourPost.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences pref = UsePreferences.pref;
  bool themeVal;
  bool isDark;
  String campuse;
  String role;
  bool langVal;
  @override
  void initState() {
    super.initState();
    themeVal = pref.getBool("light") ?? true;
    isDark = themeVal ? false : true;
    campuse = pref.getString("campuse") ?? "All";
    role = pref.getString("role") ?? "All";
    langVal = pref.getBool("isEnglish") ?? true;
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    var theme = Theme.of(context);
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return SafeArea(
      child: ListView(
        children: [
          user != null
              ? Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  child: Column(children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: theme.colorScheme.primary,
                      child: Text(
                        user.displayName[0],
                        style: TextStyle(
                            color: theme.colorScheme.secondary, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => UpdateProfile()));
                          },
                          label: Text(
                            lang.edit,
                            style: TextStyle(fontFamily: "monte"),
                          ),
                          icon: Icon(Icons.edit),
                        ),
                        TextButton.icon(
                            onPressed: () async {
                              await context.read<AuthProvider>().singOut();
                            },
                            icon: Icon(Icons.person_off),
                            label: Text(
                              lang.logOut,
                              style: TextStyle(fontFamily: "monte"),
                            ))
                      ],
                    ),
                  ]))
              : Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  child: Column(children: [
                    CircleAvatar(
                      backgroundColor: Color(0xff3E4685),
                      radius: 40,
                      child: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        lang.authUser,
                        style: TextStyle(
                          color: theme.textTheme.headline2.color,
                          fontFamily: "monte",
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              theme.colorScheme.primary.withOpacity(0.05))),
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LogIn()));
                      },
                      icon: Icon(
                        Icons.person,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      label: Text(
                        lang.login.toUpperCase(),
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontFamily: 'monte',
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ])),
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    lang.setting,
                    style: TextStyle(
                        color: theme.textTheme.headline2.color,
                        fontFamily: "monte"),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Colors.blueAccent,
                  ),
                  title: Text(lang.changeLang,
                      style: TextStyle(
                        color: theme.textTheme.headline2.color,
                        fontFamily: "monte",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      )),
                  trailing: DropdownButton(
                      value: langVal,
                      underline: SizedBox(),
                      style: TextStyle(
                          fontFamily: "monte",
                          color: theme.textTheme.headline2.color),
                      onChanged: (val) async {
                        context.read<LangProvider>().changeLang(val);
                        setState(() {
                          langVal = val;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                            value: true, child: Text(lang.english)),
                        DropdownMenuItem(
                            value: false, child: Text(lang.amharic)),
                      ]),
                ),
                SwitchListTile(
                  // leading: Icon(Icons.dark_mode),
                  onChanged: (val) {
                    context.read<CustomeTheme>().chooseChange(!val);
                    setState(() {
                      isDark = val;
                    });
                  },
                  value: isDark,
                  secondary: Icon(Icons.dark_mode),
                  title: Text(lang.darkMode,
                      style: TextStyle(
                        color: theme.textTheme.headline2.color,
                        fontFamily: "monte",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      )),
                ),
                Container(
                  child: Text(
                    lang.personalize,
                    style: TextStyle(
                        color: theme.textTheme.headline2.color,
                        fontFamily: "monte"),
                  ),
                ),
                ListTile(
                    leading: Icon(
                      Icons.bubble_chart_rounded,
                      color: Colors.teal,
                    ),
                    title: Text(lang.changeRole,
                        style: TextStyle(
                          color: theme.textTheme.headline2.color,
                          fontFamily: "monte",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        )),
                    trailing: DropdownButton(
                        value: role,
                        underline: SizedBox(),
                        style: TextStyle(
                            fontFamily: "monte",
                            color: theme.textTheme.headline2.color),
                        onChanged: (val) {
                          pref.setString("role", val);
                          setState(() {
                            role = val;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(lang.all),
                            value: "All",
                          ),
                          DropdownMenuItem(
                            child: Text(lang.student),
                            value: "Student",
                          ),
                          DropdownMenuItem(
                            child: Text(lang.teacher),
                            value: "Teacher",
                          ),
                          DropdownMenuItem(
                            child: Text(lang.staff),
                            value: "Staff",
                          ),
                        ])),
                ListTile(
                    leading: Icon(
                      FontAwesomeIcons.university,
                      color: Colors.redAccent,
                    ),
                    title: Text(lang.changeCampuse,
                        style: TextStyle(
                          color: theme.textTheme.headline2.color,
                          fontFamily: "monte",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        )),
                    trailing: DropdownButton(
                        underline: SizedBox(),
                        value: campuse,
                        style: TextStyle(
                            fontFamily: "monte",
                            color: theme.textTheme.headline2.color),
                        onChanged: (val) {
                          pref.setString("campuse", val);
                          setState(() {
                            campuse = val;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(lang.all),
                            value: "All",
                          ),
                          DropdownMenuItem(
                            child: Text(lang.tewodros),
                            value: "Tewodrows",
                          ),
                          DropdownMenuItem(
                            child: Text(lang.fasile),
                            value: "Fasile",
                          ),
                          DropdownMenuItem(
                            child: Text(lang.maraki),
                            value: "Maraki",
                          ),
                          DropdownMenuItem(
                            child: Text(lang.gc),
                            value: "Gc",
                          ),
                          DropdownMenuItem(
                            child: Text(lang.teda),
                            value: "Teda",
                          ),
                        ])),
                user != null
                    ? ListTile(
                        leading: Icon(
                          FontAwesomeIcons.newspaper,
                          color: Colors.brown,
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => YourPosts()));
                        },
                        title: Text(lang.yourPosts,
                            style: TextStyle(
                              color: theme.textTheme.headline2.color,
                              fontFamily: "monte",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                        trailing: Icon(Icons.arrow_forward_rounded))
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
