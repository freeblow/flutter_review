import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart';
import 'package:provider/provider.dart';
import 'package:tapmine/application.dart';
import 'package:tapmine/common/const/url.dart';
import 'package:tapmine/common/user/user_manager.dart';
import 'package:tapmine/pages/mining/provider/user_info_provider.dart';
import 'package:tapmine/pages/root/root_page.dart';
import 'package:tapmine/websocket/pipeline/tp_pipeline_task.dart';

import '../../../common/const/key.dart';
import '../../../common/log/trace_log_widget.dart';
import '../../../common/network/api.dart';
import 'package:flutter_telegram_web_app/flutter_telegram_web_app.dart' as tg;

import '../../mining/widget/miner_work_reminder_sheet_widget.dart';
import '../provider/trace_log_provider.dart';

class RootController{

  final WebAppInitData webAppInitData = tg.initDataUnsafe;




  void login({Function(bool isNew, String parentName )? finish})  {

    bool isNewUser = false;

    String telegramId = "${webAppInitData.user?.id ?? ""}";
    if(kDebugMode){
      telegramId = "6612139894";
    }
    UserManager.instance.setReferralId(telegramId);


    String username = "${webAppInitData.user?.username ?? "unknown"}";
    if(kDebugMode){
      username = "unknown";

    }
    if(username == "unknown"){
      if(webAppInitData.user?.first_name != null && webAppInitData.user!.first_name.isNotEmpty){
        username = webAppInitData.user!.first_name;
      }

      if(webAppInitData.user?.first_name != null && webAppInitData.user!.last_name.isNotEmpty){
        if(username.isNotEmpty){
          username =  "${webAppInitData.user!.last_name} $username";
        }else{
          username = webAppInitData.user!.last_name;
        }

      }
    }

    String lang = "${webAppInitData.user?.language_code ?? ""}";
    if(kDebugMode){
      lang = "en";
    }

    String photo_url = "${webAppInitData.user?.photo_url ?? ""}";
    if(kDebugMode){
      photo_url = "";
    }

    String referralId = webAppInitData.start_param ?? "";
    if(referralId.startsWith(REFERRAL_PREFIX) && referralId.length > REFERRAL_PREFIX.length){
      referralId = referralId.substring(REFERRAL_PREFIX.length);
    }else{
      referralId = "";
    }

    var mParams = {
      "telegramId": telegramId,
      "username":username,
      "photo_url":photo_url,
      "referral": referralId,
      "lang":lang,
      // "msg": telegramId,
      "msg": TMURLs.isDebugMode?telegramId : tg.initData,
    };
    isNewUser = referralId.isNotEmpty;
    API.userLogin(params: mParams).then((value){
      if (kDebugMode) {
        print("login success!!");
      }

      if(value.code == '0' && value.result != null){
        String? accessToken = value.result["access_token"];

        if(accessToken != null && accessToken.isNotEmpty){
          if(kDebugMode){
            print("login success token : $accessToken");
          }
          UserManager.instance.isLogin = true;
          Application.instance.setToken(accessToken);
          bool isNew = (value.result["new"] ?? 0) > 0;
          String parentName = value.result["prarentName"] ?? "";
          Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setParentUserName(parentName);

          refreshUserInfo(isNew: isNew);
          if(finish != null){
            finish(isNew, parentName);
          }

        }
      }else{

      }


    });

  }

  void setHeaderColor(){
    tg.setHeaderColor("#241F33");
  }


  static void offline(){
    // API.setUserOffline();
  }

  void refreshUserInfo({bool isNew = false}){
    if(!(UserManager.instance.isLogin))return;
    UserManager.instance.reqUserInfo().whenComplete((){
      Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setIsNewUser(isNew);
      Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setLoginStatus(true);
      TPPipelineTask.instance.speedyMultiple = UserManager.instance.user.normalTapMultipler;
      if(UserManager.instance.user.offlineRewardActivated && UserManager.instance.user.offlineReward > 0){
        Timer(const Duration(milliseconds: 200),(){
          if(RootPage.navigatorKey.currentContext != null){
            MinerWorkReminderSheetWidget.show(RootPage.navigatorKey.currentContext!, coinCount: UserManager.instance.user.offlineReward);
          }

        });
      }
      TPPipelineTask.instance.startConnect();
      if(RootPage.navigatorKey.currentContext != null){
        Provider.of<UserInfoProvider>(RootPage.navigatorKey.currentContext!, listen: false).setModel(UserManager.instance.user);
      }




    });
  }

  static void addDebugLog(String l){
    TraceLogProvider traceLogC = Provider.of<TraceLogProvider>(RootPage.navigatorKey.currentContext!, listen: false);
    traceLogC.addMsgLog(l);
  }
}