import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _ListViewState();
}

class _ListViewState extends State<ListViewPage> {
  var itemCount = 20;
  var isLoading = false;

  void load() {
    if (isLoading) return;

    isLoading = true;
    Future.delayed(const Duration(milliseconds: 2000), () {
      isLoading = false;
      itemCount += 20;
      setState(() {});
    });
  }

  Widget buildItem(BuildContext context, int index) {
    if (itemCount < 100 && index == itemCount - 1) {
      load();
      return Container(
          height: 56,
          alignment: Alignment.center,
          child: const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)));
    }
    if (itemCount == 100 && index == itemCount - 1) {
      return Container(height: 56, alignment: Alignment.center, child: const Text('已全部加载'));
    }
    return ListTile(title: Text('$index'));
  }

  Widget buildDivider(BuildContext context, int index) {
    return const Divider(color: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'ListView',
        body: ListView.separated(
            cacheExtent: 56, itemBuilder: buildItem, separatorBuilder: buildDivider, itemCount: itemCount));
  }
}
