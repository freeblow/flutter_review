import 'package:flame/components.dart';
import 'package:flame_spine/flame_spine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spine_flutter/spine_flutter.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'dart:ui' as ui;

import 'custom_game_widget.dart';


class FlameSpineMineShineForegroundWidget extends StatefulWidget {
  const FlameSpineMineShineForegroundWidget({super.key});

  @override
  State<FlameSpineMineShineForegroundWidget> createState() => _FlameSpineMineShineForegroundWidgetState();
}

class _FlameSpineMineShineForegroundWidgetState extends State<FlameSpineMineShineForegroundWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomGameWidget.controlled(
        gameFactory: SpineForegroudExample.new,
      backgroundBuilder: (BuildContext context){
          return Container(color: ui.Color(0x00FFFFFF));
      },
    );
  }
}


class SpineForegroudExample extends FlameGame with TapDetector {
  late final SpineComponent shine;

  @override


  @override
  Future<void> onLoad() async {
    // Load the Spineboy atlas and skeleton data from asset files
    // and create a SpineComponent from them, scaled down and
    // centered on the screen

    shine = await SpineComponent.fromAssets(
      atlasFile: 'assets/mining/speed_effective/fore/bei.atlas',
      skeletonFile: 'assets/mining/speed_effective/fore/skeleton.skel',
      scale: Vector2(0.5,0.5),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y / 2),
    );

    // Set the "walk" animation on track 0 in looping mode
    shine.animationState.setAnimationByName(0, 'animation', true);
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
