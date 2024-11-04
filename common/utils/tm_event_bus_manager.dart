import 'package:event_bus/event_bus.dart';

class TMEventBusManager{

  static const String TMEventName_Location = "map_location_event";

  static const String TMEventName_Animation = "start_animation";

  static const String TMEventName_TabTaskRef = "golden_hammer_tab_task_ref";


  TMEventBusManager._internal();
  static final TMEventBusManager _busManager = TMEventBusManager._internal();
  factory TMEventBusManager() {
    return _busManager;
  }


  static TMEventBusManager get instance {
    return _busManager;
  }

  EventBus _eventBus = EventBus();

  static EventBus get eventBus{
    return _busManager._eventBus;
  }


  static void onDestroy(){
    eventBus.destroy();
  }

}