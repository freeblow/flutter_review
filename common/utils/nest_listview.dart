import 'package:flutter/material.dart';

class NestListview extends StatelessWidget {
   NestListview({super.key, required this.builder, this.controller, this.itemCount = 0,});
   NullableIndexedWidgetBuilder builder;
   final ScrollController? controller;
   int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: controller,
        itemCount: itemCount,
        itemBuilder: builder
    );
  }
}
