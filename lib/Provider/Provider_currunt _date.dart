import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class curruntdate extends ChangeNotifier{
  String currentDate = '';
  CurrentDate() {
    updateCurrentDate();
  }

  Future<void> updateCurrentDate() async {
    var now = DateTime.now();
    var formatter = DateFormat('d MMMM, y');
    currentDate = formatter.format(now);
    notifyListeners();
  }
}