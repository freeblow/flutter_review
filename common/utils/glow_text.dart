import 'package:flutter/material.dart';

class GlowText extends StatefulWidget {
  const GlowText(
      {super.key,required this.text,required this.color,this.font, this.fontSize,
        this.backgroundColor,
        this.alpha,
        this.strokeWidthText,
        this.letterSpacing,
        this.blurRadius, this.textStyle, this.textAlign, this.shadowColor});

  final String text;
  final Color color;
  final Color? shadowColor;
  final String? font;
  final double? fontSize;
  final double? blurRadius;
  final int? alpha;
  final double? letterSpacing;
  final double? strokeWidthText;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final TextAlign? textAlign;


  @override
  State<GlowText> createState() => _GlowTextState();
}

class _GlowTextState extends State<GlowText> {

  String get text => widget.text;
  Color get color => widget.color;
  TextStyle? get textStyle => widget.textStyle;


  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          // Text(text,
          //     textAlign: widget.textAlign ?? TextAlign.left,
          //     style: TextStyle(
          //         fontFamily: (_font()),
          //         fontSize: _fontSize(),
          //         fontWeight: FontWeight.bold,
          //         letterSpacing: widget.letterSpacing ?? 1,
          //         foreground: Paint()
          //           ..style = PaintingStyle.stroke
          //           ..strokeWidth = _strokeWidthTextLow()
          //           ..color = color,
          //         shadows: _getShadows(_blurRadius()))),
          // (widget.backgroundColor == null) ? const SizedBox(
          //   width: 0, height: 0,) :
          Text(text,
              textAlign: widget.textAlign ?? TextAlign.left,
              style: textStyle != null
                  ? textStyle!.copyWith()
                  : TextStyle(
                  fontFamily: (_font()),
                  color: color,
                  fontSize: _fontSize(),
                  fontWeight: FontWeight.bold,
                  letterSpacing: widget.letterSpacing ?? 1,
                  shadows: _getShadows(_blurRadius()))
          ),
        ]
    );
  }


  /// check data add
  Color _backgroundColor(){
    return (widget.backgroundColor == null) ? Colors.black : widget.backgroundColor!;
  }
  int _alpha(){
    return (widget.alpha == null) ? 150 : widget.alpha!;
  }

  double _strokeWidthTextLow(){
    return (widget.strokeWidthText == null) ? 1 : widget.strokeWidthText!;
  }

  String _font(){
    return (widget.font == null) ? "" : widget.font!;
  }
  double _fontSize(){
    return (widget.fontSize == null) ? 30 : widget.fontSize!;
  }
  double _blurRadius(){
    return (widget.blurRadius == null) ? 30 : widget.blurRadius!;
  }

  Color _shadowColor(){
    return (widget.shadowColor == null) ? color : widget.shadowColor!;
  }


  List<Shadow> _getShadows(double radius) {
    return [
      Shadow(color: _shadowColor(), blurRadius: radius / 2),
      Shadow(color: _shadowColor(), blurRadius: radius),
      Shadow(color: _shadowColor(), blurRadius: radius * 3),
    ];
  }


}
