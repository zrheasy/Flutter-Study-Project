import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<StatefulWidget> createState() => DialogState();
}

class DialogState extends State<DialogPage> {
  Future<T?> showCustomDialog<T>(BuildContext context, WidgetBuilder builder) {
    final ThemeData theme = Theme.of(context);

    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black87,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(microseconds: 250),
        transitionBuilder: _buildMaterialDialogTransitions,
        pageBuilder: (context, anim, secondaryAnim) {
          final Widget page = Builder(builder: builder);
          return Theme(data: theme, child: page);
        });
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  void showDialog(BuildContext context) async {
    var result = await showCustomDialog(context, (context) {
      return Center(child: Material(
        type: MaterialType.card,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
            width: 300,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ConstrainedBox(constraints: const BoxConstraints(minHeight: 100), child: const Center(child: Text('message'))),
              const SizedBox(height: 1,width: double.infinity, child: ColoredBox(color: Colors.black38)),
              Row(children: [
                Expanded(child: SizedBox(height: 48, child: InkWell(onTap:()=>context.exitPage(), child: const Center(child: Text('Cancel'))))),
                const SizedBox(height: 48, width: 1, child: ColoredBox(color: Colors.black38)),
                Expanded(child: SizedBox(height: 48, child: InkWell(onTap:()=>context.exitPage("Success"), child: const Center(child: Text('Sure'))))),
              ])
            ])),
      ));
    });

    print("dialog result: $result");
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'Dialog',
        body: Column(children: [
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => showDialog(context),
                child: const Text("showDialog"),
              ))
        ]));
  }
}
