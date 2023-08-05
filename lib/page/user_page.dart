import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/asset_manager.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.name});

  final String name;

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
              Container(
                margin: const EdgeInsets.all(16),
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const Text('NickName', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Expanded(child: SizedBox()),
                  Text(widget.name),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_right_outlined)
                ]),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const Text('Email', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Expanded(child: SizedBox()),
                  Text(AssetManager.string('email')),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_right_outlined)
                ]),
              )
            ])
        )
      ]),
    );
  }
}
