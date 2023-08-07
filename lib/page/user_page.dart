import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';
import '../extension/asset_manager.dart';
import '../data/user.dart';

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
          RowItem(title: 'ConstraintLayout', onClick: () => context.navigate('constraint_layout')),
          RowItem(title: 'FlowLayout', onClick: () => context.navigate('flow_layout')),
        ])),
        card(context, TextButton(
            onPressed: () => context.navigate('login'),
            child: const Text('Login', style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold))))
      ])
    );
  }
}

class SwitchItem extends StatelessWidget {
  const SwitchItem({super.key, required this.title, required this.selected, this.onChanged});

  final bool selected;
  final String title;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Expanded(child: SizedBox()),
        Switch(value: selected, onChanged: onChanged)
      ]),
    );
  }
}

class IconItem extends StatelessWidget {
  const IconItem({super.key, required this.title, required this.icon, this.onClick});

  final String title;
  final IconData icon;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onClick?.call(),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Expanded(child: SizedBox()),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ]),
        ));
  }
}

class RowItem extends StatelessWidget {
  const RowItem({super.key, required this.title, this.content, this.onClick});

  final String title;
  final String? content;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onClick?.call(),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Expanded(child: SizedBox()),
            Text(content ?? ''),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ]),
        ));
  }
}
