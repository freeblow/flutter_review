

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/network/api.dart';
import '../model/task_media_item_model.dart';

class TaskMediaController extends ChangeNotifier{

  static bool isCheckTwitterFinish = true;

  static List<TaskMediaItemModel> medias = <TaskMediaItemModel>[
    TaskMediaItemModel(title: "Subscribe our TG channel", type:TMTaskMediaType.tg, rewardCount: "0",icon: "assets/task/boost_task_tg.png" ),
    TaskMediaItemModel(title: "Follow our X account", type:TMTaskMediaType.x, rewardCount: "0" ,icon: "assets/task/boost_task_x.png", isFollowing: true),
  ];

  Future<void> commitMediaTask(TaskMediaItemModel item, {void Function(bool,int)? finish , bool isFollowing = false}) async {
    if(!isCheckTwitterFinish) return;
    isCheckTwitterFinish = false;
    Map<String, dynamic>  params = {"taskCategory": item.taskCategory};
    if(item.type == TMTaskMediaType.x){
      if(isFollowing){
        params = {"taskCategory": item.taskCategory, "operation": 1};
      }else{
        params = {"taskCategory": item.taskCategory, "operation": 2};
      }
    }
    var result = await API.mediaTask(params:params);

    isCheckTwitterFinish = true;

    if(result.code == '0'){

      if(finish != null){
        finish(true, result.result?["reward"] ?? 0);
      }
      refreshMediaTaskList();
      return;
    }
    if(finish != null){
      finish(false, 0);
    }
  }


  Future<void> refreshMediaTaskList() async {
    var result = await API.taskStatus(params:{"type": "2"});

    if(result.code == '0'){

      setSocialMedias(result.result["media"] ?? []);

    }
  }

  List<TaskMediaItemModel> socialMedias = [];

  void setSocialMedias(List<dynamic> items){

    List<TaskMediaItemModel> ret = [];
    for(int i = 0; i < items.length ; i++){
      dynamic item = items[i];
      ret.add(TaskMediaItemModel.fromJson(item));
    }
    socialMedias = ret;
    notifyListeners();
  }

}