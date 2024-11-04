

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:tapmine/pages/friends/model/friend_root_list_model.dart';

import '../../../common/network/api.dart';
import '../model/friend_info_item_model.dart';

enum FriendTireLevel{
  one,
  two,
  none
}

class FriendsController extends ChangeNotifier{

  int myReferrals = 0;

  setReferrals(){
    myReferrals = _oneReferral + _twoReferral;
    notifyListeners();
  }

  int _oneReferral = 0;
  int _twoReferral = 0;


  int oneLevelRatio = 10;
  int twoLevelRatio = 5;
  setLevelRatio(int one, int two){
    oneLevelRatio = one;
    twoLevelRatio = two;
    notifyListeners();
  }


  bool isOneListFinish = true;
  bool isTwoListFinish = true;

  List<FriendInfoItemModel> oneList = [];

  List<FriendInfoItemModel> twoList = [];

  void setOneList(List<FriendInfoItemModel> one){
    oneList = one;
  }

  void setTwoList(List<FriendInfoItemModel> two){
    twoList = two;
  }

  void _addOneList(List<FriendInfoItemModel> ones){
    if(ones.isNotEmpty){
      myReferrals = _oneReferral + _twoReferral;
      oneList.addAll(ones);
      notifyListeners();
    }
  }

  void _addTwoList(List<FriendInfoItemModel> twoes){
    if(twoes.isNotEmpty){
      myReferrals = _oneReferral + _twoReferral;
      twoList.addAll(twoes);
      notifyListeners();
    }
  }

  setList(List<FriendInfoItemModel> one, List<FriendInfoItemModel> two){
    myReferrals = _oneReferral + _twoReferral;
    oneList = one;
    twoList = two;
  }


  static List<FriendInfoItemModel> oneSampelList = [
    FriendInfoItemModel(coinCount: "20000",type: FriendInfoType.one),
    FriendInfoItemModel(coinCount: "30000",type: FriendInfoType.one),
    FriendInfoItemModel(coinCount: "20000",type: FriendInfoType.one),

  ];

  static List<FriendInfoItemModel> twoSampelList = [
    FriendInfoItemModel(coinCount: "20000",type: FriendInfoType.two),
    FriendInfoItemModel(coinCount: "30000",type: FriendInfoType.two),
  ];



  int _onePage = 0;
  final int _onePageSize= 10;

  int _twoPage = 0;
  final int _twoPageSize = 10;

  Future<void> loadOneTiers() async {
    if(!isOneListFinish)return;
    isOneListFinish = false;
    var result = await API.subUserInfo(params:  {"tier": "1", "pageSize":"$_onePageSize", "pageNum": "${_onePage+1}" });
    if(result.code == "0"){
        if(result.result != null && result.result["userInfo"] != null){
          FriendRootListModel rootModel = FriendRootListModel.fromJson(result.result["userInfo"]);
          // myReferrals = rootModel.referrals;
          _oneReferral = rootModel.referrals;
          setReferrals();
          if(_onePage == 0){
            oneList.clear();
          }
          if(rootModel.items.isNotEmpty){
            _onePage++;
          }
          _addOneList(rootModel.items);
          isOneListFinish = true;
          return;
        }
    }
    isOneListFinish = true;
  }

  Future<void> loadTwoTiers() async {
    if(!isTwoListFinish)return;
    isTwoListFinish = false;
    var result = await API.subUserInfo(params:  {"tier": "2", "pageSize":"$_twoPageSize", "pageNum": "${_twoPage+1}" });
    if(result.code == "0"){
      if(result.result != null && result.result["userInfo"] != null){
        FriendRootListModel rootModel = FriendRootListModel.fromJson(result.result["userInfo"]);
        // setReferrals(rootModel.referrals);
        _twoReferral = rootModel.referrals;
        setReferrals();

        if(_twoPage == 0){
          twoList.clear();
        }
        if(rootModel.items.isNotEmpty){
          _twoPage++;
        }
        _addTwoList(rootModel.items);
        isTwoListFinish = true;
        return;
      }
    }
    isTwoListFinish = true;
  }


  List<FriendInfoItemModel> currentListWith(FriendInfoType type){
    return type == FriendInfoType.one? oneList: twoList;
  }

  Future<void> refreshWith(FriendInfoType type) async {
    if(type == FriendInfoType.one){
      await loadOneTiers();
    }else{
      await loadTwoTiers();
    }
  }

  Future<void> initData() async {
    await loadOneTiers();
    await loadTwoTiers();
  }

  Future<void> refreshData() async {
    _onePage = 0;
    _twoPage = 0;
    oneList.clear();
    twoList.clear();
    loadOneTiers();
    loadTwoTiers();
  }


}