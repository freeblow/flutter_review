import 'package:flutter/material.dart';

class FloatingAnimationWidget extends StatefulWidget {
  final String imageAssetPath;

  FloatingAnimationWidget({required this.imageAssetPath});

  @override
  _FloatingAnimationWidgetState createState() => _FloatingAnimationWidgetState();
}

class _FloatingAnimationWidgetState extends State<FloatingAnimationWidget> with TickerProviderStateMixin {
  final Map<int, AnimationData> _animations = {};
  final LayerLink _layerLink = LayerLink();

  void _onPanDown(DragDownDetails details) {
    final int timestamp = DateTime.now().millisecondsSinceEpoch;

    final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    final Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 2), // Upward movement
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
        position: details.localPosition,
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
    return GestureDetector(
      onPanDown: _onPanDown,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          clipBehavior: Clip.none, // Allow overflow
          children: <Widget>[
            CompositedTransformTarget(
              link: _layerLink,
              child: Container(color: Colors.white),
            ),
            for (final animationData in _animations.values)
              AnimatedBuilder(
                animation: animationData.controller,
                builder: (context, child) {
                  return CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(
                      animationData.position.dx - 50,
                      animationData.position.dy - 50 + (animationData.offsetAnimation.value.dy * 100),
                    ),
                    child: Opacity(
                      opacity: 1,//animationData.opacityAnimation.value,
                      child: Transform.translate(
                        offset: Offset(0, animationData.offsetAnimation.value.dy * -300),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.imageAssetPath),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset:const Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
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