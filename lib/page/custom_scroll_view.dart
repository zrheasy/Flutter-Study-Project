import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class CustomScrollViewPage extends StatelessWidget {
  const CustomScrollViewPage({super.key});

  Widget buildItem(BuildContext context, int index) {
    return const ColoredBox(color: Colors.red);
  }

  Widget buildListItem(BuildContext context, int index) {
    return Container(color: Colors.blue, margin: EdgeInsets.only(top: 10));
  }

  Widget buildGridSliver() {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(buildItem, childCount: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 4));
  }

  Widget buildListSliver() {
    return SliverFixedExtentList(delegate: SliverChildBuilderDelegate(buildListItem, childCount: 20), itemExtent: 50);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        showAppBar: false,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue,
            scrolledUnderElevation: 0,
            leading: InkWell(onTap: () => context.exitPage(), child: const Icon(Icons.arrow_back, color: Colors.white)),
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("CustomScrollView", style: TextStyle(color: Colors.white)),
              centerTitle: true,
              background: ColoredBox(color: Colors.blue),
            )
          ),
          buildGridSliver(),
          buildListSliver()
        ]));
  }
}
