import 'dart:io';

import 'package:device_info/device_info.dart';

var androidInfo;
var iosDeviceInfo;

class DeviceUtils{

 static Future<void> init()async{
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {

      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

    } else if (Platform.isIOS) {

      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;

    }
  }


  static String getDeviceModel() {
    if (Platform.isAndroid) {
      return androidInfo.model;
    }else if(Platform.isIOS){
      return iosDeviceInfo.model;
    }
    return "";
  }

  static String getDeviceID() {
    if (Platform.isAndroid) {
      return androidInfo.androidId;
    }else if(Platform.isIOS){
      return iosDeviceInfo.identifierForVendor;
    }
    return "";
  }

  static String getDeviceVersion() {
    if (Platform.isAndroid) {
      return androidInfo.version.release;
    }else if(Platform.isIOS){
      return iosDeviceInfo.systemVersion;
    }
    return "";
  }

  static String getPlatform() {
    if (Platform.isAndroid) {
      return "Android";
    }else if(Platform.isIOS){
      return "IOS";
    }
    return "";
  }

  static String getDeviceName() {
    if (Platform.isAndroid) {
      return androidInfo.product;
    }else if(Platform.isIOS){
      return iosDeviceInfo.name;
    }
    return "";
  }


}