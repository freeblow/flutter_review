import 'package:tapmine/common/user/user_manager.dart';

class MiningController{
  num coinCount = UserManager.instance.user?.tokenBalance ?? 0;
  int physicalTrengthValue = UserManager.instance.user.energy;
  int totalPhysicalTrengthValue = UserManager.instance.user.energyThreshold;
}