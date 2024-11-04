


import 'package:flutter/material.dart';
import '../../../common/const/color.dart';
import 'package:tapmine/websocket/pipeline/tp_pipeline_task.dart';

class TouchAnimationWidget extends StatefulWidget {
   TouchAnimationWidget({super.key, this.tapAction,this.isCouldAction});

   Function(int)? tapAction;
   bool Function()? isCouldAction;

  @override
  _TouchAnimationWidgetState createState() => _TouchAnimationWidgetState();
}

class _TouchAnimationWidgetState extends State<TouchAnimationWidget> with TickerProviderStateMixin {

  final Map<int, AnimationData> _animations = {};
  final LayerLink _layerLink = LayerLink();

  void _onPointerDown(PointerDownEvent event) {
    if(widget.isCouldAction != null && !(widget.isCouldAction!())){
      return;
    }

    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    if(widget.tapAction != null){
      widget.tapAction!(1);
    }

    final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    final Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 3), // Upward movement
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    final Animation<double> opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));

    setState(() {
      _animations[timestamp] = AnimationData(
        position: event.localPosition,
        controller: controller,
        offsetAnimation: offsetAnimation,
        opacityAnimation: opacityAnimation,
      );
    });

    controller.forward().then((_) {

      setState(() {
        _animations.remove(timestamp);
      });
    });
  }


  @override
  void dispose() {
    _animations.values.forEach((animationData) {
      animationData.controller.dispose();
    });
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Listener(
  onPointerDown: _onPointerDown,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          clipBehavior: Clip.none, // Allow overflow
          children: <Widget>[
            CompositedTransformTarget(
              link: _layerLink,
              // child: Container(color: Colors.white),
            ),
            for (final animationData in _animations.values)
              AnimatedBuilder(
                animation: animationData.controller,
                builder: (context, child) {
                  return Positioned(
                    left: animationData.position.dx - 20,
                    top: animationData.position.dy - 20 + (animationData.offsetAnimation.value.dy * 80),
                    child: Opacity(
                      opacity: animationData.opacityAnimation.value,
                      child: Transform.translate(
                        offset: Offset(0, animationData.offsetAnimation.value.dy * -160),
                        child: Text("+ ${TPPipelineTask.instance.unitPoints}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: COLOR_FFFEF3),),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      )

    );
  }
}

class AnimationData {
  final Offset position;
  final AnimationController controller;
  final Animation<Offset> offsetAnimation;
  final Animation<double> opacityAnimation;

  AnimationData({
    required this.position,
    required this.controller,
    required this.offsetAnimation,
    required this.opacityAnimation,
  });
}