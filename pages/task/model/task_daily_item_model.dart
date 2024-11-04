import 'package:flutter/foundation.dart';
import 'package:tapmine/common/utils/tp_common.dart';

import 'daily_login_reward_item_model.dart';

enum TMTaskDailyType{
  loginReward,
  none
}

class TaskDailyItemModel{
  TaskDailyItemModel({
    this.icon, this.title, this.rewardCount, this.type = TMTaskDailyType.none, this.isFinish = false
  });
  String? icon;
  String? title;
  String? rewardCount;
  TMTaskDailyType? type;
  bool isFinish = false;

  List<DailyLoginRewardItemModel> items = [];

  TaskDailyItemModel.fromJson(dynamic json){
    if(json == null) return;
    icon = "assets/root/login_reward.png";
    type = TMTaskDailyType.loginReward;
    title = "Login Reward";
    bool mIsFinish = false;
    List<DailyLoginRewardItemModel> weeklyTask = [];
    num mReward = 0;

    for(int i=0; i< json.length; i++){
      var item = json[i];
      DailyLoginRewardItemModel mItem = DailyLoginRewardItemModel.fromJson(item);

      if(TPCommon.isTimestampToday(mItem.finishTime.toInt() * 1000)){
        if(kDebugMode){
          print("TaskDailyItemModel.fromJson status = ${ mItem.status} finishTime = ${mItem.finishTime} ");
        }
      }

      if(mItem.finishTime > 0 && TPCommon.isTimestampToday(mItem.finishTime.toInt() * 1000) && mItem.status == DailyLoginRewardItemStatus.finish){
        if(kDebugMode){
          print("TaskDailyItemModel.fromJson is Finish!!");
        }
        mIsFinish = true;
      }
      mItem.day = i+1;
      mReward += mItem.reward;
      weeklyTask.add(mItem);
    }
    isFinish = mIsFinish;
    rewardCount = mReward.toString();
    items = weeklyTask;
  }


}