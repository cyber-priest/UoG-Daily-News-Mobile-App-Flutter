import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uog_daily/engine/route.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/models/news_model.dart';
import 'package:uog_daily/screens/NewsFullContent.dart';
import 'package:cached_network_image/cached_network_image.dart';

//?? News that are posted with image

class NewsWithImage extends StatelessWidget {
  final news;
  NewsWithImage({this.news});
  final imageList = [
    "image1.jpg",
    "image2.jpg",
    "image3.jpg",
    "image4.jpg",
    "image5.jpg",
    "image6.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    // final _width = MediaQuery.of(context).size.width / 1.2;
    var random = Random();
    String randImage = imageList[random.nextInt(imageList.length)];
    var themeData = Provider.of<CustomeTheme>(context);
    var theme = themeData.theme;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            // height: 140,
            child: Column(
              children: [
                // SizedBox(height: 20),
                Container(
                  child: Text(
                    news["title"],
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
                            FontAwesomeIcons.user,
                            size: 13,
                            color: theme.textTheme.headline2.color,
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Text(
                              news["poster"],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: theme.textTheme.headline2.color,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Text(
                        news["date"],
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
          Container(
            height: 130,
            width: 120,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: news["url"] != "no"
                    ? CachedNetworkImage(
                        imageUrl: news["url"],
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
                      )
                    : Image(image: AssetImage("assets/images/$randImage"))),
          ),
        ],
      ),
    );
  }
}

//!! News Posts without image

class NewsWithoutImage extends StatelessWidget {
  final NewsModel news;
  const NewsWithoutImage({this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Text(
        news.post,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'monte',
          fontWeight: FontWeight.w300,
        ),
        overflow: TextOverflow.fade,
        maxLines: 8,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

//!! The News Container Box

class NewsBox extends StatelessWidget {
  final news;
  NewsBox(this.news);
  @override
  Widget build(BuildContext context) {
    var themeData = Provider.of<CustomeTheme>(context);
    var theme = themeData.theme;
    final _width = MediaQuery.of(context).size.width / 1.2;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
      child: Stack(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> animation2,
                        Widget child) {
                      animation = CurvedAnimation(
                          parent: animation, curve: Curves.elasticInOut);
                      return ScaleTransition(
                        // alignment: Alignment.center,
                        scale: animation,
                        child: child,
                      );
                    },
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> animation2) {
                      return NewsFullContent(news);
                    }));
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.only(left: 17, bottom: 15, top: 15, right: 15)),
            backgroundColor:
                MaterialStateProperty.all(theme.colorScheme.background),
            elevation: MaterialStateProperty.all(0),
            overlayColor:
                MaterialStateProperty.all(theme.primaryColor.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsWithImage(news: news),
            ],
          ),
        ),
      ]),
    );
  }
}

//* Anouncments

class Anounce extends StatelessWidget {
  final news;
  Anounce(this.news);
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width / 1.2;
    var themeData = Provider.of<CustomeTheme>(context);
    var theme = themeData.theme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> animation2,
                    Widget child) {
                  animation = CurvedAnimation(
                      parent: animation, curve: Curves.elasticInOut);
                  return ScaleTransition(
                    // alignment: Alignment.center,
                    scale: animation,
                    child: child,
                  );
                },
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> animation2) {
                  return NewsFullContent(news);
                }));
      },
      child: Container(
        width: _width,
        margin: EdgeInsets.only(top: 5, bottom: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0)
          ],
        ),
        child: Column(
          children: [
            Expanded(
              // height: 140,
              child: Container(
                width: _width,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      imageUrl: news["url"],
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
                    )),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  news["title"],
                  style: TextStyle(
                    color: theme.textTheme.headline1.color,
                    fontFamily: 'monte',
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
      ),
    );
  }
}

//! Home Lastest News

class LatestNews extends StatelessWidget {
  final NewsModel news;
  LatestNews(this.news);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 110,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/new_image.jpg"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      news.postTitle,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontFamily: 'monte',
                        // fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.eye,
                              size: 15,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "4k",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          news.date,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.8),
                          ),
                        ),
                        Container(
                            child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/new_image2.jpg"),
                        ))
                      ],
                    ),
                  )
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}

class Latest extends StatelessWidget {
  final NewsModel news;

  Latest(this.news);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width / 1.07;
    return Center(
      child: Container(
        width: _width,
        margin: EdgeInsets.symmetric(
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Container(
              width: _width,
              height: _width / 1.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  image: news.postImage,
                  fit: BoxFit.fitWidth,
                  colorBlendMode: BlendMode.darken,
                  color: Colors.black26,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: _width,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 25, right: 25),
                      child: Text(
                        news.postTitle,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontFamily: 'monte',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.7,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 30,
                      margin: EdgeInsets.only(top: 5, bottom: 0),
                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 5,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(3, 0),
                                          blurRadius: 5,
                                          color: Colors.black38)
                                    ]),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.eye,
                                      size: 15,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "4k",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  news.date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8),
                                  ),
                                ),
                                // Container(
                                //     child: CircleAvatar(
                                //   radius: 15,
                                //   backgroundImage:
                                //       AssetImage("assets/images/new_image2.jpg"),
                                // ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//? Post pages Box

