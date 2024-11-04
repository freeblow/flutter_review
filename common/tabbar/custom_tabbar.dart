
import 'package:flutter/material.dart';

class CustomTabbar extends StatefulWidget {

  static const kTabItemHeight = 56.0;
  static const kTabItemsInterval = 5.0;

  CustomTabbar({
    this.controller,
    this.height = kTabItemHeight,
    this.tabs,
    this.selectedTabs,
    this.itemInterval = kTabItemsInterval,
    this.onTap,
    this.currentIndex = 0,
    super.key});

  TabController? controller;
  List<Widget>? tabs;
  List<Widget>? selectedTabs;

  double height = kTabItemHeight;
  EdgeInsets itemVerticalPadding = EdgeInsets.zero;
  double itemInterval = kTabItemsInterval;
  int currentIndex = 0;

  Function(int)? onTap;


  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {

  late List<GlobalKey> _tabKeys;
  final GlobalKey _tabsContainerKey = GlobalKey();
  final GlobalKey _tabsParentKey = GlobalKey();

  int _currentIndex = 0;
  int _prevIndex = -1;


  TabController? _controller;

  @override
  void initState() {

    _currentIndex = widget.currentIndex;

    _tabKeys = widget.tabs!.map((Widget tab) => GlobalKey()).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: widget.height,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _items,
      ),
    );
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMaterial(context));
    _updateTabController();
  }

  @override
  void didUpdateWidget(CustomTabbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
    }

    int newCount = widget.tabs?.length ?? 0;
    int oldCount = oldWidget.tabs?.length ?? 0;
    if (newCount > oldCount) {
      final int delta = newCount - oldCount;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (newCount < oldCount) {
      _tabKeys.removeRange(newCount, oldCount);
    }


    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() {
        _currentIndex = widget.currentIndex;
      });
    }
  }




  @override
  void dispose() {
    _controller?.removeListener(_handleController);
    _controller = null;
    super.dispose();
  }

  List<Widget> get _items{
    List<Widget> ret = [];
    for(int i = 0; i < (widget.tabs?.length ?? 0); i++){
      ret.add(_buildItem(i));
      if(i< (widget.tabs?.length ?? 0)){
        ret.add(SizedBox(width: widget.itemInterval,));
      }
    }
    return ret;
  }

  Widget _buildItem(
      int index,
      {bool isSelected = false}
      ){
    if(index >= (widget.tabs?.length ?? 0)){
      AssertionError("index error");
    }

    return GestureDetector(
      onTap: (){
        _goToIndex(index);
        if(widget.onTap != null){
          widget.onTap!(index);
        }
      },
      child: (index == _currentIndex)? (widget.selectedTabs?[index] ?? SizedBox.shrink()): (widget.tabs?[index] ?? SizedBox.shrink()),
    );

  }

  void _handleController() {
    if (_controller!.indexIsChanging) {
      // update highlighted index when controller index is changing
      _goToIndex(_controller!.index);
    }
  }

  _goToIndex(int index) {
    if (index != _currentIndex) {
      _setCurrentIndex(index);
      _controller?.animateTo(index);
    }
  }


  _setCurrentIndex(int index) {
    // change the index
    setState(() {
      _prevIndex = _currentIndex;
      _currentIndex = index;
    });

  }


  void _updateTabController() {
    final TabController? newController =
        widget.controller ?? DefaultTabController.of(context);
    assert(() {
      if (newController == null) {
        throw FlutterError('No TabController for ${widget.runtimeType}.\n'
            'When creating a ${widget.runtimeType}, you must either provide an explicit '
            'TabController using the "controller" property, or you must ensure that there '
            'is a DefaultTabController above the ${widget.runtimeType}.\n'
            'In this case, there was neither an explicit controller nor a default controller.');
      }
      return true;
    }());

    if (newController == _controller) return;


    _controller = newController;

    _controller?.addListener(_handleController);
    _currentIndex = _controller!.index;
  }
}
