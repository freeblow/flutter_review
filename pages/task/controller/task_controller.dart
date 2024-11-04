import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/pages/task/controller/task_daily_controller.dart';
import 'package:tapmine/pages/task/controller/task_media_controller.dart';
import 'package:tapmine/pages/task/controller/task_ref_controller.dart';

import '../../../common/const/game_config.dart';
import '../../../common/network/api.dart';
import '../../../common/user/user_manager.dart';
import '../../../common/user/user_model.dart';
import '../../../websocket/pipeline/tp_pipeline_task.dart';
import '../../mining/provider/user_info_provider.dart';
import '../../root/root_page.dart';

class TaskController extends ChangeNotifier{
  Future<void> refreshTaskStatus() async {
    var result = await API.taskStatus(params:{"type": "0"});
    if(result.code == '0'){
      Provider.of<TaskMediaController>(RootPage.navigatorKey.currentContext!,  listen: false).setSocialMedias(result.result["media"] ?? []);
      Provider.of<TaskDailyController>(RootPage.navigatorKey.currentContext!,  listen: false).setDailyList(result.result["daily"] ?? []);
      Provider.of<TaskRefController>(RootPage.navigatorKey.currentContext!,  listen: false).setRefList(result.result["referral"] ?? []);
    }
    notifyListeners();
  }

  static void taskBalanceAddRefreshUserInfo(int balance, {bool isRef = false}){
    UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;

    userInfo.tokenBalance += balance;
    userInfo.totalToken += balance;
    if(isRef){
      userInfo.inviteRefReward += balance;
    }

    UserManager.instance.setUserModel(userInfo);
    Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);
  }
}