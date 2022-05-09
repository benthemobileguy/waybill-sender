import 'package:flutter/material.dart';
import 'package:waybill_sender/models/recent-activity.dart';

class MainBloc with ChangeNotifier{
  String _bearerToken = "";
  List<RecentActivity> _recentActivity = [];


  String get bearerToken {
    return _bearerToken;
  }

  set bearerToken(token) {
    _bearerToken = token;
  }
  List<RecentActivity> get recentActivity {
    return _recentActivity;
  }
  set recentActivity(List<RecentActivity> _data) {
    this._recentActivity = _data;
    notifyListeners();
  }
}
