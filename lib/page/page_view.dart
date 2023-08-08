import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<PageViewPage> {

  Widget buildPage(BuildContext context, int index) {
    return KeepAliveWrapper(child: Center(child: Text('$index', textScaleFactor: 5)));
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'PageView', body: PageView.builder(
        allowImplicitScrolling: true,
        itemCount: 5,
        itemBuilder: buildPage)
    );
  }
}

// 实现页面缓存
class KeepAliveWrapper extends StatefulWidget{
  const KeepAliveWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => _KeepAliveState();

}

class _KeepAliveState extends State<KeepAliveWrapper> with KeepAliveParentDataMixin{
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void detach() {

  }

  @override
  bool get keptAlive => true;
}
