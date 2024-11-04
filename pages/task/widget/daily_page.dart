import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/pages/task/controller/task_daily_controller.dart';

import '../../root/root_page.dart';
import 'component/task_login_reward_sheet_widget.dart';
import 'item/daily_item_widget.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  final TaskDailyController _controller  = Provider.of<TaskDailyController>(RootPage.navigatorKey.currentContext!);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer(const Duration(milliseconds: 500),(){
      _controller.refreshDailyTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDailyController>(builder: (context, controller, child){
      return ListView.builder(
          itemCount: controller.dailyList.length,
          itemBuilder: (context, index){
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    TaskLoginRewardSheetWidget.showLoginReward(context,items:controller.dailyList[index].items);
                  },
                  child: DailyItemWidget(
                    item: controller.dailyList[index],
                  ),
                ),
                SizedBox(height: 10,)
              ],
            );
          });
    });
  }
}