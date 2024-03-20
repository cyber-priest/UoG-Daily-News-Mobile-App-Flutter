import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uog_daily/screens/PostFullContent.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostBox extends StatelessWidget {
  final post;

  PostBox(this.post);
  @override
  Widget build(BuildContext context) {
    var themeData = Provider.of<CustomeTheme>(context);
    var theme = themeData.theme;
    final _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push((context),
            MaterialPageRoute(builder: (_) => PostFullContent(post)));
      },
      child: Stack(children: [
        Positioned(
          // bottom: 4,
          // height: 300,
          child: Container(
            width: _width,
            padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 20),
            margin: EdgeInsets.only(left: 5, right: 5, top: 30, bottom: 5),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    post["title"],
                    style: TextStyle(
                      color: theme.textTheme.headline1.color,
                      fontFamily: 'lora',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    post["body"],
                    style: TextStyle(
                      color: theme.textTheme.headline2.color,
                      fontFamily: 'lora',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.fade,
                    maxLines: post["url"] != "no" ? 3 : 10,
                  ),
                ),
                SizedBox(height: 15),
                post["url"] != "no"
                    ? Container(
                        width: _width,
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: CachedNetworkImage(
                              imageUrl: post["url"],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                  child: Container(
                                    color: Colors.white,
                                    height: 200,
                                  ),
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100]),
                              errorWidget: (context, url, error) =>
                                  Shimmer.fromColors(
                                      child: Container(
                                        color: Colors.white,
                                        height: 200,
                                      ),
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100]),
                            )),
                      )
                    : SizedBox(),
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.user,
                            size: 15,
                            color: theme.textTheme.headline3.color,
                          ),
                          SizedBox(width: 5),
                          Text(
                            post["poster"],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: theme.textTheme.headline3.color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        post["date"],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: theme.textTheme.headline3.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            width: _width,
            child: CircleAvatar(
                backgroundColor: theme.colorScheme.background,
                radius: 30,
                child: Icon(Icons.push_pin_outlined,
                    size: 30, color: theme.colorScheme.surface)),
          ),
        ),
      ]),
    );
  }
}
