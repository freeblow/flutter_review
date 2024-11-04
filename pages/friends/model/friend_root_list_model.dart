import 'package:flutter/foundation.dart';

import 'friend_info_item_model.dart';

class FriendRootListModel{
  int referrals = 0;
  List<FriendInfoItemModel> items = [];

  FriendRootListModel.fromJson(dynamic json){
    if(json == null) return;
    if (kDebugMode) {
      print("FriendRootListModel.fromJson ---- ");
    }
    referrals = json["referrals"] ?? 0;
    List<dynamic> list = json["data"];

    items = list.map((obj) => FriendInfoItemModel.fromJson(obj)).toList();
  }

}