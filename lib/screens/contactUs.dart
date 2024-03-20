import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  final Uri emailUri = Uri(
    scheme: "mailto",
    path: "mikael.dev.official@gmail.com",
  );
  @override
  Widget build(BuildContext context) {
    var theme = context.read<CustomeTheme>().theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return SafeArea(
        child: Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          lang.contactUs,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.telegram,
                  style: TextStyle(
                    color: theme.textTheme.headline1.color,
                    fontFamily: 'monte',
                    fontSize: 16,
                  ),
                ),
                Divider(
                  color: theme.textTheme.headline2.color,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          theme.colorScheme.primary.withOpacity(0.05))),
                  onPressed: () async {
                    String url = 'https://te.me/@Gatomii';
                    await launch(url);
                  },
                  icon: Icon(
                    FontAwesomeIcons.telegram,
                    size: 25,
                    color: theme.colorScheme.primary,
                  ),
                  label: Text(
                    '@Gatomii',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontFamily: 'monte',
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  lang.email,
                  style: TextStyle(
                    color: theme.textTheme.headline1.color,
                    fontFamily: 'monte',
                    fontSize: 16,
                  ),
                ),
                Divider(
                  color: theme.textTheme.headline2.color,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              theme.colorScheme.primary.withOpacity(0.05))),
                      onPressed: () async {
                        await launch(emailUri.toString());
                      },
                      icon: Icon(
                        Icons.email,
                        size: 25,
                        color: theme.colorScheme.primary,
                      ),
                      label: Text(
                        'mikael.dev.official@gmail.com',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontFamily: 'monte',
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
