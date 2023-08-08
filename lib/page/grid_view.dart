

import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class GridViewPage extends StatelessWidget{
  const GridViewPage({super.key});

  List<Widget> buildItems(){
    Widget redBox = const ColoredBox(color: Colors.red);
    return [redBox, redBox, redBox, redBox, redBox, redBox];
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'GridView',
        body: Column(
          children: [
            GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8
                ),
              shrinkWrap: true,
              children: buildItems()
            ),
            const SizedBox(height: 10),
            GridView(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  childAspectRatio: 16.0/9.0
                ),
                shrinkWrap: true,
                children: buildItems()
            ),
          ]
        ));
  }


}