import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tapmine/common/utils/telegtram_utils.dart';
import 'package:tapmine/websocket/pipeline/tp_pipeline_task.dart';

class MiningProcessUtil{

  static final instance = MiningProcessUtil();
  static final MiningProcessUtil _processUtil = MiningProcessUtil._internal();
  factory MiningProcessUtil() {
    return _processUtil;
  }
  MiningProcessUtil._internal();


  bool _isMining = false;

  final int _clickTimeout = 500;

  Timer? _timer;

  // void startMonitoring(){
  //   if(_timer != null) return;
  //
  //   _timer = Timer.periodic(const Duration(milliseconds: 200), (timer){
  //     if(_isMining){
  //       _isMining = false;
  //     }
  //   });
  // }

  void startMing(){
    _isMining = true;
    TelegtramUtils.enableCloseConfirm();
    _timer?.cancel();

    // 开启一个新的计时器
    _timer = Timer(Duration(milliseconds: _clickTimeout), () {
      // 计时器触发，说明点击行为已经停止
      stopMining();
    });

  }

  void stopMining(){
    if(kDebugMode){
      print("stopMining ---------- !!!!");
    }
    _isMining = false;
    _timer?.cancel();
    TPPipelineTask.instance.startTap();
  }


}