import 'dart:convert';
import 'dart:developer';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiRepository {

  static const String AUTH_BASE_URL = 'https://oauth.vnnogile.in/api/v1';
  String email = "";
  int otp=0;
  String tenantId = '1';
  static const String app_name = "OBO";
  late String device_uuid;
  static const String OTP_URL = "$AUTH_BASE_URL/otp";
  static const String LOGIN_URL = "$AUTH_BASE_URL/login";
  static const String REGISTER_URL ='$AUTH_BASE_URL/v2explore/user_registration/user';


  Future<void> sendOtp(String emailid) async {

    email = emailid;
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    device_uuid = androidInfo.androidId;

    Map<String,dynamic> body = {
      "app_name":app_name,
      "username":email,
      "tenantId": tenantId,
      "usage": "login",
      "device_uuid":device_uuid,
    };

    String res = await post(body,OTP_URL);
    //print(res);
    Map jsonData = json.decode(res) as Map;

    //print("<TERA OTP BROOOOOOOOO> : "+jsonData['otp'].toString());
    ///Set Otp Here
    otp = jsonData['otp'];
  }



  Future<String> post(Map<String, dynamic> body,String url) async{
    Map<String,String>headers = {
      'content-type': 'application/json',
      'accept-language' : 'en'
    };

    try{
      final response = await http.post(Uri.parse(url),headers:headers,body:jsonEncode(body)).timeout(Duration(seconds: 300));
      if(kDebugMode){
        log('Url-->$url');
        log('request-->$body');
        log('status-->${response.statusCode}');
        log('request headers-->${headers}');
        log('headers-->${response.headers}');
        log('Response-->${response.body}');
      }
      if(response.statusCode==200 || response.statusCode ==201) {
        return response.body;
      }
      return response.body;

    }catch(e){
      return e.toString();
    }
  }

  Future<bool> login() async {
    Map<String,dynamic> body = {
      "tenant_id":tenantId,
      "app_name": "OBO",
      "username":email,
      "otp": "$otp",
      "device_uuid":device_uuid,
    };
    print(await post(body,LOGIN_URL));
    return false;
  }

  Future<bool> getRegisterOtp(String username,String email, String mobileNumber)async{
    Map<String,dynamic> body = {
      "app_name":"OBO",
      "username":"$username",
      "email":"$email",
      "mobile":"$mobileNumber",
      "tenantId": tenantId,
      "usage": "registration",
      "device_uuid":device_uuid
    };

    print(await post(body,OTP_URL));
    return false;
  }

  Future<void> register(String username,String emailPhone,String oboName,String otp, String mobileNumber, String countryCode, String zipcode)async {
    try {
      Map<String, dynamic> body = {
        "partyTypeId": 1,
        "email": "$emailPhone",
        "mobile": "$mobileNumber",
        "tenantId": tenantId,
        "accepted_terms_condition": true,
        "party_code": "$oboName",
        "partycode": "$oboName",
        "device_uuid": device_uuid,
        "person": {
          "first_name": "${username}",
          "last_name": "",
          "gender": "M",
          "tenantId": tenantId,
          "zip_code": "$zipcode",
        },
        "user_login": {
          "tenantId": tenantId,
          "app_name": "OBO",
          "email": "$emailPhone",
          "mobile": "$mobileNumber",
          "otp": "$otp",
          "username": "$oboName",
          "country_code": countryCode,
        }
      };

      final response = await post(body, REGISTER_URL);
      print(response);
    } catch (e) {
        print(e.toString());
      return null;
    }
  }
}