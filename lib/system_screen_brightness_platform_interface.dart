import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'dart:async';

import 'system_screen_brightness_method_channel.dart';

abstract class SystemScreenBrightnessPlatform extends PlatformInterface {
  /// Constructs a SystemScreenBrightnessPlatform.
  SystemScreenBrightnessPlatform() : super(token: _token);

  static final Object _token = Object();

  static SystemScreenBrightnessPlatform _instance = MethodChannelSystemScreenBrightness();

  /// The default instance of [SystemScreenBrightnessPlatform] to use.
  ///
  /// Defaults to [MethodChannelSystemScreenBrightness].
  static SystemScreenBrightnessPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SystemScreenBrightnessPlatform] when
  /// they register themselves.
  static set instance(SystemScreenBrightnessPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setSystemScreenBrightness(double brigthness) async{
    throw UnimplementedError('setSystemScreenBrightness() has not been implemented.');
  }

  Future<double> get currentBrightness async{
    throw UnimplementedError('currentBrightness has not been implemented.');
  }

  Future<bool> get checkSystemWritePermission async{
    throw UnimplementedError('checkSystemWritePermission() has not been implemented.');
  }

  Future<void> openAndroidPermissionsMenu() async{
    throw UnimplementedError('openAndroidPermissionsMenu() has not been implemented.');
  }

}
