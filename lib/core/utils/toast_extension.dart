import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ToastExtension on BuildContext {
  showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }
}
