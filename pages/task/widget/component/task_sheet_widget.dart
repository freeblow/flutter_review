import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/common/utils/tm_custom_button.dart';
import 'package:tapmine/pages/task/controller/task_controller.dart';
import 'package:tapmine/pages/task/controller/task_media_controller.dart';
import 'package:tapmine/pages/task/model/task_media_item_model.dart';

import '../../../../common/const/color.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

import '../../../../common/const/url.dart';
import '../../../../common/utils/tp_common.dart';
import '../../../boost/controller/boost_controller.dart';
import '../../../boost/widget/boost_task_sheet_panel_widget.dart';
import '../../../root/root_page.dart';

class TaskSheetWidget{

  static void showMediaSubcribe(BuildContext context, TaskMediaItemModel item){
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
            height: 475,
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
                  padding: const EdgeInsets.only(top: 5, bottom: 26),
                  alignment: Alignment.center,
                  child: Text(item?.title ?? "",style: TextStyle(color:  COLOR_F0E890 , fontSize: 22, fontWeight: FontWeight.bold),),
                ),

                Align(
                  alignment: Alignment.center,
                  child: TMCustomButton(
                    size: const Size(197, 53),
                    title: "Go ahead",
                    cornerRadius: 6,
                    titleStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 25, color: COLOR_684414),
                    offset: const Offset(1.5, 2.5),
                    onTap: (){
                      if(item.type == TMTaskMediaType.tg){
                        tg.openTelegramLink(TMURLs.TELEGRAM_BBS_GROUP_URL);
                        // Navigator.of(context).pop();
                        return;
                      }
                      // Navigator.of(context).pop();
                      tg.openLink(TMURLs.TWITTER_GROUP_URL);
                      Provider.of<TaskMediaController>(RootPage.navigatorKey.currentContext!,  listen: false).commitMediaTask(item, isFollowing: true,finish: (isSuccess, reward){
                        if(isSuccess){
                          // Timer(const Duration(milliseconds: 200), (){
                          //   BoostController.refreshUserInfo();
                          // });
                        }
                      });

                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 26, bottom: 8),
                    width:  115,
                    height: 115,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Image.asset(item.icon ?? "", width: 115, height: 115,alignment: Alignment.center,),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0, bottom: 20),
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/mining/mining_coin_icon.png", width: 36, height: 36,),
                      const SizedBox(width: 10,),
                      Text(TPCommon.formatNumberWithSpaces("${item.rewardCount}", sign:" "),style: TextStyle(color: COLOR_FFFBCF, fontSize: 22.5, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                
                item.isFollowing? Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/task/task_daily_item_finish_flag.png", width: 50, height: 48,),
                ):Align(
                    alignment: Alignment.topCenter,
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
                                Provider.of<TaskMediaController>(RootPage.navigatorKey.currentContext!,  listen: false).commitMediaTask(item,finish: (isSuccess, reward){
                                  if(isSuccess){
                                    //Mission complete
                                    Timer(const Duration(milliseconds: 200), (){
                                      TaskController.taskBalanceAddRefreshUserInfo(reward);
                                    });
                                    BoostTaskSheetPanelWidget.showAlert(context, title:"Mission complete", clickAction: (){
                                      Navigator.of(context).pop();
                                    });
                                  }else{
                                    BoostTaskSheetPanelWidget.showAlert(context, title:"The task has not yet been completed", clickAction: (){
                                      // Navigator.of(context).pop();
                                    });
                                  }
                                });

                              },
                              child: Container(
                                height: 64.5,
                                width: 311,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: COLOR_EDC216,
                                ),
                                child: Text("Check", style: TextStyle(color: COLOR_684414, fontWeight: FontWeight.bold, fontSize: 25),),
                              ),
                            ),
                          ),

                        ],
                      ),

                    )
                )
              ],
            ),
          );
        });
  }
}