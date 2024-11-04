import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spine_flutter/spine_flutter.dart';
import 'package:spine_flutter/spine_widget.dart';
import 'package:tapmine/common/user/user_manager.dart';
import 'package:tapmine/common/user/user_model.dart';
import 'package:tapmine/common/utils/glow_text.dart';
import 'package:tapmine/pages/mining/controller/mining_controller.dart';
import 'package:tapmine/pages/mining/provider/user_info_provider.dart';
import 'package:tapmine/pages/mining/widget/miner_balance_detailinfo_sheet_widget.dart';
import 'package:tapmine/pages/mining/widget/mineshine/flame_spine_mine_shine_foreground_widget.dart';
import 'package:tapmine/pages/mining/widget/mineshine/flame_spine_mine_shine_widget.dart';
import 'package:tapmine/pages/mining/widget/mining_top_marquee_widget.dart';
import 'package:tapmine/pages/mining/widget/physical_trength_progress_widget.dart';
import 'package:tapmine/pages/mining/widget/touch_animation_widget.dart';
import 'package:tapmine/websocket/pipeline/tp_pipeline_task.dart';

import '../../common/const/color.dart';
import '../../common/utils/mining_process_util.dart';
import '../../common/utils/tm_alert_dialog.dart';
import '../../common/utils/tm_custom_button.dart';
import '../../common/utils/tp_common.dart';
import '../boost/widget/boost_task_sheet_panel_widget.dart';
import '../root/root_page.dart';

class MiningPage extends StatefulWidget {
  const MiningPage({super.key});

  @override
  State<MiningPage> createState() => _MiningPageState();
}

class _MiningPageState extends State<MiningPage> {

  late MiningController _controller;

  bool _isAnimationLoadFinish = false;

  late SpineWidgetController _oreShakeController;

  late Future<SkeletonDrawable> _shakeDrawableFuture;

  Future<SkeletonDrawable> _loadSpineAnimation() async {
    return SkeletonDrawable.fromAsset("assets/mining/shake/shake.atlas", "assets/mining/shake/skeleton.skel");
  }


  @override
  void initState() {
    // TODO: implement initState
    _isAnimationLoadFinish = false;
    _shakeDrawableFuture = _loadSpineAnimation();

    _oreShakeController = SpineWidgetController(onInitialized: (SpineWidgetController controller){

      controller.animationState.clearTracks();
      controller.skeleton.setToSetupPose();
      controller.animationState.setListener((type, entry,event){
        if (kDebugMode) {
          print("_oreShakeController.animationState.setListener type = $type entry = $entry event = ${event.toString()}");
        }
      });

    });

    _controller = MiningController();
    _controller.totalPhysicalTrengthValue = UserManager.instance.physicalTrengthTotalValue;
    _controller.coinCount = UserManager.instance.pointsCount;

    super.initState();
  }

  void _startShakeAnimation(){
    _oreShakeController.pause();
    _oreShakeController.resume();
    _oreShakeController.animationState.setAnimationByName(0, "animation", false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_130D0B,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          UnconstrainedBox(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/mining/mining_main_bg.png",scale: 2.0,width: 360,height: 707,),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: MiningTopMarqueeWidget(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      MinerBalanceDetailinfoSheetWidget.show(RootPage.navigatorKey.currentContext!);
                      // BoostTaskSheetPanelWidget.showAlert(RootPage.navigatorKey.currentContext!,title: "Test !");
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                // backgroundColor: COLOR_FFFEF3,
                              );
                            }),
                        Container(
                          margin: const EdgeInsets.only(left: 4,),
                          padding: const EdgeInsets.only(top: 5,right: 8),
                          alignment: Alignment.topCenter,
                          child: Image.asset("assets/mining/mining_coin_info_icon.png",width: 13,height: 13,),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Container(
                width: 322,
                height: 300,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 300,
                        height: 300,
                        margin: const EdgeInsets.only(top:60),
                        alignment: Alignment.bottomCenter,
                        child: Consumer<UserInfoProvider>(builder: (build, ucontroller, child){
                          return (TPPipelineTask.instance.isSpeedy)?  const FlameSpineMineShineWidget() : SizedBox.shrink();
                        },),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 0, left: 0),
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 160,
                        height: 200,
                        child:  FutureBuilder<SkeletonDrawable>(
                          future: _shakeDrawableFuture,
                          builder: (BuildContext context, AsyncSnapshot<SkeletonDrawable> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return shakeHolderplace();// 显示预加载图像或动画
                            } else if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return shakeHolderplace();
                              } else {
                                _isAnimationLoadFinish = true;
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SpineWidget.fromDrawable(
                                        snapshot.data,
                                        _oreShakeController
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return shakeHolderplace();
                            }
                          },
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 300,
                        height: 300,
                        margin: const EdgeInsets.only(top:60),
                        alignment: Alignment.bottomCenter,
                        child: Consumer<UserInfoProvider>(builder: (build, ucontroller, child){
                          return (TPPipelineTask.instance.isSpeedy)?  const FlameSpineMineShineForegroundWidget() : SizedBox.shrink();
                        },),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 12,),

            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:Padding(
              padding: const EdgeInsets.only(bottom: 98),
              child: Consumer<UserInfoProvider>(
                  builder: (context, userinfoP, child){
                    return  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Image.asset("assets/booster/boost_full_energy.png", width: 40,height: 44),
                                onTap: (){

                                },
                              ),

                              const SizedBox(width: 2,),
                              Container(
                                alignment: Alignment.bottomCenter,
                                // color: Colors.red,
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Text.rich(
                                  textAlign: TextAlign.end,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:"${userinfoP.userinfo.energy}",
                                        style: TextStyle(fontSize: 18,color: COLOR_F1D272, fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:"/${userinfoP.userinfo.energyThreshold}",
                                        style: TextStyle(fontSize: 13,color: COLOR_F1D272, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 33,
                          width: 317+16,
                          child: PhysicalTrengthProgressWidget(
                            progress:userinfoP.userinfo.energy.toDouble()/userinfoP.userinfo.energyThreshold.toDouble(),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),

          Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 275,
                height: 320,
                padding:const EdgeInsets.only(top: 60),
                margin: const EdgeInsets.only(top: 125),
                child: TouchAnimationWidget(
                  isCouldAction: (){
                    UserModel mModel = Provider.of<UserInfoProvider>(context, listen: false).userinfo;
                    return UserManager.instance.isCouldMiningWith(mModel);
                  },
                  tapAction: (tapCount){
                    UserModel mModel = Provider.of<UserInfoProvider>(context, listen: false).userinfo;
                    if(!(UserManager.instance.isLogin && UserManager.instance.isCouldMiningWith(mModel))){
                      return;
                    }
                    MiningProcessUtil.instance.startMing();
                    if(_isAnimationLoadFinish){
                      _startShakeAnimation();
                    }

                    setState(() {
                      UserModel mModel = Provider.of<UserInfoProvider>(context, listen: false).userinfo;
                      if(!(TPPipelineTask.instance.isSpeedy) && mModel.energy >= TPPipelineTask.instance.unitPoints){
                        mModel.energy -= (TPPipelineTask.instance.unitPoints);
                        if(mModel.energy < 0){
                          mModel.energy = 0;
                        }
                      }
                      mModel.tokenBalance += TPPipelineTask.instance.unitPoints;
                      mModel.clickBalance += TPPipelineTask.instance.unitPoints;
                      mModel.totalToken += TPPipelineTask.instance.unitPoints;
                      Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!,  listen: false).setModel(mModel);
                      TPPipelineTask.instance.addTapEvent();
                    });
                  },),
              ))

        ],
      ),
    );
  }

  Widget shakeHolderplace(){
    return Container(
      // padding: const EdgeInsets.only(bottom: 30, left: 0),
      padding: const EdgeInsets.only(bottom: 0, left: 0),
      alignment: Alignment.bottomCenter,
      child: Image.asset("assets/mining/mining_ore_icon.png",width: 174,height: 213,),
    );
  }
}



