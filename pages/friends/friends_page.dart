import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/common/user/user_manager.dart';
import 'package:tapmine/pages/friends/model/friend_info_item_model.dart';
import 'package:tapmine/pages/friends/widget/friend_tips_sheet_widget.dart';
import 'package:tapmine/pages/friends/widget/some_level_friend_widget.dart';

import '../../common/const/color.dart';
import '../../common/const/key.dart';
import '../../common/const/url.dart';
import '../../common/utils/tm_custom_button_bg.dart';
import '../boost/widget/boost_task_sheet_panel_widget.dart';
import '../root/root_page.dart';
import '../task/widget/stroke_font.dart';
import 'controller/friends_controller.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

class FriendsPage extends StatefulWidget {
    const FriendsPage({super.key});
  
    @override
    State<FriendsPage> createState() => _FriendsPageState();
  }

  class _FriendsPageState extends State<FriendsPage> with SingleTickerProviderStateMixin {

    final CustomSegmentedController<int> _segmentedController = CustomSegmentedController();

    final FriendsController _controller   = Provider.of<FriendsController>(RootPage.navigatorKey.currentContext!);

    late TabController _tabController;

    @override
    void initState() {

      _tabController = TabController(length: 2, vsync: this);

      // TODO: implement initState
      _segmentedController.value = 1;
      _segmentedController.addListener((){
      });


      _tabController.animation?.addListener(() {
        final index = _tabController.animation!.value.round();
        if((index - _tabController.animation!.value).abs() < 0.00001){
          _segmentedController.value = index + 1;
        }

      });

      super.initState();

      _controller.refreshData();

    }

    @override
    Widget build(BuildContext context) {
      return  Consumer<FriendsController>(
          builder: (context, fProvider, child){
            return Container(
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
                    padding: const EdgeInsets.only(top: 43),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Invite your friends and earn \n more  bonuses together!",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(fontSize: 19,
                          color: COLOR_F0E890,
                          fontWeight: FontWeight.bold,),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Container(),),
                        Align(
                          alignment: Alignment.center,
                          child: Text("Fabulous rewards are ready \nfor you and your friends.",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(fontSize: 14,
                              color: COLOR_938A56,
                              fontWeight: FontWeight.w400,),),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: (){
                                //tips
                                FriendTipsSheetWidget.showTips(context);
                              },
                              child: Image.asset("assets/friend/friend_tips_info.png", width: 42 * 0.55, height: 45 * 0.55,),
                            ),
                          ),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 18,bottom: 20),
                    width: 312,
                    height: 1.0,
                    color: COLOR_776F17,
                  ),

                  Align(
                      alignment: Alignment.topCenter,
                      child:Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 7),
                        width: 312,
                        child: Consumer<FriendsController>(
                          builder: (context, vcProvider, child){
                            return Text("My Referrals(${vcProvider.myReferrals}):", style: TextStyle(fontSize: 16, color: COLOR_E6DEA6, fontWeight: FontWeight.bold),);
                          },
                        ),
                      )

                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 320,
                    height: 55,
                    child: CustomSlidingSegmentedControl<int>(
                      fromMax: true,
                      controller: _segmentedController,
                      initialValue: 1,
                      padding: 40,
                      height: 55,
                      innerPadding: const EdgeInsets.all(0),
                      children: {
                        1: (_segmentedController.value == 1)? StrokeFont.renderFont(
                            'Tier-1 (${fProvider.oneLevelRatio}%)', 14,
                            strokeColor: Colors.white,
                            fillColor:COLOR_A26300,
                            strokeWidth: 2
                        ) : Text(
                          'Tier-1 (${fProvider.oneLevelRatio}%)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: COLOR_817E65),
                        ),
                        2: (_segmentedController.value == 2)? StrokeFont.renderFont(
                            'Tier-2 (${fProvider.twoLevelRatio}%)', 14,
                            strokeColor: Colors.white,
                            fillColor:COLOR_A26300,
                            strokeWidth: 2
                        ) : Text(
                          'Tier-2 (${fProvider.twoLevelRatio}%)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: COLOR_817E65),
                        ),
                      },
                      decoration: BoxDecoration(
                        color: COLOR_1E1810,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      thumbDecoration: BoxDecoration(
                        color: COLOR_E8CF29,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      onValueChanged: (int value) {
                        setState(() {
                          // _segmentedController.value = value;

                        });
                        _tabController.index = value - 1;
                      },
                    ),


                  ),

                  if( fProvider.oneList.isNotEmpty)
                    ...[Container(
                      margin: const EdgeInsets.only(top: 10,bottom: 0),
                      width: 320,
                      height: 34,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Info", style: TextStyle(color: COLOR_FFFBCF, fontSize: 12, fontWeight: FontWeight.bold),),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text("Your Rewards", style: TextStyle(color: COLOR_FFFBCF, fontSize: 12, fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: Image.asset("assets/mining/mining_coin_icon.png", width: 17, height: 17,),
                          ),
                        ],
                      ),
                    ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              margin:const EdgeInsets.only(top: 3, bottom: 88+65),
                              width: 320,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SomeLevelFriendWidget(type: FriendInfoType.one,),
                                  SomeLevelFriendWidget(type: FriendInfoType.two,),
                                ],
                              ),
                            ),
                            bottomInvitePanel(),

                          ],
                        ),
                      )]
                  else
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 40),
                              alignment: Alignment.topCenter,
                              child: Text("You don't have referrals.", textAlign: TextAlign.center,style: TextStyle(fontSize: 14, color: COLOR_FFFBCF, fontWeight: FontWeight.bold),),
                            ),
                            const Spacer(),
                            bottomInvitePanel(),
                          ],
                        )
                    )
                ],
              ),
            );
          });

    }


    Widget bottomInvitePanel(){
      return Container(
        margin: EdgeInsets.only(bottom: 88 + 3),
        width: 320,
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TMCustomButtonBg(
              size: const Size(235,58),
              cornerRadius: 5,
              offset: const Offset(1.5, 3),
              onTap: (){
                tg.openTelegramLink("https://t.me/share/url?url=${UserManager.instance.inviteUrl}&text=$FRIEND_INVITE_TEXT");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Invite a friend", style: TextStyle(fontSize: 20, color: COLOR_684414, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Image.asset("assets/friend/friend_invite_icon.png", width: 37, height: 31,),
                  )
                ],
              ),
            ),
            const Spacer(),
            TMCustomButtonBg(
              size: const Size(70,58),
              cornerRadius: 5,
              offset: const Offset(1, 2.5),
              onTap: (){
                Clipboard.setData(ClipboardData(text: '${UserManager.instance.inviteUrl}\n$FRIEND_COPY_TEXT'));
                BoostTaskSheetPanelWidget.showAlert(context, title:"Message copied", clickAction: (){

                });
              },
              child: Image.asset("assets/friend/friend_copy_icon.png", width: 30, height: 31,),
            ),
          ],
        ),
      );
    }
  }