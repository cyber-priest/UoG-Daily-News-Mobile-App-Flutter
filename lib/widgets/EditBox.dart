import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uog_daily/engine/EditDataProvider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/screens/NewsFullContent.dart';
import 'package:uog_daily/screens/PostFullContent.dart';
import 'package:uog_daily/screens/ScheduleFullContent.dart';
import 'package:uog_daily/screens/update.dart';

class EditBox extends StatefulWidget {
  final data;
  final id;
  final type;

  EditBox(this.data, this.id, this.type);

  @override
  State<EditBox> createState() => _EditBoxState();
}

class _EditBoxState extends State<EditBox> {
  final iconList = {
    "News": Icon(FontAwesomeIcons.newspaper),
    "Post": Icon(Icons.push_pin),
    "Schedule": Icon(Icons.calendar_today)
  };
  bool deleting = false;

  deletePost(String type, String id, String url) async {
    if (url != "no") {
      if (!url.contains("Placeholders")) {
        await FirebaseStorage.instance.refFromURL(url).delete();
      }
    }
    await FirebaseFirestore.instance.collection(type).doc(id).delete();
  }

  Future<void> showPopUp() async {
    var theme = context.read<CustomeTheme>().theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: false).lang;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(lang.deleteTitle),
            content: Container(child: Text(lang.deleteWarning)),
            actions: <Widget>[
              TextButton(
                child: Text(lang.delete.toUpperCase()),
                onPressed: () async {
                  try {
                    await deletePost(
                        widget.type, widget.id, widget.data["url"]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(lang.deleteSuccess),
                    )));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(lang.deleteFail),
                    )));
                  }
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(lang.cancel.toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.read<CustomeTheme>().theme;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          if (widget.type == "News") {
            return NewsFullContent(widget.data);
          } else if (widget.type  == "Post") {
            return PostFullContent(widget.data);
          } else {
            return ScheduleFullContent(widget.data);
          }
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 4,
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  // height: 140,
                  child: Column(
                    children: [
                      // SizedBox(height: 20),
                      Container(
                        child: Text(
                          widget.data["title"],
                          style: TextStyle(
                            color: theme.textTheme.headline1.color,
                            fontFamily: 'lora',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            wordSpacing: 2.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.eye,
                                  size: 13,
                                  color: theme.textTheme.headline2.color,
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Text(
                              widget.data["date"],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: theme.textTheme.headline2.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                widget.data["url"] != "no"
                    ? Container(
                        height: 130,
                        width: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: widget.data["url"],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100]),
                              errorWidget: (context, url, error) =>
                                  Shimmer.fromColors(
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100]),
                            )))
                    : SizedBox(),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Update(widget.data, widget.id)));
                    },
                    label: Text(
                      lang.edit,
                      style: TextStyle(
                          color: theme.textTheme.headline2.color,
                          fontFamily: "monte"),
                    ),
                    icon: Icon(
                      Icons.edit,
                      color: theme.textTheme.headline2.color,
                      size: 20,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await showPopUp();
                    },
                    label: Text(
                      lang.delete,
                      style: TextStyle(
                          color: theme.textTheme.headline2.color,
                          fontFamily: "monte"),
                    ),
                    icon: Icon(
                      Icons.delete,
                      color: theme.textTheme.headline2.color,
                      size: 20,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
