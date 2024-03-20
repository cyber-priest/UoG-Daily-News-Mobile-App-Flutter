import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:uog_daily/widgets/schedule_box.dart';

class Schedule extends StatelessWidget {
  final SharedPreferences pref = UsePreferences.pref;
  @override
  Widget build(BuildContext context) {
    List news = newGenerator();
    var theme = Theme.of(context);
    var campuse = pref.getString("campuse") ?? "All";
    var role = pref.getString("role") ?? "All";
    return PaginateFirestore(
      itemsPerPage: 3,
      itemBuilderType: PaginateBuilderType.listView,
      query: FirebaseFirestore.instance
          .collection('Schedule')
          .where("target", isEqualTo: role)
          .where("campuse", isEqualTo: campuse)
          .orderBy('createdAt', descending: true),
      // to fetch real-time data
      isLive: true,
      itemBuilder: (context, documentSnapshots, index) {
        final data = documentSnapshots[index].data() as Map;
        return ScheduleBox(data);
      },
    );
  }
}
