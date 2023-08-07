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
                  title: 'Error',
                  onClick: () {
                    throw FlutterError('test');
                  }),
            ]))
      ]),
    );
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
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ]),
        ));
  }
}
