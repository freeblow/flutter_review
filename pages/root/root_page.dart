import 'package:flutter/material.dart';
import 'package:route_animation_helper/route_animation_helper.dart';
import 'package:tapmine/common/const/url.dart';
import 'package:tapmine/common/tabbar/custom_tabbar.dart';
import 'package:tapmine/pages/boost/boost_page.dart';
import 'package:tapmine/pages/mining/provider/user_info_provider.dart';
import 'package:tapmine/pages/mining/widget/tm_energy_recharge_operation.dart';
import 'package:tapmine/pages/root/controller/root_controller.dart';
import 'package:tapmine/pages/root/provider/tab_index_provider.dart';
import 'package:tapmine/pages/root/provider/trace_log_provider.dart';
import 'package:tapmine/pages/root/widget/active_loading_widget.dart';
import 'package:tapmine/pages/root/widget/invited_new_user_reward_page.dart';
import 'package:tapmine/pages/task/controller/task_controller.dart';
import 'package:tapmine/pages/task/task_page.dart';

import '../../common/const/color.dart';
import '../../common/log/trace_log_widget.dart';
import '../../common/tabbar/tab_item.dart';
import '../../websocket/pipeline/tp_pipeline_task.dart';
import '../../websocket/tp_socket_task.dart';
import '../friends/controller/friends_controller.dart';
import '../friends/friends_page.dart';
import '../mining/mining_page.dart';
import 'package:provider/provider.dart';

import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;


class RootPage extends StatefulWidget {
  const RootPage({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>  with TickerProviderStateMixin {

  int _currentIndex = 0;

  late TabController _tabController;
  late RootController _controller;


  List<Widget> get widgets {
    return [const MiningPage(),  const BoostPage(), const TaskPage(),const FriendsPage()];
  }

  final List<Key> _keys = [
    UniqueKey(),
    UniqueKey(),
    UniqueKey(),
    UniqueKey(),
  ];

  @override
  void initState() {
    // TODO: implement initState

    tg.onEvent("web_app_close",tg.JsVoidCallback(() {
      RootController.offline();
    }));

   _tabController  = TabController(length: 4, vsync: this);
   _controller = RootController();
   _controller.setHeaderColor();

    _controller.login(finish: (isNew, parentName){
      if(!isNew)return;
      Navigator.of(context).push(RouteAnimationHelper.createRoute(
        // current page is mandatory only if you are using cubic animation.
          buildContext: context,
          currentPage: this.widget,
          destination: InvitedNewUserRewardPage(name: parentName,),
          animType: AnimType.slideBottom,
          duration: 300)
      );
    });

    super.initState();
    TMEnergyRechargeOperation.instance.startRechargeEnergy();

    TPPipelineTask.instance.startTap();

    // addDebugLogInfo();

  }

  void addDebugLogInfo(){
    if(RootPage.navigatorKey.currentContext == null) return;
    TraceLogProvider traceLogC = Provider.of<TraceLogProvider>(RootPage.navigatorKey.currentContext!, listen: false);
    traceLogC.addMsgLog("User Full Name: ${_controller.webAppInitData.user?.first_name}  ${_controller.webAppInitData.user?.last_name}");
    traceLogC.addMsgLog("User username: ${_controller.webAppInitData.user?.username} ");
    traceLogC.addMsgLog("User photo_url: ${_controller.webAppInitData.user?.photo_url} ");
    traceLogC.addMsgLog("User language_code: ${_controller.webAppInitData.user?.language_code} ");
    traceLogC.addMsgLog("User Start Params: ${_controller.webAppInitData.start_param} ");
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: RootPage.navigatorKey,
      color: COLOR_4A4F31,
      home: Material(
        child: homeWidget(),
      ),

    );
  }

  Widget homeWidget(){
    return mainWidget();

  }

  Widget mainWidget(){
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: COLOR_4A4F31,
          child: Stack(
            children: [
              Consumer<TabIndexNotifier>(
                  builder: (context, tabIndexNotifier, child){
                    _tabController.index = tabIndexNotifier.currentIndex;
                    return IndexedStack(
                      index: tabIndexNotifier.currentIndex,
                      children: widgets.asMap().entries.map((entry) {
                        return KeyedSubtree(
                          key: _keys[entry.key],
                          child: entry.value,
                        );
                      }).toList(),

                    );
                  }
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Consumer<TabIndexNotifier>(builder: (BuildContext context, TabIndexNotifier value, Widget? child) {
                    return CustomTabbar(
                      height: 78,
                      controller: _tabController,
                      tabs: items,
                      selectedTabs: selectedItems,
                      itemInterval: 10,
                      currentIndex: value.currentIndex,
                      onTap: (index){
                        if(index == 0){

                        }
                        if(index == 1){
                          // UserManager.instance.reqUserInfo().whenComplete((){
                          //   Provider.of<UserInfoProvider>(context, listen: false).setModel(UserManager.instance.user);
                          //
                          // });
                        }
                        if(index == 2){
                          Provider.of<TaskController>(context, listen: false).refreshTaskStatus();
                          // UserManager.instance.reqUserInfo().whenComplete((){
                          //   Provider.of<UserInfoProvider>(context, listen: false).setModel(UserManager.instance.user);
                          //
                          // });
                        }

                        if(index == 3){
                          Provider.of<FriendsController>(context, listen: false).refreshData();
                          // UserManager.instance.reqUserInfo().whenComplete((){
                          //   Provider.of<UserInfoProvider>(context, listen: false).setModel(UserManager.instance.user);
                          // });
                        }
                        value.setIndex(index);
                      },
                    );
                  },),

                ),

              )
            ],
          ),
        ),

        if(TMURLs.isDebugMode)  Container(
          alignment: Alignment.topLeft,
          child:  TraceLogWidget(),
        )

      ],
    );
  }

  Widget itemSingleWidget(String assetsName, String title, Size iconSize){

    return Container(
        width: 61,
        height: 78,
        alignment: Alignment.center,
        child:  Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 54,
              height: 68,
              decoration: BoxDecoration(
                color: COLOR_FFCA49,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(assetsName, width: iconSize.width, height: iconSize.height),
                  Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: COLOR_FFFCF0),),
                  const SizedBox(height: 6,),
                ],
              ),
            ),
            Image.asset("assets/root/bottom_tab_item_bg.png",width: 61,height: 78,)
          ],
        ),
    );

  }

  Widget itemWidget(String assetsName, String title, Size iconSize, bool isSelected){
    if(isSelected){
      return itemSingleWidget(assetsName, title, iconSize);
    }else{
      return Container(
        width: 61,
        height: 78,
        child: Stack(
          alignment: Alignment.center,
          children: [
            itemSingleWidget(assetsName, title, iconSize),
            SizedBox(
              width: 56,
              height: 68,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    border: Border.all(
                        width: 0.0
                    ),
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

    }

  }

  List<Widget> get selectedItems{
    return tabs.map((item)=>itemWidget(item.iconName!, item.title!, item!.iconSize, true)).toList() as List<Widget>;

  }

  List<Widget> get items {
    return tabs.map((item)=>itemWidget(item.iconName!, item.title!, item!.iconSize, false)).toList() as List<Widget>;
  }

  List<TabItem> get tabs{
    return [
      TabItem(
        iconName: "assets/root/tab_selected_mining_icon.png",
        title: "Mine",
          iconSize:const Size(39,39)
      ),
      TabItem(
          iconName: "assets/root/tab_selected_boost_icon.png",
          title: "Boost",
          iconSize: const Size(39,39)
      ),
      TabItem(
          iconName: "assets/root/tab_selected_task_icon.png",
          title: "Task",
          iconSize: const Size(39,39)
      ),
      TabItem(
          iconName: "assets/root/tab_selected_friends_icon.png",
          title: "Friends",
          iconSize: const Size(39,39)
      ),
    ];
  }


  @override
  void dispose() {
    // TODO: implement dispose
    TPSocketTask.instance.closeSocket();
    TMEnergyRechargeOperation.instance.stopTimer();
    RootController.offline();
    super.dispose();
  }
}
