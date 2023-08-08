import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';
import '../extension/asset_manager.dart';
import '../data/user.dart';
import '../widget/common.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.user});

  final User user;

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool notificationEnable = false;

  void onNotificationEnable(bool enable) {
    setState(() {
      notificationEnable = !notificationEnable;
    });
  }

  Widget card(BuildContext context, Widget child){
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Profile',
      body: Column(children: [
        card(context, Column(children: [
          RowItem(title: AssetManager.string('nickname'), content: widget.user.name),
          RowItem(title: AssetManager.string('email'), content: widget.user.email),
          RowItem(title: 'Throw Error', onClick: () => throw FlutterError('test')),
          IconItem(title: AssetManager.string('language'), icon: Icons.language),
          SwitchItem(title: 'Notification', selected: notificationEnable, onChanged: onNotificationEnable),
        ])),
        card(context, TextButton(
            onPressed: () => context.navigate('login'),
            child: const Text('Login', style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold))))
      ])
    );
  }
}


