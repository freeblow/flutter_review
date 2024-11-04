enum DailyLoginRewardItemStatus{
  lock,
  waitingClaim,
  finish
}


class DailyLoginRewardItemModel{
  DailyLoginRewardItemModel({
    this.icon = "", this.day = 0, this.reward = 0, this.status =  DailyLoginRewardItemStatus.lock
  });

  String icon = "";
  int day = 0;
  num reward = 0;

  int taskCategory = 0;
  String taskId = "";
  String ownerId = "";
  int taskType = 0;
  int _status = 0;

  num finishTime = 0;

  DailyLoginRewardItemStatus status = DailyLoginRewardItemStatus.lock;

  DailyLoginRewardItemModel.fromJson(dynamic json){
    icon = "assets/mining/mining_coin_icon.png";

    taskId = "${json["taskId"] ?? "0"}";
    ownerId = "${ json["ownerId"] ?? "0"}";
    reward =  num.parse("${json["reward"] ?? 0}");
    taskType = json["taskType"] ?? 0;
    taskCategory = json["taskCategory"] ?? 0;

    finishTime = json["finishTime"] ?? 0;

    _status = json["status"] ?? 0;
    status = DailyLoginRewardItemStatus.lock;
    if(_status == 4){
      status = DailyLoginRewardItemStatus.lock;
    }else if(_status == 2){
      status = DailyLoginRewardItemStatus.waitingClaim;
    } else if(_status == 3){
      status = DailyLoginRewardItemStatus.finish;
    }
  }

}