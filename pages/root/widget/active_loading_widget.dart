import 'package:flame/components.dart';
import 'package:flame_spine/flame_spine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spine_flutter/spine_flutter.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'dart:ui' as ui;

import '../../mining/widget/mineshine/custom_game_widget.dart';

class ActiveAppLoadingWidget extends StatefulWidget {
  const ActiveAppLoadingWidget({super.key});

  @override
  State<ActiveAppLoadingWidget> createState() => _ActiveAppLoadingWidgetState();
}

class _ActiveAppLoadingWidgetState extends State<ActiveAppLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomGameWidget.controlled(
      gameFactory: AppActiveAnimationSpineScene.new,
      backgroundBuilder: (BuildContext context){
        return Container(color: ui.Color(0x003E3121));
      },
    );
  }
}


class AppActiveAnimationSpineScene extends FlameGame with TapDetector {
  late final SpineComponent shine;


  @override
  Future<void> onLoad() async {
    // Load the Spineboy atlas and skeleton data from asset files
    // and create a SpineComponent from them, scaled down and
    // centered on the screen

    shine = await SpineComponent.fromAssets(
      atlasFile: 'assets/root/loading/skeleton.atlas',
      skeletonFile: 'assets/root/loading/skeleton.json',
      scale: Vector2(0.5,0.5),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
    );

    // Set the "walk" animation on track 0 in looping mode
    shine.animationState.setAnimationByName(0, 'loading', true);
    await add(shine);
  }

  @override
  void onTap() {
  }

  @override
  void onDetach() {
    // Dispose the native resources that have been loaded for spineboy.
    shine.dispose();
  }
}


