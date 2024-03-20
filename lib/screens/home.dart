import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:uog_daily/widgets.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<dynamic> getBreakingNews() {
    return FirebaseFirestore.instance
        .collection("News")
        .where("breaking", isEqualTo: true)
        .limit(5)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<CustomeTheme>(context).theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return RefreshIndicator(
      onRefresh: () async {
        print(lang.breakingNews);
      },
      child: PaginateFirestore(
        header: SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 15, bottom: 15),
                    child: Text(
                      lang.breakingNews,
                      style: TextStyle(
                          color: theme.colorScheme.surface,
                          fontFamily: "monte",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: Icon(
                      FontAwesomeIcons.newspaper,
                      color: theme.colorScheme.surface,
                      size: 17,
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: getBreakingNews(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (!snapshot.hasData) {
                    return CarouselSlider.builder(
                        itemCount: 3,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlay: true,
                          // enlargeCenterPage: true,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return Shimmer.fromColors(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                        spreadRadius: 0)
                                  ],
                                ),
                              ),
                              baseColor: Colors.white,
                              highlightColor: Colors.grey[200]);
                        });
                  }
                  return CarouselSlider.builder(
                      itemCount: data.docs.length,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        // enlargeCenterPage: true,
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Anounce(data.docs[index]);
                      });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15, bottom: 15),
                    child: Text(
                      lang.recent,
                      style: TextStyle(
                          color: theme.colorScheme.surface,
                          fontFamily: "monte",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: Icon(
                      Icons.access_time,
                      color: theme.colorScheme.surface,
                      size: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        itemsPerPage: 3,
        itemBuilderType:
            PaginateBuilderType.listView, //Change types accordingly
        itemBuilder: (context, documentSnapshots, index) {
          final data = documentSnapshots[index].data() as Map;
          return NewsBox(data);
        },
        // orderBy is compulsory to enable pagination
        query: FirebaseFirestore.instance
            .collection('News')
            .orderBy('createdAt', descending: true),
        // to fetch real-time data
        isLive: true,
      ),
    );
    // StreamBuilder<QuerySnapshot>(
    //     stream: firestore
    //         .collection("News")
    //         .orderBy("createdAt", descending: true)
    //         .snapshots(),
    //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return Text('Something went wrong');
    //       }

    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Text("Loading");
    //       }
    //       return Container(
    //         child: ListView(
    //             children:
    //                 snapshot.data.docs.map((news) => NewsBox(news)).toList()),
    //       );
    //     });
    // return ListView(
    //   children: [
    //     Container(
    //       margin: EdgeInsets.only(top: 20, left: 15, bottom: 15),
    //       child: Text(
    //         "Pinned",
    //         style: TextStyle(
    //             color: theme.textTheme.headline3.color,
    //             fontFamily: "monte",
    //             fontWeight: FontWeight.w700),
    //       ),
    //     ),
    //     CarouselSlider.builder(
    //         itemCount: 8,
    //         options: CarouselOptions(
    //           enlargeCenterPage: true,
    //           autoPlay: true,
    //           // enlargeCenterPage: true,
    //         ),
    //         itemBuilder: (BuildContext context, int index, int realIndex) {
    //           return Anounce();
    //         }),
    //

    //   ],
    // );
  }
}
