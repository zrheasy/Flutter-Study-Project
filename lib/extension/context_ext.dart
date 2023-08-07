
import 'package:flutter/cupertino.dart';

extension BuildContextExt on BuildContext{

  Object? get args => ModalRoute.of(this)?.settings.arguments;

  Future<Object?> navigate(String name, {Object? args}){
    return Navigator.of(this).pushNamed(name, arguments: args);
  }

  void exitPage([Object? result]){
    Navigator.of(this).pop(result);
  }
}