# system_screen_brightness

A Plugin for controlling screen brightness.

## Getting Started
### Install
Add the following lines in your pubspec.yaml file

```yaml
  system_screen_brightness: ^latest_version
```

### API
#### System current brightness
```dart
Future<double> get currentbrightnes async {
  try {
    return await SystemScreenBrightness().currentBrightness;
  } catch (e) {
    print(e);
    throw 'Failed to get system current brightness brightness';
  }
}
```
#### Set brightness
```dart
Future<void> setSystemScreenBrightness(double brightness) async {
  try {
    await SystemScreenBrightness.setSystemScreenBrightness(brightness);
  } catch (e) {
    print(e);
    throw 'Failed to set system screen brightness';
  }
}
```