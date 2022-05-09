import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:waybill_sender/modules/auth/login_screen.dart';
import 'package:waybill_sender/utils/alert-manager.dart';

class ApiException implements Exception {
  int code;
  String message;
  Map<String, dynamic> errors;
  bool preventRedirect;
  BuildContext context;

  ApiException(
      {this.code,
        this.message,
        this.preventRedirect = false,
        this.errors,
        @required this.context}) {
    switch (code) {
      case 401:
        logOut();
        break;
      case 403:
        logOut();
        break;
      case 99:
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_LONG,
      );
      break;
      case 400:
        Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 2,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      default:
        Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
        break;
    }
  }


  void logOut() {
    AlertManager.showToast("Your session has timed out. Please login in");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          LoginScreen()),
    );
  }
}

