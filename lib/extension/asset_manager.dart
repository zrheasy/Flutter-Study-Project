import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AssetManager {
  static final Map<String, dynamic> _strings = {};

  static void init() async {
    var json = await rootBundle.loadString('assets/strings.json');
    var map = jsonDecode(json);
    _strings.addAll(map);
  }

  static String string(String key) {
    return _strings[key] ?? '';
  }
}
