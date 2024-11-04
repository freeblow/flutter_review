import 'dart:async';

import 'package:flutter/material.dart';
import 'package:native_scroll/native_scroll.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/pages/task/controller/task_ref_controller.dart';
import 'package:tapmine/pages/task/widget/item/ref_item_widget.dart';

import '../../root/root_page.dart';

class RefPage extends StatefulWidget {
  const RefPage({super.key});

  @override
  State<RefPage> createState() => _RefPageState();
}

class _RefPageState extends State<RefPage> {
  final TaskRefController _controller  = Provider.of<TaskRefController>(RootPage.navigatorKey.currentContext!);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer(const Duration(milliseconds: 500),(){
      _controller.refreshRRefTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskRefController>(builder: (context, rfcontroller, child){
      return NativeScrollBuilder(
          builder: (BuildContext context , ScrollController controller){
            return ListView.builder(
              controller: controller,
            itemCount: rfcontroller.refList.length,
            itemBuilder: (context, index){
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RefItemWidget(
                    item: rfcontroller.refList[index],
                  ),
                  const SizedBox(height: 10,)
                ],
              );
            });
          }
      );
    });
  }
}
