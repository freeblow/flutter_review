import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_marquee/widget_marquee.dart';

import '../../../common/const/color.dart';
import '../../../common/utils/tm_event_bus_manager.dart';
import '../../root/provider/tab_index_provider.dart';
import '../../root/root_page.dart';

class MiningTopMarqueeWidget extends StatefulWidget {
  const MiningTopMarqueeWidget({super.key});

  @override
  State<MiningTopMarqueeWidget> createState() => _MiningTopMarqueeWidgetState();
}

class _MiningTopMarqueeWidgetState extends State<MiningTopMarqueeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Provider.of<TabIndexNotifier>(RootPage.navigatorKey.currentContext!, listen: false).setIndex(2);
        TMEventBusManager.eventBus.fire(TMEventBusManager.TMEventName_TabTaskRef);
      },
      child: Container(
        width: 304,
        height: 28,
        padding:const EdgeInsets.only(left: 6, right: 6),
        decoration:BoxDecoration(
            color:Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/mining/mining_notice_icon.png",width: 16,height: 14,),
            const SizedBox(width: 4,),
            Expanded(child: Marquee(
              key: const ValueKey('mining_marquee_key'),
              delay: const Duration(milliseconds: 000),
              duration: const Duration(milliseconds: 10000),
              pause: Duration.zero,
              child: Text(
                'Rewards for first 30 referrals run into 25000 ores apiece！All of you and your friends will get the rewards.',
                style: TextStyle(fontSize: 14,color: COLOR_E6E0B6, fontWeight: FontWeight.bold),
              ),
            )),
            const SizedBox(width: 4,),
            Image.asset("assets/friend/friend_tips_info.png",width: 21,height: 22.5,),

          ],
        ),
      ),
    );
  }
}
