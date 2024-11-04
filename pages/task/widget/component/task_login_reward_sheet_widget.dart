import 'package:flutter/material.dart';
import 'package:native_scroll/native_scroll.dart';
import 'package:tapmine/pages/task/model/daily_login_reward_item_model.dart';
import 'package:tapmine/pages/task/widget/component/login_reward_list_widget.dart';
import 'package:tapmine/pages/task/widget/item/daily_login_reward_item_widget.dart';

import '../../../../common/const/color.dart';

class TaskLoginRewardSheetWidget{

  static List<DailyLoginRewardItemModel> loginRewardItems = <DailyLoginRewardItemModel>[];


  static void showLoginReward(BuildContext context, {List<DailyLoginRewardItemModel>? items}){
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (BuildContext context){
          return Container(
            decoration:  BoxDecoration(
                color: COLOR_3D3121,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                image: const DecorationImage(
                    image: AssetImage("assets/root/main_gradient_bg.png"),
                    fit: BoxFit.fill
                )
            ),
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only( right: 0, top: 10),
                  alignment: Alignment.centerRight,
                  height: 51,
                  child: GestureDetector(
                    child: Container(
                      width: 70,
                      alignment: Alignment.center,
                      child:  Image.asset('assets/mining/mining_reminder_sheet_close_icon.png', width: 24, height: 27,),
                    ),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 15),
                  height: 34,
                  alignment: Alignment.center,
                  child: Text("Login Reward",style: TextStyle(color:  COLOR_F0E890 , fontSize: 22, fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 18,
                  alignment: Alignment.center,
                  child: Text("Log in for 7 consecutive days to claim all rewards",style: TextStyle(color:  COLOR_938A56 , fontSize: 12, fontWeight: FontWeight.bold),),
                ),

                Container(
                  height: 305,
                  child: LoginRewardListWidget(items: items,),

                ),
              ],
            ),
          );
        });
  }
}