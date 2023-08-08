import 'package:flutter/material.dart';
import 'package:flutter_demo/extension/context_ext.dart';
import 'package:flutter_demo/widget/page_scaffold.dart';

import '../widget/common.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
        title: 'Widgets',
        body: Scrollbar(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  RowItem(title: 'ConstraintLayout', onClick: () => context.navigate('constraint_layout')),
                  RowItem(title: 'FlowLayout', onClick: () => context.navigate('flow_layout')),
                  RowItem(title: 'AlignLayout', onClick: () => context.navigate('align_layout')),
                  RowItem(title: 'ListView', onClick: () => context.navigate('list_view')),
                  RowItem(title: 'GridView', onClick: () => context.navigate('grid_view')),
                  RowItem(title: 'PageView', onClick: () => context.navigate('page_view')),

                  const SizedBox(width: double.infinity, height: 800)
                ]))));
  }
}
