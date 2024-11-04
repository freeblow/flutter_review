import 'package:provider/provider.dart';
import 'package:tapmine/websocket/pipeline/tm_msg_task.dart';

import '../../../common/const/game_config.dart';
import '../../../common/network/api.dart';
import '../../../common/user/user_manager.dart';
import '../../../common/user/user_model.dart';
import '../../../websocket/pipeline/tp_pipeline_task.dart';
import '../../mining/provider/user_info_provider.dart';
import '../../root/root_page.dart';
import '../model/boost_task_item_model.dart';

enum BoosterTaskType{
  multiTap,
  energyLimit,
  rechargingSpeed,
  working,
}



class BoostController{
  int coinCount = 0;

  int speedyMultipleCount = 0;

  int energyMultipleCount = 0;

  List<BoostTaskItemModel> boostTaskItems(UserModel userInfo){
    return [
      BoostTaskItemModel(level: userInfo.multiTapLevel,icon:"assets/booster/boost_multitap.png", title: "Multitap", isFinish: ((userInfo.settings!["multipTapLevel"]??{})["max"] ?? 0) == userInfo.multiTapLevel, upgradeLevelNeedCoins: (userInfo.settings!["multi_tap_level_up_cost"] ?? 0), type: BoosterTaskType.multiTap,),
      BoostTaskItemModel(level: userInfo.energyLimitLevel,icon:"assets/booster/boost_energy_limit.png", title: "Energy Limit", isFinish: ((userInfo.settings!["energyLimitLevel"]??{})["max"] ?? 0) == userInfo.energyLimitLevel, upgradeLevelNeedCoins: (userInfo.settings!["energy_limit_level_up_cost"] ?? 0), type: BoosterTaskType.energyLimit,),
      BoostTaskItemModel(level: userInfo.eneryRechargeLevel,icon:"assets/booster/boost_recharging_speed.png", title: "Recharging Speed", isFinish: ((userInfo.settings!["rechargeLevel"]??{})["max"] ?? 0) == userInfo.eneryRechargeLevel, upgradeLevelNeedCoins: (userInfo.settings!["recharge_level_up_cost"] ?? 0), type: BoosterTaskType.rechargingSpeed,),
      BoostTaskItemModel(level: 1,icon:"assets/booster/boost_miner.png", title: "Miner", isFinish: userInfo.offlineRewardActivated, upgradeLevelNeedCoins: (userInfo.settings!["offline_reward_activate_cost"] ?? 0), type: BoosterTaskType.working,), //offline_reward_activate_cost
    ];
  }


  static bool isFullEnergyFinish = true;
  static bool isEnergyLeveupFinish = true;
  static bool isTapLevelUpFinish = true;
  static bool isRechargeLevelUpFinish = true;
  static bool isStartOfflineRewardFinish = true;

  static Future<void> fullEnergy({Function(bool)? finish }) async {
    if(!isFullEnergyFinish)return;
    isFullEnergyFinish = false;
    var result = await API.fullfillEnergy();
    if(result.code == "0"){
      refreshFullfillEnergy();
      if(finish != null){
        finish(true);
      }
      isFullEnergyFinish = true;
      return;
    }
    if(finish != null){
      finish(false);
    }
    isFullEnergyFinish = true;
  }

  static Future<void> energyLevelUp({Function(bool)? finish }) async {
    if(!isEnergyLeveupFinish)return;
    isEnergyLeveupFinish = false;
    var result = await API.energyLevelUp();
    if(result.code == "0"){
      refreshEnergyLevelUp();
      if(finish != null){
        finish(true);
      }
      isEnergyLeveupFinish = true;
      return;
    }
    if(finish != null){
      finish(false);
    }
    isEnergyLeveupFinish = true;
  }


  static Future<void> tapLevelUp({Function(bool)? finish }) async {
    if(!isTapLevelUpFinish)return;
    isTapLevelUpFinish = false;
    var result = await API.tapLevelUp();
    if(result.code == "0"){
      refreshTapLevelUp();
      if(finish != null){
        finish(true);
      }
      isTapLevelUpFinish = true;
      return;
    }
    if(finish != null){
      // finish(false);
      refreshTapLevelUp();
      finish(true);
    }
    isTapLevelUpFinish = true;
  }

  static Future<void> rechargeLevelUp({Function(bool)? finish }) async {
    if(!isRechargeLevelUpFinish)return;
    isRechargeLevelUpFinish = false;
    var result = await API.rechargeLevelUp();
    if(result.code == "0"){
      refreshRechargeLevelUp();
      if(finish != null){
        finish(true);
      }
      isRechargeLevelUpFinish = true;
      return;
    }
    if(finish != null){
      // finish(false);
      refreshRechargeLevelUp();
      finish(true);
    }
    isRechargeLevelUpFinish = true;
  }

  static Future<void> startOfflineReward({Function(bool)? finish }) async {
    if(!isStartOfflineRewardFinish)return;
    isStartOfflineRewardFinish = false;
    var result = await API.startOfflineReward();
    if(result.code == "0"){
      if(finish != null){
        finish(true);
      }
      isStartOfflineRewardFinish = true;
      return;
    }
    if(finish != null){
      finish(false);
    }
    isStartOfflineRewardFinish = true;
  }

  static void refreshFullfillEnergy(){
    UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;
    userInfo.energy = userInfo.energyThreshold;
    userInfo.fufillEnergyCount -= 1;
    if(userInfo.fufillEnergyCount < 0){
      userInfo.fufillEnergyCount = 0;
    }
    UserManager.instance.setUserModel(userInfo);
    if(TPPipelineTask.instance.isSpeedy){
      TPPipelineTask.instance.speedyMultiple =  UserManager.instance.user.speedyTapMultipler * UserManager.instance.user.normalTapMultipler;
    }else{
      TPPipelineTask.instance.speedyMultiple = UserManager.instance.user.normalTapMultipler;
    }
    Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);

  }
  static refreshSpeedyStatus(){
    UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;
    userInfo.speedyModeCount -= 1;
    if(userInfo.speedyModeCount < 0){
      userInfo.speedyModeCount = 0;
    }
    UserManager.instance.setUserModel(userInfo);

    Future.delayed(Duration(milliseconds: 200),(){
      TPPipelineTask.instance.startSpeedyMining();
    });

    Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);
  }
  static bool  refreshEnergyLevelUp(){
    UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;

    var willCostValue = GameConfig.ENERGY_LEVEL_UP_CONFIG['${userInfo.energyLimitLevel+1}']?["needToken"] as num ?? 0;
    if(willCostValue <= userInfo.tokenBalance){
      int orignaLevel = userInfo.energyLimitLevel;
      userInfo.energyLimitLevel += 1;
      userInfo.tokenBalance -= willCostValue;
      userInfo.energyThreshold =  (GameConfig.ENERGY_LEVEL_UP_CONFIG['${userInfo.energyLimitLevel}']?["energyThreshold"])?.toInt() ?? 500;
      userInfo.energyLimit = userInfo.energyThreshold;

      int maxLevel = userInfo.settings["energyLimitLevel"]?["max"] ?? 0;
      if(userInfo.multiTapLevel != maxLevel){
        userInfo.settings['energy_limit_level_up_cost'] = GameConfig.ENERGY_LEVEL_UP_CONFIG['${userInfo.energyLimitLevel + 1}']?["needToken"] as num ?? 500;
      }else{
        userInfo.settings['energy_limit_level_up_cost'] = 0;
      }

      UserManager.instance.setUserModel(userInfo);
      if(TPPipelineTask.instance.isSpeedy){
        TPPipelineTask.instance.speedyMultiple =  UserManager.instance.user.speedyTapMultipler * UserManager.instance.user.normalTapMultipler;
      }else{
        TPPipelineTask.instance.speedyMultiple = UserManager.instance.user.normalTapMultipler;
      }
      Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);

      return true;
    }

    return false;
  }

  static bool refreshTapLevelUp(){
    UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;

    var willCostValue = GameConfig.MULTI_TAP_LEVEL_UP_CONFIG['${userInfo.multiTapLevel+1}']?["needToken"] as num ?? 0;

    if(userInfo.tokenBalance > willCostValue){
      int orignaLevel = userInfo.multiTapLevel;
      userInfo.multiTapLevel += 1;
      userInfo.tokenBalance -= willCostValue;
      userInfo.normalTapMultipler =  (GameConfig.MULTI_TAP_LEVEL_UP_CONFIG['${userInfo.multiTapLevel}']?["multipler"])?.toInt() ?? 500;

      int maxLevel = userInfo.settings["multipTapLevel"]?["max"] ?? 0;
      if(userInfo.multiTapLevel != maxLevel){
        userInfo.settings['multi_tap_level_up_cost'] = GameConfig.MULTI_TAP_LEVEL_UP_CONFIG['${userInfo.multiTapLevel + 1}']?["needToken"] as num ?? 500;
      }else{
        userInfo.settings['multi_tap_level_up_cost'] = 0;
      }

      UserManager.instance.setUserModel(userInfo);
      if(TPPipelineTask.instance.isSpeedy){
        TPPipelineTask.instance.speedyMultiple =  UserManager.instance.user.speedyTapMultipler * UserManager.instance.user.normalTapMultipler;
      }else{
        TPPipelineTask.instance.speedyMultiple = UserManager.instance.user.normalTapMultipler;
      }
      Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);
      return true;
    }

    return false;

  }

  static void refreshRechargeLevelUp(){
    UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;

    int orignaLevel = userInfo.eneryRechargeLevel;
    var willCostValue = GameConfig.RECHARGE_LEVEL_UP_CONFIG['${userInfo.eneryRechargeLevel+1}']?["needToken"] as num ?? 0;

    if(userInfo.tokenBalance > willCostValue){
      userInfo.eneryRechargeLevel += 1;
      userInfo.tokenBalance -= GameConfig.RECHARGE_LEVEL_UP_CONFIG['${userInfo.eneryRechargeLevel}']?["needToken"] as num ?? 500;
      userInfo.rechargeSpeed =  (GameConfig.RECHARGE_LEVEL_UP_CONFIG['${userInfo.eneryRechargeLevel}']?["speed"])?.toInt() ?? 1;
      int maxLevel = userInfo.settings["rechargeLevel"]?["max"] ?? 0;
      if(userInfo.eneryRechargeLevel != maxLevel){
        userInfo.settings['recharge_level_up_cost'] = GameConfig.RECHARGE_LEVEL_UP_CONFIG['${userInfo.eneryRechargeLevel + 1}']?["needToken"] as num ?? 500;
      }else{
        userInfo.settings['recharge_level_up_cost'] = 0;
      }
    }



    UserManager.instance.setUserModel(userInfo);
    if(TPPipelineTask.instance.isSpeedy){
      TPPipelineTask.instance.speedyMultiple =  UserManager.instance.user.speedyTapMultipler * UserManager.instance.user.normalTapMultipler;
    }else{
      TPPipelineTask.instance.speedyMultiple = UserManager.instance.user.normalTapMultipler;
    }
    Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);
  }

  static void refreshOfflineRewards({bool isActivie = false}){
    UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;

    if(isActivie){
      userInfo.tokenBalance += userInfo.offlineReward;
      userInfo.clickBalance += userInfo.offlineReward;
      userInfo.totalToken += userInfo.offlineReward;
      userInfo.offlineReward = 0;
    }else{
      var willCostValue = userInfo.settings!["offline_reward_activate_cost"] ?? 0;
      if(userInfo.tokenBalance >= willCostValue){
        userInfo.tokenBalance -= (userInfo.settings!["offline_reward_activate_cost"] ?? 0);
        userInfo.offlineRewardActivated = true;
      }
    }

    UserManager.instance.setUserModel(userInfo);
    if(TPPipelineTask.instance.isSpeedy){
      TPPipelineTask.instance.speedyMultiple =  UserManager.instance.user.speedyTapMultipler * UserManager.instance.user.normalTapMultipler;
    }else{
      TPPipelineTask.instance.speedyMultiple = UserManager.instance.user.normalTapMultipler;
    }
    Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);
  }

  static UserModel resetUserInfo(){
    TPPipelineTask.instance.speedyMultiple = UserManager.instance.user.normalTapMultipler;
    UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;
    userInfo.energyThreshold = UserManager.instance.user.energyThreshold;
    userInfo.normalTapMultipler =  UserManager.instance.user.normalTapMultipler;
    userInfo.rechargeSpeed = UserManager.instance.user.rechargeSpeed;
    userInfo.miningInitMultiple = UserManager.instance.user.miningInitMultiple;
    userInfo.speedyMiningMultiple = UserManager.instance.user.speedyMiningMultiple;

    userInfo.createTime = UserManager.instance.user.createTime;
    userInfo.speedyModeCount = UserManager.instance.user.speedyModeCount;
    userInfo.fufillEnergyCount = UserManager.instance.user.fufillEnergyCount;
    userInfo.energyLimitLevel = UserManager.instance.user.energyLimitLevel;
    userInfo.eneryRechargeLevel = UserManager.instance.user.eneryRechargeLevel;
    userInfo.multiTapLevel = UserManager.instance.user.multiTapLevel;
    userInfo.lastEnergyRefreshTime = UserManager.instance.user.lastEnergyRefreshTime;
    userInfo.offlineRewardStartTime = UserManager.instance.user.offlineRewardStartTime;

    userInfo.email = UserManager.instance.user.email;
    userInfo.lang = UserManager.instance.user.lang;
    userInfo.twitter = UserManager.instance.user.twitter;
    userInfo.speedyTapRate = UserManager.instance.user.speedyTapRate;
    userInfo.offlineReward = UserManager.instance.user.offlineReward;
    userInfo.offlineRewardActivated = UserManager.instance.user.offlineRewardActivated;
    userInfo.normalTapMultipler = UserManager.instance.user.normalTapMultipler;
    userInfo.speedyTapMultipler = UserManager.instance.user.speedyTapMultipler;
    userInfo.rechargeSpeed = UserManager.instance.user.rechargeSpeed;
    userInfo.settings = UserManager.instance.user.settings;


    return userInfo;
  }

  static void refreshUserInfo(){
    UserManager.instance.reqUserInfo().whenComplete((){
      // TPPipelineTask.instance.startConnect();
      UserModel userInfo = resetUserInfo();
      Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);
    });
  }


}