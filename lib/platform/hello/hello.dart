import 'hello_platform.dart';

class Hello{
  Future<String?> getPlatformVersion() {
    return HelloPlatform.instance.getPlatformVersion();
  }

  Future<String?> getAppVersion() {
    return HelloPlatform.instance.getAppVersion();
  }
}