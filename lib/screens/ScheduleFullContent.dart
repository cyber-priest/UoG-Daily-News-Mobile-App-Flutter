import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uog_daily/engine/theme.dart';
import 'package:uog_daily/models/news_model.dart';

class ScheduleFullContent extends StatefulWidget {
  final schedule;
  ScheduleFullContent(this.schedule);

  @override
  State<ScheduleFullContent> createState() => _ScheduleFullContentState();
}

class _ScheduleFullContentState extends State<ScheduleFullContent> {
  bool downloading = false;
  var proValue = 0.0;
  downloadFile() async {
    var statuse = await Permission.storage.request();
    if (statuse.isGranted) {
      Directory dir = Directory('/storage/emulated/0/Download');
      if (dir != null) {
        String savename = widget.schedule["fileName"];
        String savePath = dir.path + "/$savename";
        //output:  /storage/emulated/0/Download/banner.png

        try {
          setState(() {
            downloading = true;
          });
          await Dio().download(widget.schedule["url"], savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                proValue = (received / total).toDouble();
                print(proValue);
              });

              //you can build progressbar feature too
            }
          });
          setState(() {
            downloading = false;
          });
        } on DioError catch (e) {
          setState(() {
            downloading = false;
          });
        }
      }
    } else {
      print("No permission to read and write.");
    }
  }

  @override
  Widget build(BuildContext context) {
    var fileDir =
        File('/storage/emulated/0/Download/${widget.schedule["fileName"]}');
    var width = MediaQuery.of(context).size.width;
    var theme = context.read<CustomeTheme>().theme;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        // elevation: 1,
        iconTheme: IconThemeData(color: theme.textTheme.headline2.color),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.schedule["poster"],
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.schedule["title"],
                  style: TextStyle(
                    color: theme.textTheme.headline1.color,
                    fontFamily: "monte",
                    letterSpacing: 1.2,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                widget.schedule["fileName"] != null
                ? Container(
                  // width: _width / 1.5,
                  padding: EdgeInsets.only(top: 15, bottom: 15, left: 20),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidFile,
                            size: 30,
                            color: Color(0xff3E4685),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                widget.schedule["fileName"],
                                style: TextStyle(
                                    color: theme.textTheme.headline2.color,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ):SizedBox(),
                 widget.schedule["fileName"] != null
                ? Center(
                  child: fileDir.existsSync()
                      ? ElevatedButton(
                          onPressed: () async {
                            await OpenFile.open(fileDir.path);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.launch,
                                size: 20,
                                color: theme.colorScheme.background,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Open File"),
                            ],
                          ))
                      : downloading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: proValue,
                                  backgroundColor: Colors.grey[300],
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Downloading....",
                                  style: TextStyle(
                                      color: theme.colorScheme.primary),
                                ),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: downloadFile,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.download,
                                    size: 20,
                                    color: theme.colorScheme.background,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Download File")
                                ],
                              )),
                ):SizedBox(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.schedule["date"],
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
              widget.schedule["body"],
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
