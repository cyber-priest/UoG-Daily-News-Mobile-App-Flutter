import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/models/news_model.dart';

class PostFullContent extends StatelessWidget {
  final post;
  PostFullContent(this.post);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var theme = context.read<CustomeTheme>().theme;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        iconTheme: IconThemeData(color: theme.textTheme.headline1.color),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              post["poster"],
              style: TextStyle(
                color: theme.textTheme.headline1.color,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                fontFamily: 'saira',
                letterSpacing: 1.2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: theme.primaryColor,
              child: Icon(
                Icons.person,
                color: theme.colorScheme.secondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: width,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: post["url"],
                    // color: Colors.black.withOpacity(0.5),
                    // colorBlendMode: BlendMode.darken,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                        child: Container(
                          color: Colors.white,
                        ),
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100]),
                    errorWidget: (context, url, error) => Shimmer.fromColors(
                        child: Container(
                          color: Colors.white,
                        ),
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        post["title"],
                        style: TextStyle(
                          color: theme.textTheme.headline1.color,
                          fontFamily: "monte",
                          letterSpacing: 1.2,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            post["date"],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: theme.textTheme.headline2.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(0),
            ),
            child: Text(
              post["body"],
              style: TextStyle(
                  color: theme.textTheme.headline1.color,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'monte'),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
