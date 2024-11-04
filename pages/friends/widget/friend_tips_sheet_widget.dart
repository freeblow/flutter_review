import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/pages/task/controller/task_controller.dart';

import '../../../common/const/color.dart';
import '../../../common/utils/tm_custom_button.dart';
import '../../../common/utils/tm_event_bus_manager.dart';
import '../../root/provider/tab_index_provider.dart';

class FriendTipsSheetWidget{
  static void showTips(BuildContext context){
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
                Align(
                  alignment: Alignment.center,
                  child:Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 8),
                    width: 320,
                    alignment: Alignment.centerLeft,
                    child: Text("Referral Rules:",style: TextStyle(color:  COLOR_F0E890 , fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child:Container(
                    padding: const EdgeInsets.only( bottom: 80),
                    width: 320,
                    alignment: Alignment.centerLeft,
                    child: Text("1. Check the rewards in the Task list. \n2. You can earn 10% of the points your direct referrals(Tier-1) accumulate from mining and 5% of your second-level referrals(Tier-2), task rewards are not counted.\n3. Every friend you invite will receive the start-up capital +25,000 ores.",maxLines: 20,textAlign: TextAlign.left,style: TextStyle(color:  COLOR_938A56 , fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                ),

                // Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     margin: const EdgeInsets.only( bottom: 15),
                //     width:  115,
                //     height: 115,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(14),
                //       color: Colors.black.withOpacity(0.3),
                //     ),
                //     child:  Image.asset("assets/friend/friend_tip_panel_icon.png", width: 115, height: 115,),
                //   ),
                // ),

                Align(
                  alignment: Alignment.center,
                  child: TMCustomButton(
                    size: const Size(311, 66),
                    title: "Get it !",
                    cornerRadius: 6,
                    titleStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 25, color: COLOR_684414),
                    offset: const Offset(1.5, 3),
                    onTap: (){
                      Navigator.of(context).pop();
                      Provider.of<TabIndexNotifier>(context, listen: false).setIndex(2);
                      TMEventBusManager.eventBus.fire(TMEventBusManager.TMEventName_TabTaskRef);
                      Provider.of<TaskController>(context, listen: false).refreshTaskStatus();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}