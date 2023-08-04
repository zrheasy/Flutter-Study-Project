
import 'package:flutter/cupertino.dart';

extension BuildContextExt on BuildContext{

  Object? get args => ModalRoute.of(this)?.settings.arguments;

}