import 'package:flutter/material.dart';
import 'package:tapmine/common/utils/tp_common.dart';
import 'package:tapmine/pages/boost/widget/boost_task_sheet_panel_widget.dart';

import '../../../common/const/color.dart';
import '../../../common/utils/glow_text.dart';
import '../../boost/controller/boost_controller.dart';

class MinerWorkReminderSheetWidget{
  static void show(BuildContext context, {int coinCount = 0}){

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
                  padding: const EdgeInsets.only(top: 15, bottom: 25),
                  alignment: Alignment.center,
                  child: Text("The miner keeps working for you",style: TextStyle(color:  COLOR_F0E890 , fontSize: 18, fontWeight: FontWeight.bold),),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width:  115,
                    height: 115,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: COLOR_251D14,
                    ),
                    child: Image.asset("assets/booster/boost_miner.png", alignment: Alignment.center, width: 115, height: 115,),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 34, bottom: 43),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/mining/mining_coin_icon.png", width: 40, height: 40,),
                        const SizedBox(width: 15,),
                        GlowText(text: TPCommon.formatNumberWithSpaces("$coinCount", sign:","),
                          color: COLOR_FFFEF3,
                          shadowColor: COLOR_FFEB7C,
                          fontSize: 30,
                          strokeWidthText: 1,
                          blurRadius: 15,
                          letterSpacing: 3,
                          backgroundColor: COLOR_FFFEF3,
                        )
                      ],
                    ),
                ),
                Align(
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
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                                BoostController.startOfflineReward(finish: (isSuccess){
                                  if(isSuccess){
                                    BoostController.refreshOfflineRewards(isActivie: true);
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
                                child: Text("Get it !", style: TextStyle(color: COLOR_684414, fontWeight: FontWeight.bold, fontSize: 25),),
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

