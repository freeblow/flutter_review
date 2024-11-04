import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:tapmine/pages/root/root_page.dart';

class TPCommon{
  TPCommon._internal();
  static final TPCommon _instanceManager = TPCommon._internal();
  factory TPCommon() {
    return _instanceManager;
  }
  static TPCommon get instance {
    return _instanceManager;
  }



  String userAgent(){

    return 'Unknown';

  }

  static String formatOperateNumber(String? numberStr, {String sign = ","}){
    if(numberStr == null || numberStr.isEmpty) return "0";

    // final formattedNumber = NumberFormat('#,##0.00').format(numValue);

    try {
      final numValue = double.parse(numberStr);
      final formatter = NumberFormat('#,##0', 'en_US');

      return formatter.format(numValue);
    } catch (e) {
      return numberStr;
    }

    return "";
  }


   static String formatNumberWithSpaces(String numberStr,  {String sign = ","}) {
    final buffer = StringBuffer();

    for (int i = 0; i < numberStr.length; i++) {
      if (i > 0 && (numberStr.length - i) % 3 == 0) {
        buffer.write(sign);
      }
      buffer.write(numberStr[i]);
    }

    return buffer.toString();
  }


  static DateTime utcZero(){
    final currentTime = DateTime.now().toUtc();
    return DateTime.utc(
      currentTime.year,
      currentTime.month,
      currentTime.day + 1,
    );
  }

  static BuildContext currentContext(){
    return RootPage.navigatorKey.currentContext!;
  }


  static bool isTimestampToday(int timestamp) {
    // 将时间戳转换为 DateTime 对象
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);

    if(kDebugMode){
      print("Input Time day = ${dateTime.day} month = ${dateTime.month} year = ${dateTime.year}");
    }

    // 获取当前时间
    DateTime now = DateTime.now().toUtc();

    if(kDebugMode){
      print("Today Time day = ${now.day} month = ${now.month} year = ${now.year}");
    }

    // 比较年、月、日是否相同
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

}