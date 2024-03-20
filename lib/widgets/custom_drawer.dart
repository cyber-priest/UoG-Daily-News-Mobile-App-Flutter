import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/route.dart';
import 'package:uog_daily/engine/theme.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width / 1.2;
    var themeData = Provider.of<CustomeTheme>(context);
    var theme = themeData.theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: _width,
      color: theme.colorScheme.secondaryVariant,
      child: ListView(
        children: [
          Container(
            height: 270,
            width: _width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Stack(children: [
              Positioned(
                top: 20,
                right: 30,
                child: Container(
                  height: 235,
                  width: _width,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20)),
                    child: Image(
                      image: AssetImage("assets/images/Path 28.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                height: 235,
                width: _width,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20)),
                  child: Image(
                    image: AssetImage("assets/images/Path 27.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                    icon: themeData.isWhite == false
                        ? Icon(Icons.wb_sunny, color: Colors.white)
                        : Icon(Icons.nightlight, color: Colors.white),
                    onPressed: () {
                      themeData.changeTheme();
                    }),
              ),
              Positioned(
                  top: 35,
                  left: 0,
                  child: Container(
                    width: _width,
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          child: Image(
                            image:
                                AssetImage("assets/images/Icon UoG-Daily.png"),
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Column(
                            children: [
                              Text(
                                "UoG Daily",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'monte',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                lang.drawerHeader,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'monte',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ]),
          ),
          Container(
            height: 340,
            padding: EdgeInsets.only(top: 10, left: 50),
            // color: Colors.white.withOpacity(0.8),
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                List items = [
                  lang.setting,
                  lang.services,
                  lang.contactUs,
                  lang.about,
                ];
                List icons = [
                  Icon(Icons.settings, color: Colors.lightBlue, size: 20),
                  Icon(Icons.account_tree_rounded,
                      color: theme.colorScheme.surface, size: 20),
                  Icon(FontAwesomeIcons.phoneSquare,
                      color: Colors.redAccent, size: 20),
                  Icon(FontAwesomeIcons.infoCircle,
                      color: Colors.tealAccent, size: 20),

                  // mina@23/09/09
                ];
                return Container(
                  child: ListTile(
                      leading: icons[index],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Text(
                        items[index],
                        style: TextStyle(
                          color: theme.textTheme.headline1.color,
                          fontFamily: 'monte',
                        ),
                      ),
                      dense: true,
                      onTap: () {
                        if (index == 0)
                          Navigator.pushNamed(context, RouteGenerator.settings);
                        else if (index == 1)
                          Navigator.pushNamed(context, RouteGenerator.services);
                        else if (index == 2)
                          Navigator.pushNamed(
                              context, RouteGenerator.contactUs);
                        else
                          Navigator.pushNamed(context, RouteGenerator.about);
                      }),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
