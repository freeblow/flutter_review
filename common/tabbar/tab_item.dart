import 'dart:ui';

class TabItem{
  TabItem({
    this.iconName,
    this.title,
    this.iconSize = Size.zero
  });

  String? iconName;
  String? title;
  Size iconSize = Size.zero;
}