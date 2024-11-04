import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

class IsolateTimer {

  static final IsolateTimer _instance = IsolateTimer._internal();

  static final instance = _instance;

  factory IsolateTimer() {
    return _instance;
  }

  IsolateTimer._internal();

  Isolate? _isolate;
  ReceivePort? _receivePort;
  StreamController<void> _streamController = StreamController<void>.broadcast();

  Timer? _timer;

  void setTimer(Timer? t){
    _timer = t;
  }

  Timer? get timer{
    return _timer;
  }

  Future<void> start() async {
    if (_isolate != null) {
      // Timer already running
      return;
    }

    try{
      _receivePort = ReceivePort();
      _isolate = await Isolate.spawn(_isolateTimer, _receivePort!.sendPort);

      _receivePort!.listen((message) {
        _streamController.add(null);
      });
    }catch(e){
      if(kDebugMode){
        print("isolate init error: ${e.toString()}");
      }
    }

  }

  void stop() {
    _receivePort?.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _receivePort = null;
  }

  Stream<void> get onTick => _streamController.stream;

  static void _isolateTimer(SendPort sendPort) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      sendPort.send('tick');
    });
  }
}
