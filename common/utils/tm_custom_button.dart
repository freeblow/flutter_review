import 'package:flutter/material.dart';

import '../const/color.dart';

class TMCustomButton extends StatelessWidget {
  TMCustomButton({super.key, this.onTap, this.size = Size.zero, this.offset = Offset.zero, this.cornerRadius = 0, this.title = "", this.titleStyle});

   Function? onTap;
  late Size size;
  Offset offset = Offset.zero;
  double cornerRadius = 0;
  String title = "";
  TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child:  Opacity(
              opacity: 0.2,
              child: Container(
                height: size.height - offset.dy,
                width: size.width - offset.dx,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
                    color: Colors.black
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: (){
                // Navigator.of(context).pop();
                if(onTap != null){
                  onTap!();
                }
              },
              child: Container(
                height: size.height - offset.dy,
                width: size.width - offset.dx,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
                  color: COLOR_EDC216,
                ),
                child: Text(title, style: titleStyle,),
              ),
            ),
          ),

        ],
      ),

    );
  }
}
