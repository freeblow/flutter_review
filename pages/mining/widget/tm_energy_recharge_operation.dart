import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/common/user/user_manager.dart';
import 'package:tapmine/common/utils/singleton_timer.dart';

import '../../../common/user/user_model.dart';
import '../../../common/utils/js_timer.dart';
import '../../../websocket/pipeline/tp_pipeline_task.dart';
import '../../root/root_page.dart';
import '../provider/user_info_provider.dart';

class TMEnergyRechargeOperation{
  static final TMEnergyRechargeOperation _instance = TMEnergyRechargeOperation._internal();
  factory TMEnergyRechargeOperation() => _instance;

  TMEnergyRechargeOperation._internal(){
    SingletonTimer.instance.start();
  }
  static TMEnergyRechargeOperation get instance {
    return _instance;
  }

  Timer? _timer;
  Function()? _callback;

  StreamSubscription? _subscription;

  void startTimer( Function() callback) {
    _callback = callback;
    _subscription ??= SingletonTimer.instance.onTick.listen((_){
        if(_callback != null){
          _callback!();
        }
    });

  }

  void stopTimer() {
    _timer?.cancel();
  }

  int _currentDateTime = 0;

  void startRechargeEnergy(){
    startTimer((){

      if(RootPage.navigatorKey.currentContext == null) {
        _currentDateTime = (DateTime.timestamp().millisecondsSinceEpoch/1000).toInt();
        return;
      }
      if(!(UserManager.instance.isLogin))  {
        _currentDateTime = (DateTime.timestamp().millisecondsSinceEpoch/1000).toInt();
        return;
      }

      int currentTimeStamp  = DateTime.timestamp().millisecondsSinceEpoch~/1000;

      if(_currentDateTime == 0){
        _currentDateTime = currentTimeStamp;
      }

      int oldValue = _currentDateTime;
      int currentTime = currentTimeStamp;

      int intervalValue = currentTime - oldValue;

      UserModel mModel = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;
      if(mModel.energy <  mModel.energyThreshold){
        mModel.energy += mModel.rechargeSpeed * intervalValue;
        if(mModel.energy > mModel.energyThreshold){
          int coinValue = mModel.energy - mModel.energyThreshold;
          mModel.energy = mModel.energyThreshold;
          if(UserManager.instance.user.offlineRewardActivated){
            mModel.tokenBalance += coinValue;
            mModel.clickBalance += coinValue;
            mModel.totalToken += coinValue;
          }
        }

        Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!,  listen: false).setModel(mModel);
      }else{
        if(!(UserManager.instance.user.offlineRewardActivated))return;
        mModel.tokenBalance += mModel.rechargeSpeed * intervalValue;
        mModel.clickBalance += mModel.rechargeSpeed * intervalValue;
        mModel.totalToken += mModel.rechargeSpeed * intervalValue;

        Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!,  listen: false).setModel(mModel);
      }


      _currentDateTime = currentTimeStamp;
    });

  }
}