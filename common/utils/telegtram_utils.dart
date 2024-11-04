import 'package:flutter/foundation.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

class TelegtramUtils{
  static bool isCloseConfirm = false;

  static void disableCloseConfirm(){
    if(!isCloseConfirm) return;
    if(kDebugMode){
      print("disable close confirm。。。。");
    }
    tg.disableClosingConfirmation();
    isCloseConfirm = false;
  }

  static void enableCloseConfirm(){
    if(isCloseConfirm)return;
    if(kDebugMode){
      print("enable close confirm。。。。");
    }
    tg.enableClosingConfirmation();
    isCloseConfirm = true;
  }
}