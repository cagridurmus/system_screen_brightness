import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:system_screen_brightness/extension/num_extension.dart';

import 'constant/brightness.dart';
import 'constant/method_name.dart';
import 'constant/plugin_channel.dart';
import 'system_screen_brightness_platform_interface.dart';

/// An implementation of [SystemScreenBrightnessPlatform] that uses method channels.
class MethodChannelSystemScreenBrightness extends SystemScreenBrightnessPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = MethodChannel(pluginMethodChannelName);

  @override
  Future<void> setSystemScreenBrightness(double brightness) async {

    if (!brightness.isInRange(minBrightness, maxBrightness)) {
      throw RangeError.range(brightness, minBrightness, maxBrightness);
    }
    await methodChannel.invokeMethod(methodNameSetScreenBrightness, {"brightness": brightness});
  }

  @override
  Future<double> get currentBrightness async {
    final brightness = await methodChannel.invokeMethod<double>(methodNameGetScreenBrightness);

    if (brightness == null) {
      throw PlatformException(code: "-9", message: "value returns null");
    }
    if (!brightness.isInRange(minBrightness, maxBrightness)) {
      throw RangeError.range(brightness, minBrightness, maxBrightness);
    }
    return brightness;
  }

  @override
  Future<bool> get checkSystemWritePermission async {
    return await methodChannel.invokeMethod<bool>(methodNameCheckSystemWritePermission) ??
        false;
  }

  @override
  Future<void> changeWriteSettingPermission() async {
    await methodChannel.invokeMethod(methodNameOpenAndroidPermissionsMenu);
  }

}
