import 'package:flutter/material.dart';
import 'package:tapmine/common/const/color.dart';
import 'package:tapmine/pages/boost/controller/boost_controller.dart';
import 'package:tapmine/pages/boost/model/boost_task_item_model.dart';

import '../../../common/utils/glow_text.dart';
import '../../../common/utils/tp_common.dart';

class BoostTaskItemWidget extends StatefulWidget {
  BoostTaskItemWidget({super.key, required this.item});
   late BoostTaskItemModel item;

  @override
  State<BoostTaskItemWidget> createState() => _BoostTaskItemWidgetState();
}

class _BoostTaskItemWidgetState extends State<BoostTaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 312,
        height: 66,
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
              margin: const EdgeInsets.only(left: 17),
              height: 50,
              width: 45,
              child: Stack(
                children: [
                  Align(
                    alignment: widget.item.type == BoosterTaskType.working? Alignment.center:Alignment.topCenter,
                    child: Container(
                      width: 43,
                      height: 43,
                      alignment: widget.item.type == BoosterTaskType.working? Alignment.center:Alignment.topCenter,
                      child: Image.asset(widget.item.icon, width: 43, height: 43,),
                    ),
                  ),
                  widget.item.type == BoosterTaskType.working? SizedBox.shrink():
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          height: 14,
                          width: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: COLOR_E8B029,
                          ),
                          child: Text("Lv.${widget.item.level}", style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.item.title, style: TextStyle(fontSize: 12, color: COLOR_B9B48E, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 7,),
                  titleBottomObject(widget.item.isFinish)
                ],
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset("assets/booster/booster_task_item_right_arrow_icon.png", width: 13,height: 15,),
            )
          ],
        ),

      ),
    );
  }
  
  Widget titleBottomObject(bool isMax){
    if(isMax){
      // return Text((widget.item.type != BoosterTaskType.working)?"MAX" : "Working", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: COLOR_BEFF4C),);
      return GlowText(text: (widget.item.type != BoosterTaskType.working)?"MAX" : "Working",
        color: COLOR_FFFEF3,
        shadowColor: COLOR_FFEB7C,
        fontSize: 19,
        strokeWidthText: 1,
        blurRadius: 8,
        letterSpacing: 1,
        backgroundColor: COLOR_FFFEF3,
      );
    }

    if(widget.item.type != BoosterTaskType.working) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/mining/mining_coin_icon.png", width: 17, height: 17,),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(TPCommon.formatNumberWithSpaces("${widget.item.upgradeLevelNeedCoins}", sign:","), style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: COLOR_EFD171),),
          ),

          Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Image.asset(
                "assets/booster/booster_task_item_right_double_arrow_icon.png",
                width: 21, height: 14,)
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("Lv.${widget.item.level + 1}", style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.bold,
                color: COLOR_FFF074),),
          ),

        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/mining/mining_coin_icon.png", width: 17, height: 17,),
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Text(TPCommon.formatNumberWithSpaces("${widget.item.upgradeLevelNeedCoins}"), style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: COLOR_EFD171),),
        ),
      ],
    );


    
  }
}
