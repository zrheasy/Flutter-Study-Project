import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class ConstraintLayoutPage extends StatefulWidget {
  const ConstraintLayoutPage({super.key});

  @override
  State<StatefulWidget> createState() => _ConstraintLayoutPage();
}

class _ConstraintLayoutPage extends State<ConstraintLayoutPage> {
  final Widget redBox = const ColoredBox(color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'ConstraintLayout',
        body: SpaceColumn([
          ConstrainedBox(constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 50), child: redBox),
          SizedBox(width: 50, height: 50, child: redBox),
          ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: UnconstrainedBox(child: SizedBox(width: 50, height: 50, child: redBox))),
          AspectRatio(aspectRatio: 16.0 / 9.0, child: redBox),
          LimitedBox(maxWidth: 100, maxHeight: 50, child: SizedBox(width: 90, height: 90, child: redBox)),
          FractionallySizedBox(widthFactor: 0.5, child: SizedBox(height: 50, child: redBox)),
        ]));
  }
}

class SpaceColumn extends StatelessWidget {
  const SpaceColumn(this.children, {super.key});

  final List<Widget> children;
  final Widget space = const SizedBox(height: 10);

  List<Widget> buildItems() {
    var items = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i != children.length) {}
      items.add(space);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buildItems(),
    );
  }
}
