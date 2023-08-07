import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var userName = '';
  var password = '';

  void onUserNameChange(String value){
    setState(() {
      userName = value;
    });
  }

  void onPasswordChange(String value){
    setState(() {
      password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(fit: StackFit.loose, children: [
          Positioned(
              left: 10,
              top: 10,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close))),
          Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                const Spacer(flex: 2),
                InputItem(
                  title: 'UserName',
                  value: userName,
                  onChange: onUserNameChange,
                ),
                InputItem(
                  title: 'Password',
                  value: password,
                  onChange: onPasswordChange,
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(onPressed: () {
                      print("userName:$userName password:$password");
                      Navigator.of(context).pop();
                    }, child: const Text('Login')),
                  )
                ]),
                const Spacer(flex: 3),
              ]))
        ])));
  }
}

class InputItem extends StatelessWidget {
  const InputItem({super.key, required this.title, required this.value, this.onChange});

  final String title;
  final String value;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        const SizedBox(width: 12),
        Expanded(child: TextField(
          onChanged: onChange,
        ))
      ],
    );
  }
}
