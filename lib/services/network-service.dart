import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waybill_sender/bloc/index.dart';
import 'package:waybill_sender/services/index.dart';
import 'package:waybill_sender/utils/global-variables.dart';
import 'package:waybill_sender/utils/pref-manager.dart';


class NetworkService extends ApiService {
  BuildContext context;
  MainBloc bloc;
  NetworkService({@required this.context}) : super(context: context);

  Future<Map<String, dynamic>> login
      (String email, String password) async {
    PrefManager prefManager = PrefManager();
    bloc = Provider.of<MainBloc>(context, listen:false);
    Map<String, String> data = new Map();
    data = {
      "email": email,
      "password":password,
      "device_name": "a1b2c3d4e5f6"
    };
    Map<String, dynamic> _response =
    await post('login', data);
    if(_response["data"] != null){
      String bearer_token = await _response["data"]["access_token"];
      token = bearer_token;
      bloc.bearerToken = bearer_token;
      prefManager.setAuthToken(bearer_token);
      print("token" +token);
    }
    return _response;
  }
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    Map<String, dynamic> _response = await post('signup', data);

    return _response;
  }
    Future<Map<String, dynamic>> getActivity() async {
      Map<String, dynamic> _response = await get('https://app.waybill.link/api/rider/package');
    print(_response);
    return _response;
  }
}
