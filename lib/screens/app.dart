import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/auth_provider.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/screens/createPost.dart';
import 'package:uog_daily/screens/getStarted.dart';
import 'package:uog_daily/screens/home.dart';
import 'package:uog_daily/screens/profile.dart';
import 'package:uog_daily/screens/schedule.dart';
import 'package:uog_daily/screens/posts.dart';
import 'package:uog_daily/screens/search.dart';
import 'package:uog_daily/widgets.dart';
import 'package:uog_daily/widgets/custom_drawer.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> _pages = [Home(), Posts(), Schedule(), Profile()];
  TextEditingController sWord = TextEditingController();
  final List collections = ["News", "Post", "Schedule"];
  String _currentCol = "News";
  Widget _currentPage = Home();
  int currentIndex = 0;
  SharedPreferences pref = UsePreferences.pref;
  bool isFirst;
  @override
  void initState() {
    super.initState();
    isFirst = pref.getBool("firstTime") ?? true;
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    var themeData = Provider.of<CustomeTheme>(context);
    var theme = themeData.theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return isFirst
        ? GetStarted()
        : Scaffold(
            drawer: CustomDrawer(),
            appBar: _currentPage.runtimeType == Profile
                ? null
                : AppBar(
                    leading: _currentPage.runtimeType == Search
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _currentPage = _pages[currentIndex];
                              });
                            },
                            icon: Icon(Icons.arrow_back,
                                color: theme.colorScheme.onSurface))
                        : null,
                    backgroundColor: theme.primaryColor,
                    iconTheme:
                        IconThemeData(color: theme.colorScheme.onSurface),
                    elevation: 5,
                    actions: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        // padding: EdgeInsets.only(top: 5),
                        width: MediaQuery.of(context).size.width / 1.7,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextField(
                            controller: sWord,
                            onSubmitted: (word) {
                              setState(() {
                                _currentPage = Search(word, _currentCol);
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30)),
                              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                              hintText: lang.searchPlace,
                              hintStyle: TextStyle(fontSize: 12),
                              prefixIcon: Icon(Icons.search),
                            ),
                            style: TextStyle(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _currentPage = Search(sWord.text, _currentCol);
                          });
                        },
                        icon: Icon(Icons.search,
                            color: theme.colorScheme.onSurface),
                      ),
                      user != null
                          ? IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CreatePost()));
                              },
                              icon: Icon(Icons.add,
                                  color: theme.colorScheme.onSurface))
                          : SizedBox(),
                    ],
                  ),
            body: _currentPage,
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.flip,
              backgroundColor: theme.colorScheme.secondaryVariant,
              // circleColor: theme.colorScheme.primary,
              activeColor: theme.colorScheme.surface,
              // textColor: theme.colorScheme.primary,
              // inactiveIconColor: theme.colorScheme.primary,
              // initialSelection: 0,
              items: [
                TabItem(
                  icon:
                      Icon(Icons.home, color: theme.colorScheme.primaryVariant),
                  activeIcon:
                      Icon(Icons.home, color: theme.colorScheme.surface),
                  title: lang.home,
                ),
                TabItem(
                  icon: Icon(Icons.push_pin,
                      color: theme.colorScheme.primaryVariant),
                  activeIcon:
                      Icon(Icons.push_pin, color: theme.colorScheme.surface),
                  title: lang.post,
                ),
                TabItem(
                  icon: Icon(Icons.calendar_today,
                      color: theme.colorScheme.primaryVariant),
                  activeIcon: Icon(Icons.calendar_today,
                      color: theme.colorScheme.surface),
                  title: lang.schedule,
                ),
                TabItem(
                  icon: Icon(Icons.person,
                      color: theme.colorScheme.primaryVariant),
                  activeIcon:
                      Icon(Icons.person, color: theme.colorScheme.surface),
                  title: lang.profile,
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentPage = _pages[index];
                  currentIndex = index;
                  if (index < 3) {
                    _currentCol = collections[index];
                  }
                });
              },
            ),
          );
  }
}
