import 'package:flutter/material.dart';

class EditDataProvider extends ChangeNotifier {
  List _newsData = [];
  List _postData = [];
  List _scheduleData = [];

  get getNews => _newsData;
  set setNews(data) {
    this._newsData = data;
  }

  deleteNews(index) {
    _newsData.removeAt(index);
    notifyListeners();
  }
}
