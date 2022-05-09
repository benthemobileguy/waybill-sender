import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:waybill_sender/bloc/index.dart';
import 'package:waybill_sender/services/api-exception.dart';
import 'package:waybill_sender/utils/alert-manager.dart';
import 'package:waybill_sender/utils/constants.dart';
import 'package:waybill_sender/utils/global-variables.dart';

class ApiService {
  BuildContext context;
  ApiService({@required this.context}) {
    print('Api service is called ');
  }

  static Future<Map<String, String>> headers({MainBloc bloc}) async {

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    if (bloc != null && bloc.bearerToken != null) {
      headers.addAll({'Authorization': "Bearer $token"});
    }

    return headers;
  }

  Future<Map<String, dynamic>> get(String url) async {
    print('Api service is called to make get request');

    MainBloc bloc = Provider.of<MainBloc>(context, listen:false);
    Map<String, String> _headers = await headers(bloc: bloc);
    http.Response response =
    await http.get(Uri.parse(url), headers: _headers);
    final responseJson = json.decode(response.body);
    print(responseJson.toString());
    int statusCode = response.statusCode;
    print(response.toString());
    switch (statusCode) {
      case 200:

      case 201:
        Map<String, dynamic> data = json.decode(response.body);
        return data;
        break;

      default:
        dynamic data = json.decode(response.body);

        // String msg;
        // // lord knows why this was encoded twice
        // if (data is String) {
        //   data = json.decode(data);
        //   msg = "";
        //   if (data.values.toList().length > 0) {
        //     // show first error
        //     msg = data.values .toList().first[0];
        //   }
        // } else {
        //   if(data['message'] !=null){
        //     msg = data['message']['name'];
        //   }
        // }

        throw ApiException(
          context: context,
          message: "",
          errors: data,
          code: statusCode,
        );
        break;
    }
  }
  Future<List<dynamic>> getList(String url) async {
    print('Api service is called to make get request');

    MainBloc bloc = Provider.of<MainBloc>(context, listen:false);
    Map<String, String> _headers = await headers(bloc: bloc);
    http.Response response =
    await http.get(Uri.parse(Constants().API_BASE_URL + url), headers: _headers);
    final responseJson = json.decode(response.body);
    print(responseJson.toString());
    int statusCode = response.statusCode;
    print(response.toString());
    switch (statusCode) {
      case 200:
      case 201:
        List<dynamic> data = json.decode(response.body);
        return data;
        break;

      default:
        dynamic data = json.decode(response.body);

        String msg;
        // lord knows why this was encoded twice
        if (data is String) {
          data = json.decode(data);
          msg = "";
          if (data.values.toList().length > 0) {
            // show first error
            msg = data.values .toList().first[0];
          }
        } else {
          if(data['message'] !=null){
            msg = data['message']['name'];
          }
        }

        throw ApiException(
          context: context,
          message: msg,
          errors: data,
          code: statusCode,
        );
        break;
    }
  }
  Future<Map<String, dynamic>> post(String url, dynamic body,
      {redirectOn401: true}) async {
    print('Api service is called to make post request');
    MainBloc bloc = Provider.of<MainBloc>(context, listen:false);
    Map<String, String> _headers = await headers(bloc: bloc);

    http.Response response = await http.post(
      Uri.parse(Constants().API_BASE_URL + url),
      headers: _headers,
      body: json.encode(body),
    );
    final responseJson = json.decode(response.body);
    print(Constants().API_BASE_URL + url);
    print("res:" + responseJson.toString());
    int statusCode = response.statusCode;
    switch (statusCode) {
      case 200:

      case 201:
        Map<String, dynamic> data = json.decode(response.body);
        return data;
        break;

      case 422:
        if (responseJson["error"] != null) {
          AlertManager.showToast("Error " + responseJson["error"]["email"].toString());
        }
        break;
      case 400:
        dynamic data = json.decode(response.body);
        String msg;
        // lord knows why this was encoded twice
        if (data is String) {
          data = json.decode(data);
          msg = "";
          if (data.values.toList().length > 0) {
            // show first error
            msg = data.values.toList().first[0];
          }
        } else {
          msg = data['responseMessage'];
        }

        throw ApiException(
          context: context,
          message: msg,
          errors: data,
          code: statusCode,
        );
        break;
      default:
        dynamic data = json.decode(response.body);
        print("response " + data.toString());
        String msg;
        // lord knows why this was encoded twice
        if (data is String) {
          data = json.decode(data);
          msg = "";
        } else {
          msg = data['responseMessage'];
        }

        throw ApiException(
          context: context,
          message: msg,
          code: statusCode,
          preventRedirect: !redirectOn401,
        );
        break;
    }
  }

  Future<Map<String, dynamic>> put(String url, dynamic body,
      {redirectOn401: true}) async {
    print('Api service is called to make post request');
    MainBloc bloc = Provider.of<MainBloc>(context, listen:false);
    Map<String, String> _headers = await headers(bloc: bloc);

    http.Response response = await http.put(Uri.parse(Constants().API_BASE_URL + url),
      headers: _headers,
      body: json.encode(body),
    );
    final responseJson = json.decode(response.body);
    if (responseJson["error"] != null) {
      AlertManager.showToast("Error " + responseJson["error"].toString());
    }  else if(responseJson["responseCode"] != null && responseJson["responseCode"] != 99){
      AlertManager.showToast(responseJson["responseMessage"].toString());
    }
    print(responseJson.toString());
    int statusCode = response.statusCode;
    switch (statusCode) {
      case 200:

      case 201:
        Map<String, dynamic> data = json.decode(response.body);
        return data;
        break;

      case 422:
      case 400:
        dynamic data = json.decode(response.body);
        String msg;
        // lord knows why this was encoded twice
        if (data is String) {
          data = json.decode(data);
          msg = "";
          if (data.values.toList().length > 0) {
            // show first error
            msg = data.values.toList().first[0];
          }
        } else {
          msg = data['responseMessage'];
        }

        throw ApiException(
          context: context,
          message: msg,
          errors: data,
          code: statusCode,
        );
        break;
      default:
        dynamic data = json.decode(response.body);
        print("response " + data.toString());
        if (data["responseCode"] != null && data["responseCode"] != 0) {
          AlertManager.showToast("Error " + data["responseMessage"].toString());
        }  else if(data["responseCode"] != null && data["responseMessage"] != 99){
          AlertManager.showToast(data["responseMessage"].toString());
        }
        String msg;
        // lord knows why this was encoded twice
        if (data is String) {
          data = json.decode(data);
          msg = "";
          if (data.values.toList().length > 0) {
            // show first error
            msg = data.values.toList().first[0];
          }
        } else {
          msg = data['responseMessage'];
        }

        throw ApiException(
          context: context,
          message: msg,
          code: statusCode,
          preventRedirect: !redirectOn401,
        );
        break;
    }
  }
}
