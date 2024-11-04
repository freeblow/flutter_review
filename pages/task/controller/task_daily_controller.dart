

import 'package:flutter/material.dart';

import '../../../common/network/api.dart';
import '../model/daily_login_reward_item_model.dart';
import '../model/task_daily_item_model.dart';

class TaskDailyController extends ChangeNotifier{

  static List<TaskDailyItemModel> dailies = <TaskDailyItemModel>[
    TaskDailyItemModel(title: "Login Reward", type:TMTaskDailyType.loginReward, rewardCount: "100000",icon: "assets/root/login_reward.png", isFinish: false ),
  ];


  static bool isStartOfflineRewardFinish = true;

  Future<void> commitDailyRewardTask(DailyLoginRewardItemModel item, {void Function(bool,int)? finish}) async {
    if(!isStartOfflineRewardFinish) return;
    isStartOfflineRewardFinish = false;
    var result = await API.dailyTask(params:{"taskCategory": item.taskCategory});

    if(result.code == '0'){
      refreshDailyTaskList();
      if(finish != null){
        finish(true, result.result?["reward"] ?? 0);
      }
      isStartOfflineRewardFinish = true;
      return;
    }
    if(finish != null){
      // finish(false, 0);
      finish(true, 0);
    }
    isStartOfflineRewardFinish = true;

  }

  Future<void> refreshDailyTaskList() async {
    var result = await API.taskStatus(params:{"type": "1"});
    if(result.code == '0'){
      setDailyList(result.result["daily"] ?? []);
    }
    notifyListeners();
  }

  List<TaskDailyItemModel> dailyList= [];

  void setDailyList(List<dynamic> items){
    
    dailyList = [TaskDailyItemModel.fromJson(items)];
    notifyListeners();
  }
}