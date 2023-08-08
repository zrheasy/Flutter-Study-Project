import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class TabBarViewPage extends StatelessWidget {
  const TabBarViewPage({super.key});

  List<Tab> buildTabs() {
    var tabs = <Tab>[];
    for (var i = 0; i < 5; i++) {
      tabs.add(Tab(text: 'Tab $i'));
    }
    return tabs;
  }

  List<Widget> buildPages() {
    var pages = <Widget>[];

    for (var i = 0; i < 5; i++) {
      pages.add(Container(
        alignment: Alignment.center,
        child: Text('$i', textScaleFactor: 5),
      ));
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'TabBarView',
        body: DefaultTabController(
            length: 5,
            child: Column(children: [
              ColoredBox(
                  color: Colors.white,
                  child: TabBar(
                    tabs: buildTabs(),
                    labelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                  )),
              Expanded(child: TabBarView(children: buildPages()))
            ])));
  }
}
