import 'package:flutter/material.dart';

class ResponsiveTools extends StatelessWidget {
  static const double _widthLimit = 650.0;

  final Widget smallScreen;
  final Widget bigScreen;

  const ResponsiveTools(
      {super.key, required this.smallScreen, required this.bigScreen});

  static bool isSmallScreen(final BuildContext context) =>
      MediaQuery.of(context).size.width < _widthLimit;

  static bool isBigScreen(final BuildContext context) =>
      MediaQuery.of(context).size.width >= _widthLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > _widthLimit) {
        return bigScreen;
      } else {
        return smallScreen;
      }
    }));
  }
}
