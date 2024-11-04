import 'dart:js' as js;
import 'dart:async';

class JsTimer {
  static final JsTimer _instance = JsTimer._internal();

  factory JsTimer() {
    return _instance;
  }

  static get instance {
    return _instance;
  }

  JsTimer._internal();

  Timer? _dartTimer;
  StreamController<void> _streamController = StreamController<void>.broadcast();

  void start() {
    if (_dartTimer != null) {
      // Timer already running
      return;
    }

    js.context.callMethod('setInterval', [
      js.allowInterop(() {
        _streamController.add(null);
      }),
      1000
    ]);
  }

  void stop() {
    _dartTimer?.cancel();
    _dartTimer = null;
  }

  Stream<void> get onTick => _streamController.stream;
}
