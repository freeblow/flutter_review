import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/pages/root/provider/trace_log_provider.dart';

import '../../pages/root/root_page.dart';
import '../const/url.dart';

class TraceLogWidget extends StatefulWidget {

  @override
  _TraceLogWidgetState createState() => _TraceLogWidgetState();


  static void addLog(String msg){
    if(TMURLs.isDebugMode){
      TraceLogProvider traceLogC = Provider.of<TraceLogProvider>(RootPage.navigatorKey.currentContext!, listen: false);
      traceLogC.addMsgLog(msg);
    }

  }
}

class _TraceLogWidgetState extends State<TraceLogWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Consumer<TraceLogProvider>(builder: (context, controller, child){
        return SingleChildScrollView(
          child: Text(
            controller.msgListLog.join('\n'),
            style: const TextStyle(fontSize: 12.0, color: Colors.white),
          ),
        );
      },),
    );
  }
}