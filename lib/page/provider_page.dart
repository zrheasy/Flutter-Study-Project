import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/provider/counter.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';
import 'package:provider/provider.dart';

class ProviderPage extends StatelessWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'Provider',
        body: Column(children: [
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => context.navigate('counter'), child: const Text("Counter"))),
          Center(child: Builder(builder: (context) {
            var counter = context.watch<CounterModel>();
            return Text("${counter.count}", textScaleFactor: 5);
          }))
        ]));
  }
}
