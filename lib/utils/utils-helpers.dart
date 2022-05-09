import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


class UtilsHelpers{

  static Future delayedRequest(Function() function) async{
    return Future.delayed(const Duration(milliseconds: 3000), function);
  }
  static Future closeKeyboard(BuildContext context) async{
    return  FocusScope.of(context).unfocus();
  }
  static Future setStatusBar(Color color) async{
    return  SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }
}