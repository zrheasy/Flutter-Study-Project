import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class FlowLayoutPage extends StatelessWidget {
  const FlowLayoutPage({super.key});

  List<Widget> items(){
    var result = <Widget>[];
    for(var i=1;i<10;i++){
      var size = 50.0;
      var color = i%2==0?Colors.red : Colors.blue;
      result.add(SizedBox(width: size, height: size, child: ColoredBox(color: color)));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var list = items();
    return PageScaffold(
        title: 'FlowLayout',
        body: Column(
          children: [
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: list
            ),
            Container(color: Colors.black, child: Flow(delegate: _FlowDelegate(spacing: 8, runSpacing: 8, count: list.length), children: list)),
            Expanded(child: SizedBox.expand(child: LayoutBuilder(builder: (_, constraints){
              return OverflowBox(
                minWidth: constraints.maxWidth + 20,
                maxWidth: constraints.maxWidth + 20,
                minHeight: constraints.maxHeight,
                maxHeight: constraints.maxHeight,
                alignment: Alignment.topRight,
                child: DecoratedBox(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/avatar.webp'), repeat: ImageRepeat.repeat, alignment: Alignment.topLeft)),),
              );
            })))
          ]
        ));
  }
}



class _FlowDelegate extends FlowDelegate{
  _FlowDelegate({this.spacing = 0.0, this.runSpacing = 0.0, required this.count});

  final double spacing;

  final double runSpacing;

  final int count;

  double width = 0.0;
  double height = 0.0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = spacing;
    var y = runSpacing;
    var maxHeight = 0.0;
    var line = 0;
    for(var i=0;i<context.childCount;i++){
      var size = context.getChildSize(i)!;
      if(x+size.width > context.size.width){
        line++;
        y += maxHeight + (line > 0 ? runSpacing : 0);
        x = spacing;
        maxHeight = 0;
      }
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
      x += size.width + spacing;
      maxHeight = max(maxHeight, size.height);
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, 200);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
