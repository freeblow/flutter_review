class TaskRefItemModel{

  TaskRefItemModel({
    this.icon = "assets/task/task_ref_invitefriends.png",
    this.needInviteCount = 0,
    this.haveInviteCount = 0,
    this.rewardCount = 0,
    this.id = "",
    this.isClaimed = false,

  });

  String icon = "assets/task/task_ref_invitefriends.png";

  int needInviteCount = 0;

  bool isClaimed = false;


  String get title{
    if(needInviteCount == 1){
      return "Invite ${needInviteCount} Friend";
    }
    return "Invite ${needInviteCount} Friends";
  }

  int rewardCount = 0;
  int haveInviteCount = 0;

  String id = "";

  int taskCategory = 0;
  String taskId = "";
  String ownerId = "";
  int taskType = 0;
  int status = 0;
  num reward = 0;

  double get inviteProgress{
    if(needInviteCount <= 0 || needInviteCount <= haveInviteCount){
      return 1.0;
    }

    return haveInviteCount.toDouble() / needInviteCount.toDouble();
  }

  bool get isInviteFinish{
    return (needInviteCount > 0 && haveInviteCount > 0 && needInviteCount == haveInviteCount) || status == 2;
  }

  TaskRefItemModel.fromJson(dynamic json){
    icon = "assets/task/task_ref_invitefriends.png";

    taskId = "${json["taskId"] ?? "0"}";
    ownerId = "${ json["ownerId"] ?? "0"}";
    reward =  num.parse("${json["reward"] ?? 0}");
    rewardCount = reward.toInt();
    taskType = json["taskType"] ?? 0;
    taskCategory = json["taskCategory"] ?? 0;

    status = json["status"] ?? 0;

    needInviteCount = json["referral_limt"] ?? 0;
    haveInviteCount = json["referral_count"] ?? 0;

    isClaimed = (status == 3) && (needInviteCount <= haveInviteCount);
  }

}