import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/common/utils/tm_custom_button.dart';
import 'package:tapmine/pages/task/controller/task_controller.dart';

import '../../../../common/const/color.dart';
import '../../../../common/utils/tp_common.dart';
import '../../../boost/controller/boost_controller.dart';
import '../../../boost/widget/boost_task_sheet_panel_widget.dart';
import '../../../root/root_page.dart';
import '../../controller/task_daily_controller.dart';
import '../../model/daily_login_reward_item_model.dart';

class DailyLoginRewardItemWidget extends StatefulWidget {
  DailyLoginRewardItemWidget({super.key, required this.item});

  late DailyLoginRewardItemModel item;

  @override
  State<DailyLoginRewardItemWidget> createState() => _DailyLoginRewardItemWidgetState();
}

class _DailyLoginRewardItemWidgetState extends State<DailyLoginRewardItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311,
      height: 67,
      decoration: BoxDecoration(
        color: COLOR_FFFBCF,
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 22,),
              Image.asset(widget.item.icon, width: 32, height: 32,),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                child: Text(TPCommon.formatNumberWithSpaces("${widget.item.reward}"), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: COLOR_8D621B),),
              ),
              Expanded(child: Container()),
              rightW(),

            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 16,
              width: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(8),
                color: COLOR_E8B029,
              ),
              child: Text("Day ${widget.item.day}", style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400),),

            ),
          ),
          finishMask(),
        ],
      ),
    );
  }

  Widget rightW(){
    if(widget.item.status == DailyLoginRewardItemStatus.lock){
      return Padding(
          padding: EdgeInsets.only(right: 40),
        child: Image.asset("assets/task/task_daily_lock.png", width: 29, height: 37,),
      );
    }
    if(widget.item.status == DailyLoginRewardItemStatus.waitingClaim){
      return Container(
        margin: const EdgeInsets.only(right: 27),
        child: TMCustomButton(
          size: const Size(65, 30),
          offset: const Offset(1, 2),
          title: "Claim",
          cornerRadius: 5,
          titleStyle: TextStyle(fontSize: 12, color:COLOR_684412),
          onTap: (){
            //
            Provider.of<TaskDailyController>(RootPage.navigatorKey.currentContext!,  listen: false).commitDailyRewardTask(widget.item,finish: (isSuccess, reward){
              if(isSuccess){
                //Mission complete
                BoostTaskSheetPanelWidget.showAlert(context, title:"Mission complete", clickAction: (){
                  Navigator.of(context).pop();
                });
                Timer(const Duration(milliseconds: 200), (){
                  TaskController.taskBalanceAddRefreshUserInfo(reward);
                });
              }else{
                BoostTaskSheetPanelWidget.showAlert(context, title:"The task has not yet been completed", clickAction: (){
                  Navigator.of(context).pop();
                });
              }
            });

          },
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget finishMask(){
    if(widget.item.status == DailyLoginRewardItemStatus.finish){
      return Container(
        width: 311,
        height: 67,
        padding: const EdgeInsets.only(right: 35),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.0)
        ),
        alignment: Alignment.centerRight,
        child: Image.asset("assets/task/task_daily_item_finish_flag.png", width: 33, height: 30,),
      );
    }
    return const SizedBox.shrink();
  }
}
