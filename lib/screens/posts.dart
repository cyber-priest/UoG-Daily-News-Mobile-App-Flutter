import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/models/news_model.dart';
import 'package:uog_daily/widgets/post_box.dart';

class Posts extends StatelessWidget {
  final SharedPreferences pref = UsePreferences.pref;
  @override
  Widget build(BuildContext context) {
    List news = newGenerator();
    var themeData = Provider.of<CustomeTheme>(context);
    var campuse = pref.getString("campuse") ?? "All";
    var role = pref.getString("role") ?? "All";
    var theme = themeData.theme;
    return RefreshIndicator(
      onRefresh: () async {},
      child: PaginateFirestore(
        itemsPerPage: 3,
        itemBuilderType: PaginateBuilderType.listView,
        query: FirebaseFirestore.instance
            .collection('Post')
            .where("campuse", isEqualTo: campuse)
            .where("target", isEqualTo: role)
            .orderBy('createdAt', descending: true),
        // to fetch real-time data
        isLive: true,
        itemBuilder: (context, documentSnapshots, index) {
          final data = documentSnapshots[index].data() as Map;
          return PostBox(data);
        },
      ),
    );
  }
}
