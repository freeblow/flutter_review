import 'package:flutter/material.dart';
import 'package:tapmine/common/utils/tp_common.dart';

import '../../../../common/const/color.dart';
import '../../model/task_media_item_model.dart';

class MediaItemWidget extends StatelessWidget {
  MediaItemWidget({super.key,  required this.item});
  late TaskMediaItemModel item;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 312,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.black.withOpacity(0.3),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 12),
              height: 50,
              width: 50,
              alignment: Alignment.center,
              child: Image.asset(item.icon ?? "", width: 50, height: 50,),

            ),
            Padding(
              padding:const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item.title ?? "", style: TextStyle(fontSize: 12, color: COLOR_B9B48E, fontWeight: FontWeight.bold),),
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
                        child: Text(TPCommon.formatNumberWithSpaces(item.rewardCount ?? "0", sign:" "), style: TextStyle(
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
            if(item.isFollowing)
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset("assets/task/task_daily_item_finish_flag.png", width: 50*0.5, height: 48*0.5,),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset("assets/booster/booster_task_item_right_arrow_icon.png", width: 13,height: 15,),
              )
          ],
        ),

      ),
    );
  }
}
