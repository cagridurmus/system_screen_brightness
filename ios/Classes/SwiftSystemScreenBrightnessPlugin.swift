import Flutter
import UIKit

public class SwiftSystemScreenBrightnessPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "system_screen_brightness", binaryMessenger: registrar.messenger())
    let instance = SwiftSystemScreenBrightnessPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
