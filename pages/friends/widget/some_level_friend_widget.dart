import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:native_scroll/native_scroll.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tapmine/pages/friends/controller/friends_controller.dart';
import 'package:tapmine/pages/friends/widget/item/friend_item_widget.dart';

import '../model/friend_info_item_model.dart';




class SomeLevelFriendWidget extends StatefulWidget {
  SomeLevelFriendWidget({super.key ,this.type = FriendInfoType.none});

  FriendInfoType type = FriendInfoType.none;

  List<FriendInfoItemModel>? items = [];

  @override
  State<SomeLevelFriendWidget> createState() => _SomeLevelFriendWidgetState();
}

class _SomeLevelFriendWidgetState extends State<SomeLevelFriendWidget> {
  final RefreshController _controller = RefreshController();

  void _onRefresh(){

  }

  Future<void> _onLoading() async {
    if(kDebugMode){
      print("_onLoading ----- !");
    }
    await Provider.of<FriendsController>(context, listen: false).refreshWith(widget.type);
    _controller.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return NativeScrollBuilder(
        builder: (BuildContext context, ScrollController scontroller){
          return SmartRefresher(
            controller: _controller,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            enablePullDown: false,
            enablePullUp: true,
            header:  const WaterDropHeader(),
            child: Consumer<FriendsController>(builder: (context, fController, child){
              if(kDebugMode){
                print("SomeLevelFriendWidget oneList Length: ${fController.oneList.length}");
                print("SomeLevelFriendWidget twoList Length: ${fController.twoList.length}");
              }
              return ListView.builder(
                  controller: scontroller,
                  itemCount: fController.currentListWith(widget.type).length,
                  scrollDirection: Axis.vertical,
                  itemExtent: 67,
                  itemBuilder: (context, index){
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        FriendItemWidget(item: (fController.currentListWith(widget.type))[index]),
                      ],
                    );
                  }
              );
            },),

          );
        }
    );

  }

  @override
  void didUpdateWidget(covariant SomeLevelFriendWidget oldWidget) {
    // TODO: implement didUpdateWidget
    //
    // if(oldWidget.items?.length  != widget.items?.length){
    //   setState(() {
    //     oldWidget.items = widget.items;
    //   });
    // }

    super.didUpdateWidget(oldWidget);

  }
}
