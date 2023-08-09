

import 'package:flutter/cupertino.dart';

class CounterModel with ChangeNotifier{
  var _value = 0;

  int get count => _value;

  void increment(){
    _value++;
    notifyListeners();
  }
}