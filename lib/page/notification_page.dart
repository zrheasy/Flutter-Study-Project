import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'Notification',
        body: NotificationListener(
            onNotification: (notification) {
              switch (notification.runtimeType){
                case ScrollStartNotification: print("开始滚动"); break;
                case ScrollUpdateNotification: print("正在滚动"); break;
                case ScrollEndNotification: print("滚动停止"); break;
                case OverscrollNotification: print("滚动到边界"); break;
              }
              return true;
            },
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                })));
  }
}
