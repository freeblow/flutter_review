

import 'package:flutter/material.dart';
import 'package:tapmine/pages/task/model/task_ref_item_model.dart';

import '../../../common/network/api.dart';
import '../model/task_media_item_model.dart';

class TaskRefController extends ChangeNotifier{

  static List<TaskRefItemModel> refs = <TaskRefItemModel>[
    TaskRefItemModel( rewardCount: 10000,icon: "assets/task/task_ref_invitefriends.png", needInviteCount : 1 ,haveInviteCount:1, isClaimed: false),
    TaskRefItemModel( rewardCount: 100000 ,icon: "assets/task/task_ref_invitefriends.png", needInviteCount: 3,haveInviteCount: 1, isClaimed: false),
  ];

  Future<void> commitRefRewardTask(TaskRefItemModel item, {void Function(bool,int)? finish}) async {
    var result = await API.refTask(params:{"taskCategory": item.taskCategory});
    if(result.code == '0'){
      refreshRRefTaskList();
      if(finish != null){
        finish(true, result.result?["reward"] ?? 0);
      }
      return;
    }
    if(finish != null){
      finish(false,0);
    }

  }


  Future<void> refreshRRefTaskList() async {
    var result = await API.taskStatus(params:{"type": "3"});
    if(result.code == '0'){
      setRefList(result.result["referral"] ?? []);
    }
  }


  List<TaskRefItemModel> refList = [];

  void setRefList(List<dynamic> items){
    refList.clear();
    List<TaskRefItemModel> ret = [];

    List<TaskRefItemModel> claimedList = [];

    for(int i = 0; i < items.length ; i++){
      dynamic item = items[i];
      TaskRefItemModel itemModel = TaskRefItemModel.fromJson(item);
      if(itemModel.isClaimed){
        claimedList.add(itemModel);
      }else{
        ret.add(itemModel);
      }
    }

    ret.addAll(claimedList);

    refList = ret;
    notifyListeners();
  }

}