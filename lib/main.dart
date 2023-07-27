import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:osl/repetitions/repetitions-page.dart';
import 'package:osl/index-page.dart';

import 'bottom-navigation-bar-component.dart';
import 'nav-bar-items.dart';

void main() {
  initializeDateFormatting('fr_FR', null).then((_) {
    runApp(const MyApp());
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.wave;
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSL App',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 209, 51, 61)), useMaterial3: true),
      home: const MyHomePage(title: 'Accueil'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Widget> _pages = <Widget>[IndexPage(), RepetitionsPage()];

  Widget body = _pages[0];
  String title = navBarItems[0].label!;

  void _handleSelectedPageChanged(int selectedPageIndex) {
    setState(() {
      body = _pages[selectedPageIndex];
      title = navBarItems[selectedPageIndex].label!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Center(child: Text(title)),
            foregroundColor: Theme.of(context).colorScheme.onPrimary),
        body: body,
        bottomNavigationBar: BottomNavigationBarComponent(onSelectedPageChanged: _handleSelectedPageChanged));
  }
}