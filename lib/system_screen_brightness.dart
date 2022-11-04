
import 'package:flutter/services.dart';
import 'package:system_screen_brightness/extension/num_extension.dart';

import 'constant/brightness.dart';
import 'constant/method_name.dart';
import 'constant/plugin_channel.dart';
import 'system_screen_brightness_platform_interface.dart';
import 'package:system_screen_brightness/system_screen_brightness_platform_interface.dart';

class SystemScreenBrightness {


  Future<double> get currentBrightness  => SystemScreenBrightnessPlatform.instance.currentBrightness; 

  Future<void> setSystemScreenBrightness(int brigthness) => SystemScreenBrightnessPlatform.instance.setSystemScreenBrightness(brigthness);

  Future<bool> get checkSystemWritePermission => SystemScreenBrightnessPlatform.instance.checkSystemWritePermission; 

  Future<void> openAndroidPermissionsMenu() => SystemScreenBrightnessPlatform.instance.openAndroidPermissionsMenu(); 


}
