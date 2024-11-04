import 'package:shared_preferences/shared_preferences.dart';

import 'common/const/key.dart';

class Application {
  static final instance = Application();
  factory Application() => _instances;
  static final _instances = Application._internal();
  Application._internal();

  late final SharedPreferences prefs;

  static Future<void> initApplication() async {
    Application().prefs = await SharedPreferences.getInstance();
  }

  static Future<String> initPage() async{
    return '/root';
  }

  String get token {
    return prefs.getString(TAP_MINING_Authorization) ?? "";
  }

  void setToken(String token){
    if(token.isEmpty) return ;
    prefs.setString(TAP_MINING_Authorization, token);
  }
}