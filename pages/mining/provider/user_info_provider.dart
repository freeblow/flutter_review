import 'package:flutter/material.dart';
import 'package:tapmine/common/user/user_manager.dart';
import 'package:tapmine/common/user/user_model.dart';

class UserInfoProvider extends ChangeNotifier{
  late UserModel _userinfo = UserModel();

  bool _isLogin = false;

  bool _isNewUser = false;

  String _parentName = "";

  bool get isLogin => _isLogin;

  bool get isNewUser => _isNewUser;

  String get parentName => _parentName;

  UserModel get userinfo => _userinfo;

  void setModel(UserModel uModel) {
    _userinfo = uModel;
    UserManager.instance.setUserModel(uModel);
    notifyListeners();
  }

  void setParentUserName(String name){
    _parentName = name;
    notifyListeners();
  }

  void refreshUserInfo(){
    notifyListeners();
  }

  void setLoginStatus(bool login){
    _isLogin = login;
    notifyListeners();
  }

  void setIsNewUser(bool newUser){
    _isNewUser = newUser;
    notifyListeners();
  }
}