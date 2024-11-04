import 'package:flutter/material.dart';

import '../../../../common/const/color.dart';
import '../../../../common/utils/tp_common.dart';
import '../../model/friend_info_item_model.dart';
import '../../../../common/utils/net_work_image.dart';

class FriendItemWidget extends StatelessWidget {
  FriendItemWidget({super.key,  required this.item});
  late FriendInfoItemModel item;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        height: 57,
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
              width:  41,
              height: 41,
              margin: const EdgeInsets.only(left: 12),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: COLOR_544F11,
              ),
              child: item.icon.startsWith("https")? TMNetworkImage(
                url: item.icon,
                placeholder: Image.asset("assets/friend/friend_customer_head_icon.png", alignment: Alignment.center, width: 41, height: 41,),
                error: Image.asset("assets/friend/friend_customer_head_icon.png", alignment: Alignment.center, width: 41, height: 41,),
              ):Image.asset("assets/friend/friend_customer_head_icon.png", alignment: Alignment.center, width: 41, height: 41,),
            ),
            Padding(
              padding:const EdgeInsets.only(left: 7),
              child: Text(item.username ?? "", style: TextStyle(fontSize: 12, color: COLOR_FFFBCF, fontWeight: FontWeight.bold),),
            ),
            const Expanded(child: SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Text(TPCommon.formatNumberWithSpaces(item.coinCount ?? "0"), style: TextStyle(fontSize: 12, color: COLOR_EFD171, fontWeight: FontWeight.bold),),
            )
          ],
        ),

      ),
    );
  }
}
