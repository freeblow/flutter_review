import 'package:tapmine/common/user/user_model.dart';
import 'package:tapmine/websocket/pipeline/tp_pipeline_task.dart';

import '../../application.dart';
import '../../pages/boost/controller/boost_controller.dart';
import '../../pages/boost/model/boost_task_item_model.dart';
import '../../pages/boost/widget/boost_task_sheet_panel_widget.dart';
import '../../pages/root/root_page.dart';
import '../const/key.dart';
import '../const/url.dart';
import '../network/api.dart';

class UserManager{
  static final instance = UserManager();
  static final UserManager _userManager = UserManager._internal();
  factory UserManager() {
    return _userManager;
  }
  UserManager._internal();

  int energyTrength = 200;


  bool isLogin = false;

  String _token = "";

  bool get isCacheLogin{
    if(token.isNotEmpty){
      return true;
    }
    return false;
  }

  void setToken(String t) {
    _token = t;
    Application.instance.prefs.setString(TAP_MINING_Authorization, _token);
  }

  String get token {
    String ret = _token;
    if (ret.isEmpty) {
      ret = Application.instance.token;
    }
    return ret;
  }

  UserModel? _userModel;

  void setUserModel(UserModel model){
    _userModel = model;
  }

  UserModel get user{
    if(_userModel == null){
      return UserModel();
    }
    return _userModel!;
  }

  int physicalTrengthTotalValue = 0;
  int pointsCount = 0;


  Future<void> reqUserInfo() async {
    var result = await API.getUserInfo();
    if(result != null && result.code == '0' &&  result.result != null){
        UserModel userModel = UserModel.fromJson(result.result);
        UserManager.instance.setUserModel(userModel);
    }else{

      await Future.delayed(const Duration(seconds: 2),() async {
        await reqUserInfo();
      });
    }
  }

  bool get isCouldMining{
    if(!isLogin)return false;
    if(TPPipelineTask.instance.isSpeedy){
      return true;
    }

    if(_userModel != null && _userModel!.energy >= 0  && _userModel!.energyThreshold > 0 && _userModel!.energy <= _userModel!.energyThreshold){
      if(_userModel!.energy >= TPPipelineTask.instance.unitPoints){
        return true;
      }
    }
    return false;
  }

  bool isCouldMiningWith(UserModel? userInfo){
    if(!UserManager.instance.isLogin) return false;
    if(userInfo != null && userInfo!.energy >= 0  && userInfo!.energyThreshold > 0 && userInfo!.energy <= userInfo!.energyThreshold){
      if(userInfo!.energy >= userInfo!.normalTapMultipler){
        return true;
      }
    }
    return false;
  }

  String _referralId = "";

  void setReferralId(String value){
    _referralId = value;
  }

  String get referralId{
    return _referralId;
  }

  String _inviteParams(){
    return "startapp=$REFERRAL_PREFIX${_referralId}";
  }

  String get inviteUrl{
    return "${TMURLs.TELEGRAM_BOT_SHARE_URL}?${_inviteParams()}";
  }









}