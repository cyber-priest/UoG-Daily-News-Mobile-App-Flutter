import 'dart:io';
import 'dart:math';
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
import 'package:uog_daily/engine/placeHolder.dart';
import 'package:uog_daily/engine/theme.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  ImgHolder image = ImgHolder();
  var rand = Random();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  SharedPreferences pref = UsePreferences.pref;
  String addImage;
  List imgList;
  String type = "News";
  String target = "All";
  String campuse = "All";
  bool breaking = false;
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
  TextStyle listStyle = TextStyle(fontSize: 12, fontFamily: "monte");
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
        .collection(type)
        .add(data)
        .then((ref) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Text(lang.postSuccess))));
      Navigator.pop(context);
    }).catchError((error) {
      print(error.message.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Text(error.message.toString()))));
      setState(() {
        posting = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    addImage = pref.getBool("isEnglish") ?? true ? "Add image" : "ምስል ያክሉ";
    imgList = [
      image.img1,
      image.img2,
      image.img3,
      image.img4,
      image.img5,
      image.img6
    ];
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.read<CustomeTheme>().theme;
    var user = context.watch<User>();
    String tmpUrl = imgList[rand.nextInt(imgList.length)];
    LangModel lang = Provider.of<LangProvider>(context, listen: true).lang;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        iconTheme: IconThemeData(color: theme.colorScheme.secondary),
        title: Text(
          lang.createPost,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton(
                                underline: SizedBox(),
                                value: type,
                                style: TextStyle(
                                    fontFamily: "monte",
                                    color: theme.textTheme.headline2.color),
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.news,
                                      style: listStyle,
                                    ),
                                    value: "News",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.post,
                                      style: listStyle,
                                    ),
                                    value: "Post",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.schedule,
                                      style: listStyle,
                                    ),
                                    value: "Schedule",
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    type = value;
                                    if (type == "Schedule") {
                                      addImage = lang.addFile;
                                    } else {
                                      addImage = lang.addImage;
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton(
                                underline: SizedBox(),
                                value: target,
                                style: TextStyle(
                                    fontFamily: "monte",
                                    color: theme.textTheme.headline2.color),
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.all,
                                      style: listStyle,
                                    ),
                                    value: "All",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.student,
                                      style: listStyle,
                                    ),
                                    value: "Student",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.teacher,
                                      style: listStyle,
                                    ),
                                    value: "Teacher",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.staff,
                                      style: listStyle,
                                    ),
                                    value: "Staff",
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    target = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton(
                                underline: SizedBox(),
                                value: campuse,
                                style: TextStyle(
                                    fontFamily: "monte",
                                    color: theme.textTheme.headline2.color),
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.all,
                                      style: listStyle,
                                    ),
                                    value: "All",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.tewodros,
                                      style: listStyle,
                                    ),
                                    value: "Tewodrows",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.fasile,
                                      style: listStyle,
                                    ),
                                    value: "Fasile",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.maraki,
                                      style: listStyle,
                                    ),
                                    value: "Maraki",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.gc,
                                      style: listStyle,
                                    ),
                                    value: "Gc",
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      lang.teda,
                                      style: listStyle,
                                    ),
                                    value: "Tseda",
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    campuse = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
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
                                      activeColor: theme.primaryColor,
                                      value: breaking,
                                      onChanged: (check) {
                                        setState(() {
                                          breaking = check;
                                          print(breaking);
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
                                print("fileName: " + fileName);
                                print("filePath: " + filePath);
                                String url = await uploadFile(
                                    fileName, filePath, isFile);
                                if (url != null) {
                                  Map<String, dynamic> data = {
                                    "target": target,
                                    "campuse": campuse,
                                    "title": titleController.text,
                                    "body": bodyController.text,
                                    "fileName": fileName,
                                    "posterId": user.uid,
                                    "poster": user.displayName,
                                    "date": date,
                                    "createdAt":
                                        Timestamp.fromDate(DateTime.now()),
                                    "url": url
                                  };
                                  if (type == "News") {
                                    data = {...data, "breaking": breaking};
                                  }
                                  await addPost(data);
                                } else {
                                  setState(() {
                                    posting = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Container(
                                      margin: EdgeInsets.only(bottom: 30),
                                      child: Text(
                                          "Unable to upload the file please try again"),
                                    ),
                                  ));
                                }
                              } else {
                                Map<String, dynamic> data = {
                                  "target": target,
                                  "campuse": campuse,
                                  "title": titleController.text,
                                  "body": bodyController.text,
                                  "fileName": fileName,
                                  "posterId": user.uid,
                                  "poster": user.displayName,
                                  "date": date,
                                  "createdAt":
                                      Timestamp.fromDate(DateTime.now()),
                                  "url": tmpUrl,
                                };
                                if (type == "News") {
                                  data = {...data, "breaking": breaking};
                                }
                                await addPost(data);
                              }
                              setState(() {
                                posting = false;
                              });
                            }
                          },
                          label: Text(
                            lang.postData,
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
