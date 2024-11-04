import 'package:flutter/material.dart';

class TaskRefProgressWidget extends StatelessWidget {
  TaskRefProgressWidget({super.key, this.progress = 0, this.width = 0 ,this.height = 0, this.borderWidth = 0 });

  double progress = 0;

  double width;
  double height;

  double borderWidth = 0;

  @override
  Widget build(BuildContext context) {
    double minProgress = (height - 2 * borderWidth) /(width - 2 * borderWidth);
    if(progress > 0 && progress <= minProgress){
      progress = minProgress;
    }

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/mining/widget_progress_bg.png"
              ),
              centerSlice: Rect.fromLTRB(25, 5,30, 10),
              fit: BoxFit.fill,
              scale: 2,
          )
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular((height - 2 * borderWidth) / 2),
          child: Container(
            width: (width - 2 * borderWidth) * progress,  // Adjust width based on progress
            height: (height - 2 * borderWidth),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/mining/widget_progress_inner_value.png"),
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
