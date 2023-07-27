import 'package:flutter/material.dart';

import 'nav-bar-items.dart';

class BottomNavigationBarComponent extends StatefulWidget {
  const BottomNavigationBarComponent({super.key, required this.onSelectedPageChanged});

  final ValueChanged<int> onSelectedPageChanged;

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarComponentState();
}

class _BottomNavigationBarComponentState extends State<BottomNavigationBarComponent> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: navBarItems,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: selectedPageIndex,
        onTap: (value) {
          selectedPageIndex = value;
          widget.onSelectedPageChanged(value);
        });
  }
}
