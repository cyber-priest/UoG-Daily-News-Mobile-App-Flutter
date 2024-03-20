import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/models/news_model.dart';

class NewsFullContent extends StatelessWidget {
  final news;
  NewsFullContent(this.news);
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    var theme = context.read<CustomeTheme>().theme;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.primaryColor,
            expandedHeight: 250,
            iconTheme: IconThemeData(color: theme.colorScheme.secondary),
            pinned: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news["poster"],
                  style: TextStyle(
                    color: theme.colorScheme.secondary,
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
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.only(
                    top: statusBarHeight, bottom: 0, left: 0, right: 0),
                color: Colors.black,
                child: Stack(
                  children: [
                    news["url"] == "no"
                        ? SizedBox()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: CachedNetworkImage(
                              imageUrl: news["url"],
                              color: Colors.black.withOpacity(0.5),
                              colorBlendMode: BlendMode.darken,
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
                            ),
                          ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            news["title"],
                            style: TextStyle(
                              color: Colors.white,
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
                                news["date"],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white60,
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
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(20),
                color: theme.colorScheme.background,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: 150,
                      child: Text(
                        news["body"],
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
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
