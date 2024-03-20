import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/widgets.dart';
import 'package:uog_daily/widgets/post_box.dart';
import 'package:uog_daily/widgets/schedule_box.dart';

class Search extends StatelessWidget {
  final String searchWord;
  final String type;
  Search(this.searchWord, this.type);
  Future getData() async {
    return await FirebaseFirestore.instance
        .collection(type)
        .orderBy("createdAt")
        .limit(50)
        .get();
  }

  Future searchData(word) async {
    String title;
    String body;
    List newDocs = [];
    var data = await getData();
    for (var doc in data.docs) {
      title = doc["title"].toLowerCase();
      body = doc["body"].toLowerCase();
      if (body.contains(word.toLowerCase()) ||
          title.contains(word.toLowerCase())) {
        newDocs.add(doc);
      }
    }
    return newDocs;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<CustomeTheme>(context, listen: true).theme;
    var width = MediaQuery.of(context).size.width;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return FutureBuilder(
        future: searchData(searchWord),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SpinKitDoubleBounce(
                color: theme.colorScheme.primary,
              ),
            );
          }
          if (snapshot.data.length == 0) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.sadCry,
                      size: 50,
                      color: theme.textTheme.headline2.color,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: width / 1.7,
                        child: Text(
                          lang.searchFail,
                          style: TextStyle(
                            color: theme.textTheme.headline2.color,
                            fontFamily: "monte",
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              ),
            );
          }
          var data = snapshot.data;
          return ListView.builder(
            itemCount: data.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Text.rich(TextSpan(
                            text: lang.searchResult,
                            style: TextStyle(
                                fontFamily: "monte",
                                fontWeight:FontWeight.w600,
                                color: theme.textTheme.headline2.color),
                            children: [
                              TextSpan(
                                text: "'$searchWord'",
                                style: TextStyle(
                                    fontFamily: "monte",
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w700),
                              )
                            ]))));
              } else {
                if (type == "News") {
                  return NewsBox(data[index - 1]);
                } else if (type == "Post") {
                  return PostBox(data[index - 1]);
                } else {
                  return ScheduleBox(data[index - 1]);
                }
              }
            },
          );
        });
  }
}
