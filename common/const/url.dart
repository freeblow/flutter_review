
class TMURLs{
  static bool isDebugMode = false;

  static String get TELEGRAM_BOT_SHARE_URL{
    if(isDebugMode){
      return "https://t.me/tap_mine_test_bot/Tap_Mine_Test";
    }
    return "https://t.me/GoldenHammerBot/hammer";
  }

  static String get TELEGRAM_BBS_GROUP_URL{
    if(isDebugMode){
      return "https://t.me/goldenhammer_chat";
    }
    return "https://t.me/goldenhammer_chat";
  }

  static String get TWITTER_GROUP_URL{
    if(isDebugMode){
      return "https://x.com/GoldenHammer_tg";
    }
    return "https://x.com/GoldenHammer_tg";
  }

  static String get MAIN_HOST{
    if(isDebugMode){
      return "tapmine.aplus.gold";
    }
    return "apiapiapi.aplus.gold";
  }

  static String get WEBSOCKET_HOST{
    // if(isDebugMode){
    //   return "wss://tapmine.aplus.gold/ws";
    // }
    return "wss://apiapiapi.aplus.gold/ws";
  }

}
