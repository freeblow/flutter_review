class GameConfig{
  static const SPEEDY_TIME = 20; // 加速时间

  static const ENERGY_LEVEL_UP_CONFIG = {
    "1": {"needToken": 0, "energyThreshold": 500},
    "2": {"needToken": 200, "energyThreshold": 1000},
    "3": {"needToken": 500, "energyThreshold": 1500},
    "4": {"needToken": 1000, "energyThreshold": 2000},
    "5": {"needToken": 2000, "energyThreshold": 2500},
    "6": {"needToken": 4000, "energyThreshold": 3000},
    "7": {"needToken": 8000, "energyThreshold": 3500},
    "8": {"needToken": 16000, "energyThreshold": 4000},
    "9": {"needToken": 25000, "energyThreshold": 4500},
    "10": {"needToken": 50000, "energyThreshold": 5000},
    "11": {"needToken": 100000, "energyThreshold": 5500},
    "12": {"needToken": 200000, "energyThreshold": 6000},
    "13": {"needToken": 300000, "energyThreshold": 6500},
    "14": {"needToken": 400000, "energyThreshold": 7000},
    "15": {"needToken": 500000, "energyThreshold": 7500},
    "16": {"needToken": 600000, "energyThreshold": 8000},
    "17": {"needToken": 700000, "energyThreshold": 8500},
    "18": {"needToken": 800000, "energyThreshold": 9000},
    "19": {"needToken": 900000, "energyThreshold": 9500},
    "20": {"needToken": 1000000, "energyThreshold": 10000}
  };

  static const MULTI_TAP_LEVEL_UP_CONFIG = {
    "1": {"needToken": 0, "multipler": 1},
    "2": {"needToken": 200, "multipler": 2},
    "3": {"needToken": 500, "multipler": 3},
    "4": {"needToken": 1000, "multipler": 4},
    "5": {"needToken": 2000, "multipler": 5},
    "6": {"needToken": 4000, "multipler": 6},
    "7": {"needToken": 8000, "multipler": 7},
    "8": {"needToken": 16000, "multipler": 8},
    "9": {"needToken": 25000, "multipler": 9},
    "10": {"needToken": 50000, "multipler": 10},
    "11": {"needToken": 100000, "multipler": 11},
    "12": {"needToken": 200000, "multipler": 12},
    "13": {"needToken": 300000, "multipler": 13},
    "14": {"needToken": 400000, "multipler": 14},
    "15": {"needToken": 500000, "multipler": 15},
    "16": {"needToken": 600000, "multipler": 16},
    "17": {"needToken": 700000, "multipler": 17},
    "18": {"needToken": 800000, "multipler": 18},
    "19": {"needToken": 900000, "multipler": 19},
    "20": {"needToken": 1000000, "multipler": 20}
  };

  static const SPEEDY_TAP_RATE = 5; // 加速点击的倍率


  static const RECHARGE_LEVEL_UP_CONFIG = {
    "1": {"needToken": 0, "speed": 1},
    "2": {"needToken": 2000, "speed": 2},
    "3": {"needToken": 10000, "speed": 3},
    "4": {"needToken": 100000, "speed": 4},
    "5": {"needToken": 250000, "speed": 5},
  };
}