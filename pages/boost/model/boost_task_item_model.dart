import 'package:tapmine/pages/boost/controller/boost_controller.dart';

class BoostTaskItemModel{

  BoostTaskItemModel({
    this.level = 0, this.title = "", this.icon = "", this.isFinish = false, this.upgradeLevelNeedCoins = 200, this.type = BoosterTaskType.multiTap
  });

  late int level;
  late String title;
  late bool isFinish;
  late int upgradeLevelNeedCoins;
  late BoosterTaskType type;
  String icon = "";
}