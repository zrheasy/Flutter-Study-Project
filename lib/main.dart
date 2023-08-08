import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/data/user.dart';
import 'package:flutter_demo/extension/asset_manager.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/page/align_layout.dart';
import 'package:flutter_demo/page/constraint_layout.dart';
import 'package:flutter_demo/page/counter_page.dart';
import 'package:flutter_demo/page/custom_scroll_view.dart';
import 'package:flutter_demo/page/dialog.dart';
import 'package:flutter_demo/page/flow_layout.dart';
import 'package:flutter_demo/page/grid_view.dart';
import 'package:flutter_demo/page/home.dart';
import 'package:flutter_demo/page/list_view.dart';
import 'package:flutter_demo/page/login_page.dart';
import 'package:flutter_demo/page/page_view.dart';
import 'package:flutter_demo/page/provider_page.dart';
import 'package:flutter_demo/page/tab_bar_view.dart';
import 'package:flutter_demo/page/user_page.dart';
import 'package:flutter_demo/page/widgets_page.dart';
import 'package:flutter_demo/provider/counter.dart';
import 'package:provider/provider.dart';

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
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterModel>(create: (_) => CounterModel())
      ],
      child: const MyApp()
  ));
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
        initialRoute: 'widgets',
        routes: {
          '/': (context) => const HomePage(),
          'user': (context) => UserPage(user: (context.args as User)),
          'login': (context) => const LoginPage(),
          'widgets': (context) => const WidgetsPage(),
          'constraint_layout': (context) => const ConstraintLayoutPage(),
          'flow_layout': (context) => const FlowLayoutPage(),
          'align_layout': (context) => const AlignLayoutPage(),
          'list_view': (context) => const ListViewPage(),
          'grid_view': (context) => const GridViewPage(),
          'page_view': (context) => const PageViewPage(),
          'tab_bar_view': (context) => const TabBarViewPage(),
          'custom_scroll_view': (context) => const CustomScrollViewPage(),
          'provider': (context) => const ProviderPage(),
          'counter': (context) => const CounterPage(),
          'dialog': (context) => const DialogPage(),
        });
  }
}
