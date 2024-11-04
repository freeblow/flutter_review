import 'dart:async';

import 'package:flutter/material.dart';

class CustomMultiTapEffectWidget extends StatefulWidget {
  @override
  _CustomMultiTapEffectWidgetState createState() => _CustomMultiTapEffectWidgetState();
}

class _CustomMultiTapEffectWidgetState extends State<CustomMultiTapEffectWidget> {
  List<Offset> _tapPositions = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          _tapPositions.add(details.localPosition);
        });

        // Remove the tap effect after a delay
        Timer(Duration(milliseconds: 500), () {
          setState(() {
            _tapPositions.remove(details.localPosition);
          });
        });
      },
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: TapEffectPainter(_tapPositions),
      ),
    );
  }
}

class TapEffectPainter extends CustomPainter {
  final List<Offset> tapPositions;
  final Image tapImage;

  TapEffectPainter(this.tapPositions)
      : tapImage = Image.asset('assets/tap_effect.png');

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final position in tapPositions) {
      // Draw the image at the tap position
      tapImage.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool _) {
          canvas.drawImage(info.image, position - Offset(info.image.width / 2, info.image.height / 2), paint);
        }),
      );
    }
  }

  @override
  bool shouldRepaint(TapEffectPainter oldDelegate) {
    return oldDelegate.tapPositions != tapPositions;
  }
}
