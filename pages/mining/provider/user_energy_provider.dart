import 'package:flutter/material.dart';
import 'package:tapmine/common/user/user_manager.dart';

class UserEnergyProvider extends ChangeNotifier{
  int _energy =  UserManager.instance.user.energy;
  int get energy => _energy;
  void setEnergy(int value) {
    _energy = value;
    notifyListeners();
  }
}