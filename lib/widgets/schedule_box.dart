import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/screens/ScheduleFullContent.dart';

class ScheduleBox extends StatefulWidget {
  final schedule;
  ScheduleBox(this.schedule);

  @override
  State<ScheduleBox> createState() => _ScheduleBoxState();
}

class _ScheduleBoxState extends State<ScheduleBox> {
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
    var theme = Theme.of(context);
    var _width = MediaQuery.of(context).size.width;
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (_) => ScheduleFullContent(widget.schedule)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 5))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                widget.schedule["title"],
                style: TextStyle(
                  letterSpacing: 1.3,
                  color: theme.textTheme.headline1.color,
                  fontFamily: "monte",
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                widget.schedule["body"],
                style: TextStyle(
                  letterSpacing: 1.1,
                  color: theme.textTheme.headline2.color,
                  fontFamily: "monte",
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidFile,
                          size: 30,
                          color: theme.colorScheme.primary,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            widget.schedule["fileName"],
                            style: TextStyle(
                                color: theme.textTheme.headline2.color,
                                fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: 5,
              height: 10,
            ),
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
                                Text(
                                  lang.openFile,
                                  style: TextStyle(
                                    fontFamily: "monte",
                                  ),
                                ),
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
                                    lang.downloading,
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontFamily: "monte",
                                    ),
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
                                    Text(
                                      lang.downloadFile,
                                      style: TextStyle(
                                        fontFamily: "monte",
                                      ),
                                    )
                                  ],
                                )),
                    // IconButton(
                    //     onPressed: downloadFile,
                    //     icon: Icon(
                    //       FontAwesomeIcons.download,
                    //       color: theme.colorScheme.primary,
                    //     )),
                  )
                : SizedBox(),
            Container(
              margin: EdgeInsets.all(10),
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
                      Container(
                        width: _width / 2,
                        child: Text(
                          widget.schedule["poster"],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: theme.textTheme.headline3.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.schedule["date"],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: theme.textTheme.headline3.color,
                    ),
                    overflow: TextOverflow.ellipsis,
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
