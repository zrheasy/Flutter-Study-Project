

import 'package:flutter/services.dart';

class HelloPlatform{
  HelloPlatform.internal();

  static HelloPlatform get instance => HelloPlatform.internal();

  final methodChannel = const MethodChannel('hello');

  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<String?> getAppVersion() async {
    final version = await methodChannel.invokeMethod<String>('getAppVersion');
    return version;
  }
}