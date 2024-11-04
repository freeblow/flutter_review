
import 'package:flutter/material.dart';


class BoostTaskSheetTypeTextcontentModel{

  BoostTaskSheetTypeTextcontentModel({
    this.title = "",
    this.subTitle = "",
    this.icon = "",
    this.coinCount = "Free",
    this.isMax = false,
    this.level = 0,
    this.isInsuficientFunds = false,
  });

  String coinCount = "Free";
  String title = "";
  String subTitle = "";
  String icon = "";
  bool isMax = false;
  int level = 0;
  bool isInsuficientFunds = false;
}