import 'package:flutter/material.dart';

class TraceLogProvider  extends ChangeNotifier{
  String _log = "";
  String get log => _log;
  void setLog(String l){
    _log = l;
    notifyListeners();
  }

  String _msgLog = "";
  String get msgLog=> _msgLog;
  void setMsgLog(String l){
    _msgLog = l;
    notifyListeners();
  }

  List<String> _msgListLog = [];
  List<String> get msgListLog=> _msgListLog;
  void addMsgLog(String l){
    _msgListLog.add(l);
    notifyListeners();
  }
}