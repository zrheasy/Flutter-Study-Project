

import 'package:flutter/cupertino.dart';

class CounterModel with ChangeNotifier{
  var _value = 0;

  int get count => _value;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    print(listener);
  }

  void increment(){
    _value++;
    notifyListeners();
  }
}