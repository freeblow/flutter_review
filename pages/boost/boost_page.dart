import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:native_scroll/native_scroll.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/common/user/user_manager.dart';
import 'package:tapmine/common/utils/tp_common.dart';
import 'package:tapmine/pages/boost/controller/boost_controller.dart';
import 'package:tapmine/pages/boost/widget/boost_task_item_widget.dart';
import 'package:tapmine/pages/boost/widget/boost_task_sheet_panel_widget.dart';
import 'package:tapmine/pages/boost/widget/count_timer/flutter_timer_countdown.dart';
import 'package:tapmine/pages/boost/widget/count_timer/timer_sperator_sign_model.dart';

import '../../common/const/color.dart';
import '../../common/user/user_model.dart';
import '../../common/utils/glow_text.dart';
import '../../common/utils/noscrollbar_behavior.dart';
import '../../websocket/pipeline/tp_pipeline_task.dart';
import '../mining/provider/user_info_provider.dart';
import '../root/root_page.dart';
import 'model/boost_task_item_model.dart';
import 'model/boost_task_sheet_type_textcontent_model.dart';

class BoostPage extends StatefulWidget {
  const BoostPage({super.key});

  @override
  State<BoostPage> createState() => _BoostPageState();
}

class _BoostPageState extends State<BoostPage> {


  late BoostController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = BoostController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration:  BoxDecoration(
              color: COLOR_3D3121,
              image: const DecorationImage(
                  image: AssetImage("assets/root/main_gradient_bg.png"),
                  fit: BoxFit.fill
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 67),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/mining/mining_coin_icon.png", width: 50,height: 50,),
                      const SizedBox(width: 10,),
                      Consumer<UserInfoProvider>(
                          builder: (context, userinfoP, child){
                            return GlowText(text: TPCommon.formatNumberWithSpaces("${userinfoP.userinfo.tokenBalance}", sign:","),
                              color: COLOR_FFFEF3,
                              shadowColor: COLOR_FFEB7C,
                              fontSize: 40,
                              strokeWidthText: 0,
                              blurRadius: 15,
                              letterSpacing: 3,
                              backgroundColor: COLOR_FFFEF3,
                            );
                          }),

                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                width: 312,
                height: 1.0,
                color: COLOR_776F17,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 23),
                width: 312,
                child: Text(
                  "Your Daily Boosters:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: COLOR_E6DEA6),
                ),
              ),
              Container(
                width: 312,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                      Consumer<UserInfoProvider>(
                          builder: (context, userinfoP, child){
                            return multipleItemWidget("Speedy Mining", userinfoP.userinfo.speedyModeCount <= 0, userinfoP.userinfo.speedyModeCount, userinfoP.userinfo.settings["max_speedy_tap_count"] ?? 0, true);
                          }),
                    ),
                    const SizedBox(width: 13,),
                    Expanded(
                      child:Consumer<UserInfoProvider>(
                          builder: (context, userinfoP, child){
                            return  multipleItemWidget("Full Energy", userinfoP.userinfo.fufillEnergyCount <= 0, userinfoP.userinfo.fufillEnergyCount, userinfoP.userinfo.settings["max_refill_count"] ?? 0, false);
                          }),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 28, bottom: 24),
                width: 312,
                child: Text(
                  "Boosters:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: COLOR_E6DEA6),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 98),
                      child:NativeScrollBuilder(
                        builder: (BuildContext context, ScrollController controller){
                          return  ListView(
                            controller: controller,
                            children: [
                              Consumer<UserInfoProvider>(
                                  builder: (context, userinfoP, child){
                                    List<BoostTaskItemModel> mBoostItems = BoostController().boostTaskItems(userinfoP.userinfo);
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            BoostTaskItemModel item = mBoostItems[0];

                                            if(item.isFinish){
                                              BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.multiTapLevelMax];
                                              model?.coinCount = "${item.upgradeLevelNeedCoins}";
                                              model?.isMax = item.isFinish;
                                              model?.level = userinfoP.userinfo.multiTapLevel;
                                              if (kDebugMode) {
                                                print("multiTapLevel 0----userinfoP takenBalance = ${userinfoP.userinfo.tokenBalance}");
                                              }
                                              if (kDebugMode) {
                                                print("multiTapLevel 0----userinfoP Level Up Cost = ${userinfoP.userinfo.settings['multi_tap_level_up_cost']}");
                                              }
                                              model?.isInsuficientFunds = (userinfoP.userinfo.tokenBalance?? 0)  < (userinfoP.userinfo.settings['multi_tap_level_up_cost']);

                                              if(model != null){
                                                BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.multiTapLevelMax, model);
                                              }

                                              return;
                                            }
                                            BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.multiTapLevelUp];
                                            model?.coinCount = "${item.upgradeLevelNeedCoins}";
                                            model?.isMax = item.isFinish;
                                            model?.level = userinfoP.userinfo.multiTapLevel;
                                            model?.isInsuficientFunds = (userinfoP.userinfo.tokenBalance?? 0)  < (userinfoP.userinfo.settings['multi_tap_level_up_cost']);

                                            if(model != null){
                                              BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.multiTapLevelUp, model);
                                            }


                                          },
                                          child: BoostTaskItemWidget(item:mBoostItems[0],),
                                        ),
                                        const SizedBox(height: 10,),
                                        GestureDetector(
                                          onTap: (){
                                            BoostTaskItemModel item = mBoostItems[1];

                                            if(item.isFinish){
                                              BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.energyLimitLevelMax];
                                              model?.coinCount = "${item.upgradeLevelNeedCoins}";
                                              model?.isMax = item.isFinish;
                                              model?.level = userinfoP.userinfo.energyLimitLevel;
                                              model?.isInsuficientFunds = (userinfoP.userinfo.tokenBalance?? 0)  < (userinfoP.userinfo.settings['energy_limit_level_up_cost']);
                                              if(model != null){
                                                BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.energyLimitLevelMax, model);
                                              }

                                              return;
                                            }
                                            BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.energyLimitLevelUp];
                                            model?.coinCount = "${item.upgradeLevelNeedCoins}";
                                            model?.isMax = item.isFinish;
                                            model?.level = userinfoP.userinfo.energyLimitLevel;
                                            model?.isInsuficientFunds = (userinfoP.userinfo.tokenBalance?? 0)  < (userinfoP.userinfo.settings['energy_limit_level_up_cost']);
                                            if(model != null){
                                              BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.energyLimitLevelUp, model);
                                            }
                                          },
                                          child: BoostTaskItemWidget(item:mBoostItems[1],),
                                        ),

                                        const SizedBox(height: 10,),
                                        GestureDetector(
                                          onTap: (){
                                            BoostTaskItemModel item = mBoostItems[2];

                                            if(item.isFinish){
                                              BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.rechargingSpeedLevelMax];
                                              model?.coinCount = "${item.upgradeLevelNeedCoins}";
                                              model?.isMax = item.isFinish;
                                              model?.level = userinfoP.userinfo.eneryRechargeLevel;
                                              model?.isInsuficientFunds = (userinfoP.userinfo.tokenBalance?? 0)  < (userinfoP.userinfo.settings['recharge_level_up_cost']);
                                              if(model != null){
                                                BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.rechargingSpeedLevelMax, model);
                                              }

                                              return;
                                            }
                                            BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.rechargingSpeedLevelUp];
                                            model?.coinCount = "${item.upgradeLevelNeedCoins}";
                                            model?.isMax = item.isFinish;
                                            model?.level = userinfoP.userinfo.eneryRechargeLevel;
                                            model?.isInsuficientFunds = (userinfoP.userinfo.tokenBalance?? 0)  < (userinfoP.userinfo.settings['recharge_level_up_cost']);
                                            if(model != null){
                                              BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.rechargingSpeedLevelUp, model);
                                            }
                                          },
                                          child: BoostTaskItemWidget(item: mBoostItems[2],),
                                        ),
                                        const SizedBox(height: 10,),
                                        GestureDetector(
                                          onTap: (){
                                            print("Working Task Panel!!");
                                            BoostTaskItemModel item = mBoostItems[3];

                                            if(item.isFinish){
                                              BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.autoMiningWorking];
                                              model?.coinCount = "${item.upgradeLevelNeedCoins}";
                                              model?.isMax = item.isFinish;
                                              model?.isInsuficientFunds = (userinfoP.userinfo.tokenBalance?? 0)  < (item.upgradeLevelNeedCoins);
                                              if(model != null){
                                                BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.autoMiningWorking, model);
                                              }

                                              return;
                                            }
                                            BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.autoMiningStop];
                                            model?.coinCount = "${item.upgradeLevelNeedCoins}";
                                            model?.isMax = item.isFinish;
                                            model?.isInsuficientFunds = (userinfoP.userinfo.tokenBalance?? 0)  < (item.upgradeLevelNeedCoins);
                                            if(model != null){
                                              BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.autoMiningStop, model);
                                            }
                                          },
                                          child: BoostTaskItemWidget(item:mBoostItems[3],),
                                        ),
                                      ],
                                    );
                                  })
                            ],
                          );
                        },
                      )
                  )
              ),
            ],
          ),
        ) ,
      ),
    );
  }


  Widget multipleItemWidget(String title, bool isOver, int multipleCount, int maxValue, bool isSpeedy){
    if(isOver){
     return Container(
        height: 63,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(6)
        ),
        child: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: isSpeedy?7:14,),
                Image.asset(isSpeedy?"assets/booster/boost_speedy_mining.png" : "assets/booster/boost_full_energy.png", width: 40, height: 40,),
                SizedBox(width: isSpeedy?5:10,),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: COLOR_B9B48E),),
                    const SizedBox(height: 3,),
                    Text("", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: COLOR_FFCF4C),),
                  ],
                )
              ],
            ),
            Container(
              alignment: Alignment.bottomLeft,
               padding:  EdgeInsets.only(left: isSpeedy?51:64, bottom: 13, right: 8),
               decoration: BoxDecoration(
                   color:Colors.transparent,
                   borderRadius: BorderRadius.circular(6)
               ),
              child: Container(
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: TimerCountdown(
                    endTime: TPCommon.utcZero(),
                    format: CountDownTimerFormat.hoursMinutesSeconds,
                    timeTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: COLOR_FFCF4C),
                    spacerWidth: 0,
                    speratorSignModel: TimerSperatorSignModel(dayHour: "", hourMinute: "", minuteSecode: ""),
                    isNeedFullZero: false,
                    isWithUnit: true,
                    daysDescription: "",
                    enableDescriptions: false,
                    onEnd: (){
                      // UserManager.instance.reqUserInfo();
                      Timer(const Duration(milliseconds: 200), (){
                        UserModel userInfo = Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).userinfo;
                        if(isSpeedy){
                          userInfo.speedyModeCount = 3;
                        }else{
                          userInfo.fufillEnergyCount = 3;
                        }
                        UserManager.instance.setUserModel(userInfo);
                        Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(userInfo);
                      });

                    },

                  ),
              ),
            ),

          ],
        ),
      );
    }else{
      return GestureDetector(
        onTap: (){

          if(isSpeedy){
            BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.speedyMining];
            if(model != null){
              BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.speedyMining, model);
            }

            return;
          }
          BoostTaskSheetTypeTextcontentModel? model  = BoostTaskSheetPanelWidget.SheetContentText[BoostTaskSheetPanelStyle.fullEnergy];
          if(model != null){
            BoostTaskSheetPanelWidget.show(context, BoostTaskSheetPanelStyle.fullEnergy, model);
          }


        },
        child:  Container(
          height: 63,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: isSpeedy ? 9:14,),
              Image.asset(isSpeedy?"assets/booster/boost_speedy_mining.png" : "assets/booster/boost_full_energy.png", width: 40, height: 40,),
              SizedBox(width: isSpeedy?5:10,),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: COLOR_B9B48E),),
                  const SizedBox(height: 3,),
                  Text("$multipleCount/$maxValue", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: COLOR_FFCF4C),),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}

