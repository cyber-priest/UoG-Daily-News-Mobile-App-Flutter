import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = context.read<CustomeTheme>().theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return SafeArea(
        child: Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        iconTheme: IconThemeData(color: Colors.blueGrey),
        title: Text(
          lang.about,
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
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              CircleAvatar(
                backgroundColor: Color(0xff3E4685),
                radius: 60,
                child: Container(
                    height: 80,
                    child: Image(
                      image: AssetImage('assets/images/Icon UoG-Daily.png'),
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'UoG-Daily',
                style: TextStyle(
                  color: theme.textTheme.headline1.color,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monte',
                ),
              ),
              Text(
                lang.version,
                style: TextStyle(
                  color: theme.textTheme.headline2.color,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'monte',
                  fontSize: 13,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  lang.copyRight,
                  style: TextStyle(
                    color: theme.textTheme.headline2.color,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'monte',
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.dev,
                  style: TextStyle(
                      color: theme.textTheme.headline1.color,
                      // fontWeight: FontWeight.w300,
                      fontSize: 16,
                      fontFamily: 'monte'),
                ),
                Divider(
                  color: theme.colorScheme.primary,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.background,
                      radius: 40,
                      backgroundImage: AssetImage(
                        'assets/images/My_Pic.png',
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      lang.devName,
                      style: TextStyle(
                          color: theme.textTheme.headline1.color,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          fontFamily: 'monte'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Text(
                  lang.aboutDev,
                  style: TextStyle(
                    color: theme.textTheme.headline2.color,
                    fontFamily: 'monte',
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.justify,
                ))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
