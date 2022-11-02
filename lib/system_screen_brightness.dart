
import 'package:flutter/services.dart';
import 'package:system_screen_brightness/extension/num_extension.dart';

import 'constant/brightness.dart';
import 'constant/method_name.dart';
import 'constant/plugin_channel.dart';
import 'system_screen_brightness_platform_interface.dart';
import 'package:system_screen_brightness/system_screen_brightness_platform_interface.dart';

class SystemScreenBrightness {


  Future<double> get currentBrightness async{ return SystemScreenBrightnessPlatform.instance.currentBrightness; }

  Future<void> setSystemScreenBrightness(double brigthness) async{ return SystemScreenBrightnessPlatform.instance.setSystemScreenBrightness(brigthness); }

  Future<bool> get checkSystemWritePermission async{ return SystemScreenBrightnessPlatform.instance.checkSystemWritePermission; }

  Future<void> openAndroidPermissionsMenu() async { return SystemScreenBrightnessPlatform.instance.openAndroidPermissionsMenu(); }


}
