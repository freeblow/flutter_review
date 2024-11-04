enum FriendInfoType{
  one,
  two,
  none
}

class FriendInfoItemModel{
  FriendInfoItemModel({this.icon = "assets/friend/friend_customer_head_icon.png", this.username = "unknown", this.coinCount = "0", this.userId = "", this.type = FriendInfoType.one});

  String icon = "assets/friend/friend_customer_head_icon.png";
  String username = "unknown";
  String coinCount = "0";
  String userId = "";

  FriendInfoType type = FriendInfoType.one;


  FriendInfoItemModel.fromJson(dynamic json){
    if(json == null) return;
    username = json["username"] ?? "unknown";
    if(username.isEmpty){
      username = "unknown";
    }
    icon = json["icon"] ?? "";

    num contributedReward =  json["contributedReward"] ?? 0;
    num clickBalance =  json["clickBalance"] ?? 0;
    coinCount = "${contributedReward.toInt()}";
    coinCount = "${clickBalance.toInt()}";

  }
}