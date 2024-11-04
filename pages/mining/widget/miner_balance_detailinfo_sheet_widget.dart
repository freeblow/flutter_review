import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/common/user/user_manager.dart';
import 'package:tapmine/common/utils/tp_common.dart';
import 'package:tapmine/pages/boost/widget/boost_task_sheet_panel_widget.dart';
import 'package:tapmine/pages/mining/provider/user_info_provider.dart';

import '../../../common/const/color.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

import '../../../common/const/key.dart';
import '../../../common/utils/glow_text.dart';

class MinerBalanceDetailinfoSheetWidget{
  static void show(BuildContext context){
    final bottomSheetContext = context;

    showModalBottomSheet(
        context: bottomSheetContext,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (BuildContext context){

          return Consumer<UserInfoProvider>(builder: (context, userInfoP, child){
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
                    height: 41,
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
                    padding: const EdgeInsets.only(top: 2, bottom: 18),
                    alignment: Alignment.center,
                    child: Text("Current ores",style: TextStyle(color:  COLOR_F0E890 , fontSize: 30, fontWeight: FontWeight.bold),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/mining/mining_coin_icon.png", width: 40, height: 40,),
                        const SizedBox(width: 15,),
                        // Text(TPCommon.formatOperateNumber("${userInfoP.userinfo.tokenBalance}"),style: TextStyle(color: COLOR_F1D272, fontSize: 30, fontWeight: FontWeight.bold),),
                        GlowText(text: TPCommon.formatNumberWithSpaces("${userInfoP.userinfo.tokenBalance}", sign:","),
                          color: COLOR_FFFEF3,
                          shadowColor: COLOR_FFEB7C,
                          fontSize: 30,
                          strokeWidthText: 1,
                          blurRadius: 12,
                          letterSpacing: 3,
                          backgroundColor: COLOR_FFFEF3,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("*Current ores is calculated by subtracting\nthe consumption from All-time ares", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: COLOR_938A56, fontWeight: FontWeight.bold),),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 26, bottom: 12),
                      child:Container(
                        width: 314,
                        height: 63,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("All-time ores",style: TextStyle(color: COLOR_AEAEAE, fontWeight: FontWeight.bold, fontSize: 15),),
                            Text(TPCommon.formatOperateNumber("${userInfoP.userinfo.totalToken}"),style: TextStyle(color: COLOR_F1D272, fontWeight: FontWeight.bold, fontSize: 22),)
                          ],
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 15),
                      child:SizedBox(
                        width: 314,
                        height: 73,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Container(
                              height: 63,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.black.withOpacity(0.3),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Earn by yourself",style: TextStyle(color: COLOR_AEAEAE, fontWeight: FontWeight.bold, fontSize: 15),),
                                  Text(TPCommon.formatOperateNumber("${userInfoP.userinfo.totalToken - userInfoP.userinfo.inviteRefReward}"),style: TextStyle(color: COLOR_F1D272, fontWeight: FontWeight.bold, fontSize: 22),)
                                ],
                              ),
                            )),
                            const SizedBox(width: 8,),
                            Expanded(child: Container(
                              height: 63,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.black.withOpacity(0.3),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Earn from refs",style: TextStyle(color: COLOR_AEAEAE, fontWeight: FontWeight.bold, fontSize: 15),),
                                  Text(TPCommon.formatOperateNumber("${userInfoP.userinfo.inviteRefReward}"),style: TextStyle(color: COLOR_F1D272, fontWeight: FontWeight.bold, fontSize: 22),)
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
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
                                  tg.openTelegramLink("https://t.me/share/url?url=${UserManager.instance.inviteUrl}&text=$FRIEND_INVITE_TEXT");
                                },
                                child: Container(
                                  height: 64.5,
                                  width: 311,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    color: COLOR_EDC216,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("Invite a friend", style: TextStyle(color: COLOR_684414, fontWeight: FontWeight.bold, fontSize: 25),),
                                      const SizedBox(width: 10,),
                                      Image.asset("assets/friend/friend_invite_icon.png", width: 37, height: 31,)
                                    ],
                                  ),
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
          },);
        });
  }
}

