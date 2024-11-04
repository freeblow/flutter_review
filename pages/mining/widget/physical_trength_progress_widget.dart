import 'package:flutter/material.dart';

import '../../../common/const/color.dart';

class PhysicalTrengthProgressWidget extends StatefulWidget {
  PhysicalTrengthProgressWidget({this.progress = 0.0, super.key});

  double progress;

  @override
  State<PhysicalTrengthProgressWidget> createState() => _PhysicalTrengthProgressWidgetState();
}

class _PhysicalTrengthProgressWidgetState extends State<PhysicalTrengthProgressWidget> {
  @override
  Widget build(BuildContext context) {
    double minProgress = 17.0/315;

    double constrainedProgress = widget.progress.clamp(0.0, 1.0);
    if(minProgress >= constrainedProgress){
      constrainedProgress = minProgress;
    }

    return Container(
      width: 317+16,
      height: 33,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 317,
            height: 19,
            margin: const EdgeInsets.only(left: 8,right: 8),
            decoration: BoxDecoration(
              color: COLOR_334F50.withOpacity(0.2),
              borderRadius: BorderRadius.circular(9.5),
              border: Border.all(color: COLOR_714A29, width: 1.0),
            ),
          ),
          Container(
            // color: Colors.red,
            margin: const EdgeInsets.only(right: 9, left: 9,bottom: 1, top: 1),
            alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Image.asset(
                  "assets/mining/widget_progress_inner_value.png",
                  width: 315 * (constrainedProgress <=  minProgress ? 0: constrainedProgress),
                  height: 17,
                  fit: BoxFit.cover,

                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ),
          Positioned(
            left: 315 * (constrainedProgress <=  minProgress ? 0: (constrainedProgress - minProgress)) , // Center the circle over the progress
            child: Image.asset("assets/mining/widget_progress_header_lighting_point.png", width: 33, height: 33,),
          ),
        ],
      ),
    );
  }
}