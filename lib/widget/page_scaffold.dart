import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({super.key, required this.body, this.showAppBar = true, this.showLeading = true, this.title});

  final Widget body;
  final bool showLeading;
  final bool showAppBar;
  final String? title;

  Widget? buildLeadingButton(BuildContext context){
    if(!showLeading)return null;

    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.exitPage();
      }
    );
  }

  AppBar? buildAppBar(BuildContext context) {
    if (!showAppBar) return null;

    String text = title??'';
    return AppBar(
        backgroundColor: Colors.white,
        leading: buildLeadingButton(context),
        centerTitle: true,
        title: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color.fromRGBO(247, 247, 247, 1), appBar: buildAppBar(context), body: body);
  }
}
