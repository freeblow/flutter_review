import 'dart:core';

enum TMTaskMediaType{
  tg,
  x,
  none
}

class TaskMediaItemModel{
  TaskMediaItemModel({
    this.icon, this.title, this.rewardCount, this.type = TMTaskMediaType.none, this.isFollowing = false
  });
  String? icon;
  String? title;
  String? rewardCount;
  TMTaskMediaType? type;
  bool isFollowing = false;

  int taskCategory = 0;

  String taskId = "";

  String ownerId = "";

  int taskType = 0;

  int status = 0;

  num finishTime = 0;

  String description = "";

  TaskMediaItemModel.fromJson(dynamic json){
    if(json == null) return;
    taskCategory = json["taskCategory"] ?? 0;
    if(taskCategory == 1){
      type = TMTaskMediaType.tg;
      icon = "assets/task/boost_task_tg.png";
    }
    if(taskCategory == 2){
      type = TMTaskMediaType.x;
      icon = "assets/task/boost_task_x.png";
    }


    taskId = "${json["taskId"] ?? "0"}";
    ownerId = "${ json["ownerId"] ?? "0"}";
    rewardCount = "${json["reward"] ?? 0}";
    taskType = json["taskType"] ?? 0;

    status = json["status"] ?? 0;

    isFollowing = status == 3;

    finishTime = json["finishTime"] ?? 0;

    description = json["description"] ?? "";
    title = description;
  }

}