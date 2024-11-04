import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/pages/task/controller/task_controller.dart';
import 'package:tapmine/pages/task/widget/daily_page.dart';
import 'package:tapmine/pages/task/widget/media_page.dart';
import 'package:tapmine/pages/task/widget/ref_page.dart';
import 'package:tapmine/pages/task/widget/stroke_font.dart';

import '../../common/const/color.dart';
import '../../common/utils/glow_text.dart';
import '../../common/utils/tm_event_bus_manager.dart';
import '../../common/utils/tp_common.dart';
import '../mining/provider/user_info_provider.dart';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

import '../root/root_page.dart';


class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with SingleTickerProviderStateMixin {
  final TaskController _controller   = Provider.of<TaskController>(RootPage.navigatorKey.currentContext!);
  final CustomSegmentedController<int> _segmentedController = CustomSegmentedController();

  late TabController _tabController;

  @override
  void initState() {

    _tabController = TabController(length: 3, vsync: this);

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

    _controller.refreshTaskStatus();

    super.initState();

    TMEventBusManager.eventBus.on<String>().listen((event) {
      if(event == TMEventBusManager.TMEventName_TabTaskRef){
        _segmentedController.value = 3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 67),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/mining/mining_coin_icon.png", width: 50, height: 50,),
                  const SizedBox(width: 10,),
                  Consumer<UserInfoProvider>(
                      builder: (context, userinfoP, child) {
                        return GlowText(text: TPCommon.formatNumberWithSpaces("${userinfoP.userinfo.tokenBalance}", sign:","),
                          color: COLOR_FFFEF3,
                          shadowColor: COLOR_FFEB7C,
                          fontSize: 40,
                          strokeWidthText: 0,
                          blurRadius: 15,
                          letterSpacing: 3,
                          backgroundColor: COLOR_FFFEF3,
                        );
                      })
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40,bottom: 23),
            width: 312,
            height: 1.0,
            color: COLOR_776F17,
          ),
          Container(
            alignment: Alignment.center,
            width: 320,
            height: 55,
            child: CustomSlidingSegmentedControl<int>(
              fromMax: true,
              controller: _segmentedController,
              initialValue: 1,
              padding: 33,
              height: 55,
              innerPadding: const EdgeInsets.all(0),
              children: {
                1: (_segmentedController.value == 1)? StrokeFont.renderFont(
                    'Media', 14,
                    strokeColor: Colors.white,
                    fillColor:COLOR_A26300,
                    strokeWidth: 2
                ) : Text(
                  'Media',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: COLOR_817E65),
                ),
                2: (_segmentedController.value == 2)? StrokeFont.renderFont(
                    'Daily', 14,
                    strokeColor: Colors.white,
                    fillColor:COLOR_A26300,
                    strokeWidth: 2
                ) : Text(
                  'Daily',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: COLOR_817E65),
                ),
                3: (_segmentedController.value == 3)? StrokeFont.renderFont(
                    'Ref', 14,
                    strokeColor: Colors.white,
                    fillColor:COLOR_A26300,
                    strokeWidth: 2
                ) :Text(
                  "Ref",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: COLOR_817E65),
                )
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
          Expanded(
            child: Container(
              margin:const EdgeInsets.only(top: 13, bottom: 98),
              width: 312,

              child: TabBarView(
                controller: _tabController,
                children: [
                  MediaPage(),
                  DailyPage(),
                  RefPage()
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
