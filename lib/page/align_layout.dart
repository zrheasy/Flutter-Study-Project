import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class AlignLayoutPage extends StatelessWidget {
  const AlignLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget redBox = Container(width: 50, height: 50, color: Colors.red);
    final Widget blueBox = Container(width: 50, height: 50, color: Colors.blue);
    return PageScaffold(
        title: 'AlignLayout',
        body: SizedBox.expand(child: Stack(fit: StackFit.expand, children: [
          Align(alignment: Alignment.topLeft, child: redBox),
          Align(alignment: Alignment.topRight, child: redBox),
          Align(alignment: Alignment.bottomLeft, child: redBox),
          Align(alignment: Alignment.bottomRight, child: redBox),
          Align(alignment: Alignment.center, child: redBox),
          Align(alignment: Alignment.topCenter, child: redBox),
          Align(alignment: Alignment.centerLeft, child: redBox),
          Align(alignment: Alignment.bottomCenter, child: redBox),
          Align(alignment: Alignment.centerRight, child: redBox),
          Align(alignment: const FractionalOffset(0.1, 0.1), child: blueBox),
          Align(alignment: const FractionalOffset(0.9, 0.9), child: blueBox),
          Align(alignment: const Alignment(-0.4, -0.1), child: blueBox),
          Align(alignment: const Alignment(0.4, 0.1), child: blueBox),
        ])));
  }
}
