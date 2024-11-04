import 'dart:async';

class SingletonTimer {
  static final SingletonTimer _instance = SingletonTimer._internal();

  static SingletonTimer get instance {
    return _instance;
  }

  factory SingletonTimer() {
    return _instance;
  }

  SingletonTimer._internal(){
    start();
  }

  Timer? _timer;
  StreamController<void> _streamController = StreamController<void>.broadcast();

  void start() {
    if (_timer != null) {
      // Timer already running
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamController.add(null);
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Stream<void> get onTick => _streamController.stream;
}
