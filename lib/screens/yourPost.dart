import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/src/provider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/widgets/EditBox.dart';

class YourPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var user = context.watch<User>();
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Your Posts",
            style: TextStyle(
              color: theme.textTheme.headline1.color,
              fontFamily: "monte",
              fontSize: 16,
            ),
          ),
        ),
        body: Container(
            child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: theme.colorScheme.primary,
                      labelColor: theme.textTheme.headline1.color,
                      labelStyle: TextStyle(fontFamily: "monte"),
                      tabs: [
                        Tab(
                          text: lang.news,
                        ),
                        Tab(
                          text: lang.post,
                        ),
                        Tab(
                          text: lang.schedule,
                        )
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        PaginateFirestore(
                          itemsPerPage: 1,
                          itemBuilderType: PaginateBuilderType.listView,
                          query: FirebaseFirestore.instance
                              .collection('News')
                              .where("posterId", isEqualTo: user.uid)
                              .orderBy('createdAt', descending: true),
                          // to fetch real-time data
                          isLive: true,
                          itemBuilder: (context, documentSnapshots, index) {
                            final data = documentSnapshots[index].data() as Map;
                            final id = documentSnapshots[index].id;
                            return EditBox(data, id, "News");
                          },
                        ),
                        PaginateFirestore(
                          itemsPerPage: 1,
                          itemBuilderType: PaginateBuilderType.listView,
                          query: FirebaseFirestore.instance
                              .collection('Post')
                              .where("poster", isEqualTo: user.displayName)
                              .orderBy('createdAt', descending: true),
                          // to fetch real-time data
                          isLive: true,
                          itemBuilder: (context, documentSnapshots, index) {
                            final data = documentSnapshots[index].data() as Map;
                            final id = documentSnapshots[index].id;
                            return EditBox(data, id, "Post");
                          },
                        ),
                        PaginateFirestore(
                          itemsPerPage: 1,
                          itemBuilderType: PaginateBuilderType.listView,
                          query: FirebaseFirestore.instance
                              .collection('Schedule')
                              .where("poster", isEqualTo: user.displayName)
                              .orderBy('createdAt', descending: true),
                          // to fetch real-time data
                          isLive: true,
                          itemBuilder: (context, documentSnapshots, index) {
                            final data = documentSnapshots[index].data() as Map;
                            final id = documentSnapshots[index].id;
                            return EditBox(data, id, "Schedule");
                          },
                        ),
                      ]),
                    )
                  ],
                ))),
      ),
    );
  }
}
