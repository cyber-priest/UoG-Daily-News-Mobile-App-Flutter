import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uog_daily/engine/auth_provider.dart';
import 'package:uog_daily/engine/dataProvider.dart';
import 'package:uog_daily/engine/langProvider.dart';
import 'package:uog_daily/engine/theme.dart';

class Update extends StatefulWidget {
  final data;
  final id;
  Update(this.data, this.id);
  @override
  State<Update> createState() => _UpdateState(data, id);
}

class _UpdateState extends State<Update> {
  final data;
  final id;
  _UpdateState(this.data, this.id);
  SharedPreferences pref = UsePreferences.pref;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  String addImage;
  String type = "News";
  String fileName;
  String filePath;
  String titleError;
  String bodyError;
  bool posting = false;
  List monthName = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  @override
  void initState() {
    super.initState();
    type = data["type"];
    fileName = data["fileName"];
    titleController.text = data["title"];
    bodyController.text = data["body"];
    addImage = pref.getBool("isEnglish") ?? true
        ? "Change or add image"
        : "ምስል ይቀይሩ ወይም ያክሉ";
  }

  getDate() async {
    var month = DateTime.now().month;
    var day = DateTime.now().day;
    var year = DateTime.now().year;
    String date = "${monthName[month - 1]} $day, $year";
    return date;
  }

  Future<String> uploadFile(
      String fileName, String filePath, bool isFile) async {
    var path = File(filePath);
    String des = isFile ? "Files/$fileName" : "Images/$fileName";
    var firebaseStorageRef = FirebaseStorage.instance.ref(des);
    var uploadTask = await firebaseStorageRef.putFile(path);
    String url = await uploadTask.ref.getDownloadURL().then((value) => value);
    return url;
  }

  addPost(Map<String, dynamic> data) async {
    LangModel lang = Provider.of<LangProvider>(context, listen: false).lang;
    await FirebaseFirestore.instance
        .collection(data['type'])
        .doc(id)
        .update(data)
        .then((ref) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Text(lang.editSuccess))));
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.read<CustomeTheme>().theme;
    var user = context.watch<User>();
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        iconTheme: IconThemeData(color: theme.colorScheme.secondary),
        title: Text(
          lang.edit,
          style: TextStyle(
              color: theme.colorScheme.secondary,
              fontFamily: "monte",
              fontSize: 15),
        ),
      ),
      body: posting
          ? SpinKitDoubleBounce(color: theme.colorScheme.primary)
          : ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: titleController,
                            onChanged: (title) {
                              int len = title.length;
                              setState(() {
                                titleError = len == 0 ? lang.titleError : null;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: lang.title,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: theme.primaryColor)),
                              errorText: titleError,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: bodyController,
                            onChanged: (body) {
                              int len = body.length;
                              setState(() {
                                bodyError = len == 0 ? lang.bodyError : null;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: lang.body,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: theme.primaryColor)),
                              errorText: bodyError,
                            ),
                            maxLines: 10,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        type == "News"
                            ? Container(
                                child: Row(
                                children: [
                                  Checkbox(
                                      value: data["breaking"],
                                      onChanged: (check) {
                                        setState(() {
                                          data["breaking"] = check;
                                        });
                                      }),
                                  Text(lang.breakingNews,
                                      style: TextStyle(
                                          fontFamily: "monte",
                                          color:
                                              theme.textTheme.headline2.color))
                                ],
                              ))
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var result = await FilePicker.platform.pickFiles();
                            String name = result.files.first.name;
                            if (type != "Schedule") {
                              if (name.endsWith(".png") ||
                                  name.endsWith(".jpg") ||
                                  name.endsWith(".Jpeg") ||
                                  name.endsWith(".gif")) {
                                setState(() {
                                  addImage = result.files.first.name;
                                  fileName = result.files.first.name;
                                  filePath = result.files.first.path;
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      child: Text(lang.invalidImage)),
                                ));
                              }
                            } else {
                              if (name.endsWith(".docx") ||
                                  name.endsWith(".doc") ||
                                  name.endsWith(".txt") ||
                                  name.endsWith(".xlsx") ||
                                  name.endsWith(".pdf") ||
                                  name.endsWith(".png") ||
                                  name.endsWith(".jpg") ||
                                  name.endsWith(".jpeg")) {
                                setState(() {
                                  addImage = result.files.first.name;
                                  fileName = result.files.first.name;
                                  filePath = result.files.first.path;
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      child: Text(lang.invalidFile)),
                                ));
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.background,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 5))
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  type != "Schedule"
                                      ? Icons.image
                                      : FontAwesomeIcons.file,
                                  size: 35,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(addImage,
                                      style: TextStyle(fontFamily: "monte"),
                                      textAlign: TextAlign.justify),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton.icon(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10)),
                            backgroundColor: MaterialStateProperty.all(
                                theme.colorScheme.background),
                            elevation: MaterialStateProperty.all(4),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                          ),
                          onPressed: () async {
                            int titleLen = titleController.text.length;
                            int bodyLen = bodyController.text.length;

                            if (titleLen == 0 || bodyLen == 0) {
                              setState(() {
                                bodyError =
                                    bodyLen == 0 ? lang.bodyError : null;
                                titleError =
                                    titleLen == 0 ? lang.titleError : null;
                              });
                            } else {
                              setState(() {
                                posting = true;
                              });
                              String date = await getDate();
                              bool isFile = type != "Schedule" ? false : true;

                              if (filePath != null) {
                                data["url"] = await uploadFile(
                                    fileName, filePath, isFile);
                                if (data["url"] != null) {
                                  Map<String, dynamic> newData = {
                                    ...data,
                                    "title": titleController.text,
                                    "body": bodyController.text,
                                    "fileName": fileName,
                                    "date": date,
                                    "createdAt":
                                        Timestamp.fromDate(DateTime.now()),
                                  };
                                  await addPost(newData);
                                } else {
                                  setState(() {
                                    posting = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Container(
                                        margin: EdgeInsets.only(bottom: 30),
                                        child: Text(lang.uploadEror)),
                                  ));
                                }
                              } else {
                                Map<String, dynamic> newData = {
                                  ...data,
                                  "title": titleController.text,
                                  "body": bodyController.text,
                                  "fileName": fileName,
                                  "poster": user.displayName,
                                  "date": date,
                                  "createdAt":
                                      Timestamp.fromDate(DateTime.now()),
                                };
                                await addPost(newData);
                              }
                              setState(() {
                                posting = false;
                              });
                            }
                          },
                          label: Text(
                            lang.update,
                            style: TextStyle(fontFamily: "monte"),
                          ),
                          icon: Icon(Icons.send),
                        )
                      ],
                    )),
              ],
            ),
    );
  }
}
