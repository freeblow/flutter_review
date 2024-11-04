import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/pages/task/controller/task_controller.dart';
import 'package:tapmine/pages/task/controller/task_ref_controller.dart';
import 'package:tapmine/pages/task/model/task_ref_item_model.dart';
import 'package:tapmine/pages/task/widget/component/task_ref_progress_widget.dart';

import '../../../../common/const/color.dart';
import '../../../../common/utils/tm_custom_button.dart';
import '../../../../common/utils/tp_common.dart';
import '../../../boost/widget/boost_task_sheet_panel_widget.dart';
import '../../../root/root_page.dart';

class RefItemWidget extends StatelessWidget {
  RefItemWidget({super.key, this.item});
  late TaskRefItemModel? item = TaskRefItemModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:Alignment.center,
      width: 312,
      padding: const EdgeInsets.only(top: 15, bottom: 9, right: 13, left: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                child: Image.asset(item?.icon ?? "", width: 50, height: 50,),

              ),
              Padding(
                padding:const EdgeInsets.only(left: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item?.title ?? "", style: TextStyle(fontSize: 12, color: COLOR_B9B48E, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 7,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/mining/mining_coin_icon.png", width: 18, height: 18,),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(TPCommon.formatNumberWithSpaces("${item?.rewardCount ?? 0}", sign:" "), style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: COLOR_EFD171),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              claimBtnWidget()
            ],
          ),
           const SizedBox(height: 9,),
           SizedBox(
             height: 19,
             width: 312 - 13 - 18,
             child: TaskRefProgressWidget(
               progress: item?.inviteProgress ?? 0,
               width: 312 - 13 - 18,
               height: 19,
               borderWidth: 1.8,
             ),
           )
        ],
      ),
    );
  }

  Widget claimBtnWidget(){
    if(item!= null && item!.isClaimed){
      return Image.asset("assets/task/task_daily_item_finish_flag.png", width: 25, height: 25,);
    }
    if(item!= null && item!.isInviteFinish){
      return TMCustomButton(
        size: const Size(73, 27),
        offset: const Offset(1, 2),
        cornerRadius: 4,
        title: "Claim",
     titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: COLOR_684412),
        onTap: (){
          Provider.of<TaskRefController>(RootPage.navigatorKey.currentContext!,  listen: false).commitRefRewardTask(item!, finish: (isSuccess, reward)  {
            if(isSuccess){
              BoostTaskSheetPanelWidget.showAlert(RootPage.navigatorKey.currentContext!, title:"Mission complete");
              Timer(const Duration(milliseconds: 200), (){

                TaskController.taskBalanceAddRefreshUserInfo(reward,isRef: true);
              });
            }
          });
        },
      );
    }
    return Container(
      width: 73,
      height: 27,
      alignment: Alignment.center,
      child: Stack(
        children: [
          TMCustomButton(
            size: const Size(73, 27),
            offset: const Offset(1, 2),
            cornerRadius: 4,
            title: "Claim",
            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: COLOR_684412),
          ),
          Container(
            width: 73,
            height: 27,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.black.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
