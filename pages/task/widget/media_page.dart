import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/pages/root/root_page.dart';
import 'package:tapmine/pages/task/controller/task_media_controller.dart';
import 'package:tapmine/pages/task/widget/component/task_sheet_widget.dart';
import 'package:tapmine/pages/task/widget/item/media_item_widget.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  final TaskMediaController _controller  = Provider.of<TaskMediaController>(RootPage.navigatorKey.currentContext!);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer(const Duration(milliseconds: 500),(){
      _controller.refreshMediaTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskMediaController>(builder: (context, mController, child){
      return ListView.builder(
            itemCount: mController.socialMedias.length,
          itemBuilder: (context, index){
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    TaskSheetWidget.showMediaSubcribe(context, mController.socialMedias[index]);
                  },
                  child: MediaItemWidget(
                    item: mController.socialMedias[index],
                  ),
                ),
                const SizedBox(height: 10,)
              ],
            );
          });
    });
  }
}
