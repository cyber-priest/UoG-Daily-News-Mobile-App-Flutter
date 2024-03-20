import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/screens/yourPost.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences pref = UsePreferences.pref;
  bool themeVal;
  String campuse;
  bool isDark;
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
    var theme = context.read<CustomeTheme>().theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    var width = MediaQuery.of(context).size.width;
    var user = context.watch<User>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(lang.setting,
            style: TextStyle(
              color: theme.textTheme.headline1.color,
              fontFamily: "monte",
              fontSize: 16,
            )),
      ),
      body: Container(
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
                    DropdownMenuItem(value: true, child: Text(lang.english)),
                    DropdownMenuItem(value: false, child: Text(lang.amharic)),
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
    ));
  }
}
