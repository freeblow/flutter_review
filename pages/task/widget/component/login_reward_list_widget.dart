import 'package:flutter/material.dart';
import 'package:native_scroll/native_scroll.dart';

import '../../model/daily_login_reward_item_model.dart';
import '../item/daily_login_reward_item_widget.dart';

class LoginRewardListWidget extends StatefulWidget {
   LoginRewardListWidget({super.key, this.items});

  List<DailyLoginRewardItemModel>? items;

  @override
  State<LoginRewardListWidget> createState() => _LoginRewardListWidgetState();
}

class _LoginRewardListWidgetState extends State<LoginRewardListWidget> {


  int _waitingClaimedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i = 0; i < (widget.items?.length ?? 0); i ++){
        if(widget.items![i].status == DailyLoginRewardItemStatus.waitingClaim){
          _waitingClaimedIndex = i;
          break;
        }
    }

    Future.delayed(const Duration(milliseconds: 200),(){
      _scrollController.jumpTo(_waitingClaimedIndex*77);
    });

  }


  @override
  Widget build(BuildContext context) {
    return NativeScrollBuilder(
      scrollController: _scrollController,
        builder: (BuildContext context , ScrollController controller){
          return ListView.builder(
              controller: controller,
              itemCount: (widget.items != null)?widget.items?.length : 0,
              itemBuilder: (context, index){
                return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    child: DailyLoginRewardItemWidget(item:  widget.items![index],),
                );
              }
          );
        });
  }
}
