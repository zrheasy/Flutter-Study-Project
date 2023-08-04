import 'package:flutter/material.dart';

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
            Navigator.of(context).pop('Hello');
          },
        ),
        centerTitle: true,
        title: Text(widget.name, style: const TextStyle(fontSize: 16)),
      ),
      body: Column(),
    );
  }
}
