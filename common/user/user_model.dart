class UserModel{

  UserModel({
    this.telegramId = "",this.userId = "", this.username = "",this.icon  = "", this.miningInitMultiple = 1, this.speedyMiningMultiple = 2
  });

  String telegramId = "";
  String userId = "";
  String username = "";
  String icon = "";

  int status = 0;

  int miningInitMultiple = 1;
  int speedyMiningMultiple = 1;

  int energy = 0;
  int energyThreshold = 0;

  int energyLimit = 0;

  num createTime = 0;

  num totalToken = 0;

  num tokenBalance = 0;

  num clickBalance = 0;

  num inviteRefReward = 0;

  int speedyModeCount = 0;

  int fufillEnergyCount = 0;

  int energyLimitLevel = 1;

  int eneryRechargeLevel = 1;

  int multiTapLevel = 1;

  num lastEnergyRefreshTime = 0;

  num offlineRewardStartTime = 0;

  String email = "";

  String lang = "en";

  String twitter = "";

  int speedyTapRate = 1;

  int offlineReward = 0;

  bool offlineRewardActivated = false;

  int normalTapMultipler = 1;

  int speedyTapMultipler = 1;

  Map<String, dynamic> settings = {};

  int rechargeSpeed = 1;

  bool hasOfflineMine = false;


  UserModel.fromJson(dynamic json){
    this.telegramId = "${json["telegram"] ?? ""}";
    this.userId = "${json["userID"] ?? ""}";
    energy = json["energy"] ?? 0;
    energyThreshold = json["energyThreshold"] ?? 500;

    energyLimit = json["energyLimit"] ?? 500;

    createTime = json["createTime"] ?? 0;

    tokenBalance = json["tokenBalance"] ?? 0;

    clickBalance = json["clickBalance"] ?? 0;

    totalToken = json["totalToken"] ?? 0;

    inviteRefReward = json["inviteRefReward"] ?? 0;

    status = json["status"] ?? 0;

    username = json["username"] ?? 0;

    speedyModeCount = json["speedyModeCount"] ?? 0; //speedy加速的留存次数

    fufillEnergyCount = json["fufillEnergyCount"] ?? 0; //充能次数

    energyLimitLevel = json["energyLimitLevel"] ?? 1; //

    eneryRechargeLevel = json["eneryRechargeLevel"] ?? 1;

    multiTapLevel = json["multiTapLevel"] ?? 1;

    lastEnergyRefreshTime = json["lastEnergyRefreshTime"] ?? 0;

    offlineRewardStartTime = json["offlineRewardStartTime"] ?? 0;

    email = json["email"] ?? "";

    lang = json["lang"] ?? "en";

    twitter = json["twitter"] ?? "";

    speedyTapRate = json["speedyTapRate"] ?? 1;
    speedyMiningMultiple = json["speedyTapRate"] ?? 1;
    offlineReward = json["offlineReward"] ?? 0;

    offlineRewardActivated = json["offlineRewardActivated"] ?? false;

    hasOfflineMine = json["hasOfflineMine"] ?? false;
    settings = json["settings"] ?? {};

    normalTapMultipler = json["normalTapMultipler"] ?? 1;
    speedyTapMultipler = json["speedyTapMultipler"] ?? 1;

    rechargeSpeed = json["rechargeSpeed"] ?? 1;

  }

}