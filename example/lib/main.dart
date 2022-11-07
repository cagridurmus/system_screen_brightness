import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:system_screen_brightness/system_screen_brightness.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _brightness = 0.0;
  bool _isPermission = false;
  double _currentBrightness = 0.0;
  late final SystemScreenBrightness _systemScreenBrightnessPlugin = SystemScreenBrightness();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    /*initPlatformState2();*/

  }

  initPlatformState() async{
    await initPlatformState1();
    await initPlatformState2();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState1() async {
    double brightness;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      brightness =
          await _systemScreenBrightnessPlugin.currentBrightness;
    } on PlatformException {
      brightness = 0.0;
    }
    if (!mounted) return;

    setState(() {
      _currentBrightness = brightness;
    });
  }

  Future<bool?> initPlatformState2() async {
    bool hasPermission;
    try {
      hasPermission =
          await _systemScreenBrightnessPlugin.checkSystemWritePermission;
    } on PlatformException {
      hasPermission = false;
    }

    setState(() {
      _isPermission = hasPermission;
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SetSystemScreenBrigthness APP'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Switch(
                  value: _isPermission,
                  onChanged: (value) async{
                    await _systemScreenBrightnessPlugin.openAndroidPermissionsMenu();
                    _isPermission = value;
                    setState(() {

                    });
                  },
                ),
                Text(_isPermission.toString()),

                ElevatedButton(
                  onPressed: () async {
                    double brightness = await _systemScreenBrightnessPlugin.currentBrightness;
                    print(brightness);
                  }, child: Icon(Icons.power_settings_new),
                ),
                Text(_currentBrightness.toString())
              ],
            ),
            Column(
              children: [
                Slider(
                    value: _brightness,
                    min: 0.0,
                    max: 1.0,
                    onChanged: ((double value){
                      _brightness = value;
                      _systemScreenBrightnessPlugin.setSystemScreenBrightness((_brightness * 255).toInt());
                      setState(() {
                      });
                    })
                ),
                Text(_brightness.toString()),
              ],
            )

          ],
        ),
      ),
    );
  }
}
