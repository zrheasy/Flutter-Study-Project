
import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/page/home.dart';
import 'package:flutter_demo/page/user_page.dart';

void main() {
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
        })
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        'user': (context) => UserPage(name: (context.args as String)),

      }
    );
  }
}
