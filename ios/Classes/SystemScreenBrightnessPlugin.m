#import "SystemScreenBrightnessPlugin.h"
#if __has_include(<system_screen_brightness/system_screen_brightness-Swift.h>)
#import <system_screen_brightness/system_screen_brightness-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "system_screen_brightness-Swift.h"
#endif

@implementation SystemScreenBrightnessPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSystemScreenBrightnessPlugin registerWithRegistrar:registrar];
}
@end
