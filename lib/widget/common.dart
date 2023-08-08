
import 'package:flutter/material.dart';

class SwitchItem extends StatelessWidget {
  const SwitchItem({super.key, required this.title, required this.selected, this.onChanged});

  final bool selected;
  final String title;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Expanded(child: SizedBox()),
        Switch(value: selected, onChanged: onChanged)
      ]),
    );
  }
}

class IconItem extends StatelessWidget {
  const IconItem({super.key, required this.title, required this.icon, this.onClick});

  final String title;
  final IconData icon;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onClick?.call(),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Expanded(child: SizedBox()),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ]),
        ));
  }
}

class RowItem extends StatelessWidget {
  const RowItem({super.key, required this.title, this.content, this.onClick});

  final String title;
  final String? content;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onClick?.call(),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Expanded(child: SizedBox()),
            Text(content ?? ''),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ]),
        ));
  }
}