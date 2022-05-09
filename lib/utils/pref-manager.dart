import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waybill_sender/models/user.dart';

class PrefManager {
  String auth_token = "auth_token";
  String customerID = "null";
  String isFirstTimeLaunch = "null";

  Future<void> setAuthToken(String auth_token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, auth_token);
  }

  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String auth_token;
    auth_token = pref.getString(this.auth_token) ?? null;
    return auth_token;
  }
  Future<void> setFirstTimeLaunch(String isLaunch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.isFirstTimeLaunch, isLaunch);
  }

  Future<String> getFirstTimeLaunch() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String isLaunch;
    isLaunch = pref.getString(this.isFirstTimeLaunch) ?? null;
    return isLaunch;
  }

  //clear
  Future<void>clearSharedPreferences() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }

  Future<void> setCustomerID(String ID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.customerID, ID);
  }

  Future<String> getCustomerID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String auth_token;
    auth_token = pref.getString(this.customerID) ?? null;
    return auth_token;
  }

  // ///user object
  Future<void> setUserData(Map<String, dynamic> jsonData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(User.fromJson(jsonData));
    prefs.setString('userData', user);
  }

  Future<User> getUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var user;
    if(pref.getString('userData') !=null){
      Map json = jsonDecode(pref.getString('userData'));
      user = User.fromJson(json);
    }
    return user;
  }
}