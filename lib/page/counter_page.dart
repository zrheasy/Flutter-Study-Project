import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/provider/counter.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'Counter',
        body: Column(children: [
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    var counter = context.read<CounterModel>();
                    counter.increment();
                  },
                  child: const Text("increment"))),
          Center(child: Builder(builder: (context) {
            var counter = context.watch<CounterModel>();
            return Text("${counter.count}", textScaleFactor: 5);
          }))
        ]));
  }
}
