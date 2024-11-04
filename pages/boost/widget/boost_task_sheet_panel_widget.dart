import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tapmine/common/utils/tm_custom_button.dart';
import 'package:tapmine/common/utils/tp_common.dart';
import 'package:tapmine/pages/boost/controller/boost_controller.dart';
import 'package:tapmine/websocket/pipeline/tm_msg_task.dart';

import '../../../common/const/color.dart';
import '../../../common/user/user_model.dart';
import '../../../common/utils/glow_text.dart';
import '../../../common/utils/tm_alert_dialog.dart';
import '../../mining/provider/user_info_provider.dart';
import '../../root/provider/tab_index_provider.dart';
import '../../root/root_page.dart';
import '../model/boost_task_sheet_type_textcontent_model.dart';

enum BoostTaskSheetPanelStyle{
  speedyMining,
  fullEnergy,
  multiTapLevelUp,
  multiTapLevelMax,
  energyLimitLevelUp,
  energyLimitLevelMax,
  rechargingSpeedLevelUp,
  rechargingSpeedLevelMax,
  autoMiningStop,
  autoMiningWorking,
}

class BoostTaskSheetPanelWidget{

  static Map<BoostTaskSheetPanelStyle, BoostTaskSheetTypeTextcontentModel> SheetContentText = {
    BoostTaskSheetPanelStyle.speedyMining : BoostTaskSheetTypeTextcontentModel(
      title: "Speedy Mining",
      subTitle: "Get 5x earnings for 20 seconds \n without consuming energy",
      icon: "assets/booster/boost_speedy_mining.png",
      isMax: false,
      coinCount:"Free"
    ),
    BoostTaskSheetPanelStyle.fullEnergy : BoostTaskSheetTypeTextcontentModel(
        title: "Full Energy",
        subTitle: "Fill your energy to the max",
        icon: "assets/booster/boost_full_energy.png",
        isMax: false,
        coinCount:"Free"
    ),
    BoostTaskSheetPanelStyle.multiTapLevelUp : BoostTaskSheetTypeTextcontentModel(
        title: "Multitap",
        subTitle: "Increase the amount of ores you can earn per tap \n+1 per tap for each level up",
        icon: "assets/booster/boost_multitap.png",
        isMax: false,
        coinCount:"200",
        level: 1
    ),
    BoostTaskSheetPanelStyle.multiTapLevelMax : BoostTaskSheetTypeTextcontentModel(
        title: "Multitap",
        subTitle: "Increase the amount of ores you can earn per tap \n+1 per tap for each level up",
        icon: "assets/booster/boost_multitap.png",
        isMax: false,
        coinCount:"200",
        level: 1
    ),
    BoostTaskSheetPanelStyle.energyLimitLevelUp : BoostTaskSheetTypeTextcontentModel(
        title: "Energy Limit",
        subTitle: "Increase your energy limit\n+500 for each level up",
        icon: "assets/booster/boost_energy_limit.png",
        isMax: false,
        coinCount:"200",
    ),
    BoostTaskSheetPanelStyle.energyLimitLevelMax : BoostTaskSheetTypeTextcontentModel(
        title: "Energy Limit",
        subTitle: "Increase your energy limit\n+500 for each level up",
        icon: "assets/booster/boost_energy_limit.png",
        isMax: false,
        coinCount:"200"
    ),
    BoostTaskSheetPanelStyle.rechargingSpeedLevelUp : BoostTaskSheetTypeTextcontentModel(
      title: "Recharging Speed",
      subTitle: "Increase the speed of energy recharging\n+1 per second for each level up",
      icon: "assets/booster/boost_recharging_speed.png",
      isMax: false,
      coinCount:"200",
      isInsuficientFunds: true,
    ),
    BoostTaskSheetPanelStyle.rechargingSpeedLevelMax : BoostTaskSheetTypeTextcontentModel(
        title: "Recharging Speed",
        subTitle: "Increase the speed of energy recharging\n+1 per second for each level up",
        icon: "assets/booster/boost_recharging_speed.png",
        isMax: false,
        coinCount:"200"
    ),
    BoostTaskSheetPanelStyle.autoMiningStop : BoostTaskSheetTypeTextcontentModel(
      title: "Miner",
      subTitle: "The miner helps you mine when your energy is full. \nWork offline for up to 12 hours.",
      icon: "assets/booster/boost_miner.png",
      isMax: false,
      isInsuficientFunds: false,
      coinCount:"200",
    ),
    BoostTaskSheetPanelStyle.autoMiningWorking : BoostTaskSheetTypeTextcontentModel(
        title: "Miner",
        subTitle: "The miner helps you mine when your energy is full. \nWork offline for up to 12 hours.",
        icon: "assets/booster/boost_miner.png",
        isMax: false,
        coinCount:"200"
    ),
  };


  static void show(BuildContext context, BoostTaskSheetPanelStyle type, BoostTaskSheetTypeTextcontentModel model){

    showModalBottomSheet(
        context: RootPage.navigatorKey.currentContext!,
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
            height: 470,
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
                  padding: const EdgeInsets.only(top: 10, bottom: 16),
                  alignment: Alignment.center,
                  child: Text(model.title,style: TextStyle(color:  COLOR_F0E890 , fontSize: 30, fontWeight: FontWeight.bold),),
                ),

                Container(
                  padding: const EdgeInsets.only( bottom: 30),
                  alignment: Alignment.center,
                  child: Text(model.subTitle,textAlign: TextAlign.center,style: TextStyle(color:  COLOR_8B8251 , fontSize: 12, fontWeight: FontWeight.bold), maxLines: 2,overflow: TextOverflow.visible,),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width:  115,
                    height: 115,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Image.asset(model.icon, width: 115, height: 115,alignment: Alignment.center,),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 38),
                    child: consumeCoinsWiget(type, model),
                ),
                confirmPanelWidget(context, type, model),
              ],
            ),
          );
        });
  }


  static Widget consumeCoinsWiget(BoostTaskSheetPanelStyle style, BoostTaskSheetTypeTextcontentModel model){
    switch(style){
      case BoostTaskSheetPanelStyle.speedyMining:case BoostTaskSheetPanelStyle.fullEnergy:case BoostTaskSheetPanelStyle.autoMiningStop:{
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/mining/mining_coin_icon.png", width: 30, height: 30,),
              const SizedBox(width: 6,),
              Text(model.coinCount == "Free"? model.coinCount: TPCommon.formatNumberWithSpaces(model.coinCount, sign:","),style: TextStyle(color: COLOR_F1D272, fontSize: 22, fontWeight: FontWeight.bold),)
            ],
        );
      }
      case BoostTaskSheetPanelStyle.multiTapLevelUp:case BoostTaskSheetPanelStyle.energyLimitLevelUp: case BoostTaskSheetPanelStyle.rechargingSpeedLevelUp:{
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/mining/mining_coin_icon.png", width: 30, height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(TPCommon.formatNumberWithSpaces(model.coinCount, sign:","), style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: COLOR_F1D272),),
            ),

            Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Image.asset(
                  "assets/booster/booster_task_item_right_double_arrow_icon.png",
                  width: 18, height: 12,)
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text("Lv.${model.level + 1}",
                style: TextStyle(
                    fontSize: 24,
                  fontWeight: FontWeight.bold,
                       color: COLOR_FFF074
                ),
              ),
            ),

          ],
        );
      }
      case BoostTaskSheetPanelStyle.multiTapLevelMax:case BoostTaskSheetPanelStyle.energyLimitLevelMax: case BoostTaskSheetPanelStyle.rechargingSpeedLevelMax:{
        return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Text("Lv.${model.level}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: COLOR_FFF074
                      ),
                    ),
                  ),
                  GlowText(text: "MAX",
                    color: COLOR_FFFEF3,
                    shadowColor: COLOR_FFEB7C,
                    fontSize: 30,
                    strokeWidthText: 1,
                    blurRadius: 12,
                    letterSpacing: 1,
                    backgroundColor: COLOR_FFFEF3,
                  ),

                ],
        );
      }
      case BoostTaskSheetPanelStyle.autoMiningWorking: {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GlowText(text: "Working",
              color: COLOR_FFFEF3,
              shadowColor: COLOR_FFEB7C,
              fontSize: 30,
              strokeWidthText: 1,
              blurRadius: 12,
              letterSpacing: 1,
              backgroundColor: COLOR_FFFEF3,
            ),
          ],
        );
      }

    }

  }


  static Widget confirmPanelWidget(BuildContext context,BoostTaskSheetPanelStyle style, BoostTaskSheetTypeTextcontentModel model){
    if(kDebugMode){
      print("confirmPanelWidget --- style : ${style} model isFunds: ${model.isInsuficientFunds}");
    }
    switch(style){
      case BoostTaskSheetPanelStyle.speedyMining:case BoostTaskSheetPanelStyle.fullEnergy:{
        return Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 312,
              height: 67,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child:  Opacity(
                      opacity: 0.2,
                      child: Container(
                        height: 64.5,
                        width: 311,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: (){
                        if(style == BoostTaskSheetPanelStyle.speedyMining){
                          print("BoostTaskSheetPanelStyle.speedyMining ---- !");
                          Navigator.of(context).pop();
                          TMMsgTask.instance.startSpeedyMineMessage();
                          Provider.of<TabIndexNotifier>(RootPage.navigatorKey.currentContext!, listen: false).setIndex(0);
                          BoostController.refreshSpeedyStatus();
                          // Provider.of<UserInfoProvider>(context,  listen: false).refreshUserInfo();
                          return;
                        }

                        if(style == BoostTaskSheetPanelStyle.fullEnergy){
                          BoostController.fullEnergy(finish: (isSuccess){
                            Navigator.of(context).pop();
                            if(isSuccess){

                              Provider.of<TabIndexNotifier>(RootPage.navigatorKey.currentContext!, listen: false).setIndex(0);
                            }else{
                            }
                          });

                        }
                      },
                      child: Container(
                        height: 64.5,
                        width: 311,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: COLOR_EDC216,
                        ),
                        child: Text("Get it !", style: TextStyle(color: COLOR_684414, fontWeight: FontWeight.bold, fontSize: 25),),
                      ),
                    ),
                  ),

                ],
              ),

            )
        );
      }
      case BoostTaskSheetPanelStyle.multiTapLevelUp:case BoostTaskSheetPanelStyle.energyLimitLevelUp:case BoostTaskSheetPanelStyle.rechargingSpeedLevelUp:case BoostTaskSheetPanelStyle.autoMiningStop:{
        if(model.isInsuficientFunds){
          return Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 312,
                height: 67,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child:  Opacity(
                        opacity: 0.2,
                        child: Container(
                          height: 64.5,
                          width: 311,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: (){
                          // Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 64.5,
                          width: 311,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: COLOR_EDC216,
                          ),
                          child: Text("Insufficient funds", style: TextStyle(color: COLOR_684414, fontWeight: FontWeight.bold, fontSize: 25),),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ],
                ),

              )
          );
        }
        return Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 312,
              height: 67,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child:  Opacity(
                      opacity: 0.2,
                      child: Container(
                        height: 64.5,
                        width: 311,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: (){
                        if(style == BoostTaskSheetPanelStyle.multiTapLevelUp){
                            BoostController.tapLevelUp(finish: (isSuccess){
                              if(isSuccess){
                                showAlert(context, title: "Level up!", clickAction:(){
                                  Navigator.of(context).pop();
                                });
                              }
                            });
                        }

                        if(style == BoostTaskSheetPanelStyle.energyLimitLevelUp){
                          BoostController.energyLevelUp(finish: (isSuccess){
                            if(isSuccess){
                              showAlert(context, title: "Level up!", clickAction:(){
                                Navigator.of(context).pop();
                              });
                            }
                          });
                        }

                        if(style == BoostTaskSheetPanelStyle.rechargingSpeedLevelUp){
                          BoostController.rechargeLevelUp(finish: (isSuccess){
                            if(isSuccess){
                              showAlert(context, title: "Level up!", clickAction:(){
                                Navigator.of(context).pop();
                              });
                            }
                          });
                        }

                        if(style == BoostTaskSheetPanelStyle.autoMiningStop){
                          BoostController.startOfflineReward(finish: (isSuccess){
                            if(isSuccess){
                              BoostController.refreshOfflineRewards(isActivie: false);
                              showAlert(context, title: "Miner is ready to work", clickAction:(){
                                Navigator.of(context).pop();
                              });
                            }
                          });
                        }
                      },
                      child: Container(
                        height: 64.5,
                        width: 311,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: COLOR_EDC216,
                        ),
                        child: Text("Get it !", style: TextStyle(color: COLOR_684414, fontWeight: FontWeight.bold, fontSize: 25),),
                      ),
                    ),
                  ),

                ],
              ),

            )
        );
      }
      case BoostTaskSheetPanelStyle.autoMiningWorking:case BoostTaskSheetPanelStyle.multiTapLevelMax:case BoostTaskSheetPanelStyle.energyLimitLevelMax:case BoostTaskSheetPanelStyle.rechargingSpeedLevelMax:{
        return const SizedBox.shrink();
      }
    }
    return SizedBox.shrink();
  }
  
  
  static void showAlert(BuildContext context, {String title = "", Function? clickAction}){
    TMAlertDialog.showCustomAlertDialog(RootPage.navigatorKey.currentContext!,
        contentPadding: const EdgeInsets.only(top: 23, bottom: 11, left: 31, right: 31),
        contentAndBtnPadding: 12,
        contentDecoration: BoxDecoration(
            color: COLOR_3D3121,
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
                image: AssetImage("assets/root/main_gradient_bg.png"),
                fit: BoxFit.fill
            )
        ),
        btn:TMCustomButton(
          titleStyle: TextStyle(fontSize: 16, color: COLOR_684412,fontWeight: FontWeight.bold),
          offset: const Offset(1.5, 2.5),
          size: const Size(102,39),
          title: "OK",
          cornerRadius: 6,
          onTap: (){
            Navigator.of(context, rootNavigator: true).pop();
            if(clickAction != null){
              clickAction();
            }
          },
        ),
        contentW: GlowText(text: title,
          color: COLOR_FFFEF3,
          shadowColor: COLOR_FFEB7C,
          fontSize: 20,
          strokeWidthText: 0,
          blurRadius: 8,
          letterSpacing: 1,
          textAlign: TextAlign.center,
          backgroundColor: COLOR_FFFEF3,
        )
    );
  }

  static List<Shadow> _getShadows(Color color,double radius) {
    return [
      Shadow(color: color, blurRadius: radius / 2),
      Shadow(color: color, blurRadius: radius),
      Shadow(color: color, blurRadius: radius * 3),
    ];
  }

}

