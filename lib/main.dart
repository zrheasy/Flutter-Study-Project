import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/data/user.dart';
import 'package:flutter_demo/extension/asset_manager.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/page/home.dart';
import 'package:flutter_demo/page/user_page.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    print(details);
  };

  runZoned(() => startApp(), zoneSpecification: ZoneSpecification(
    // 拦截print
    print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
      parent.print(zone, "Interceptor: $line");
    },
    // 拦截未处理的异步错误
    handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone, Object error, StackTrace stackTrace) {
      parent.print(zone, '${error.toString()} $stackTrace');
    },
  ));
}

void startApp() {
  WidgetsFlutterBinding.ensureInitialized();
  AssetManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            })),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          'user': (context) => UserPage(user: (context.args as User)),
        });
  }
}
