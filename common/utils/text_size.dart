

import 'package:flutter/material.dart';

class TapMineTextSize{
  static double calculateTextWidth(String txt, TextStyle style){
    final text = txt;
    final textStyle = style;
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final size = textPainter.size;
    return size.width;
  }
}

