import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop('Success');
          },
        ),
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              RowItem(title: AssetManager.string('nickname'), content: widget.user.name),
              RowItem(title: AssetManager.string('email'), content: widget.user.email),
              RowItem(
                  title: 'Throw Error',
                  onClick: () {
                    throw FlutterError('test');
                  }),
              IconItem(title: AssetManager.string('language'), icon: Icons.language),
              SwitchItem(title: 'Notification', selected: notificationEnable, onChanged: onNotificationEnable)
            ])),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('login');
                },
                child: const Text('Login', style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold))
            )
        )
      ]),
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
