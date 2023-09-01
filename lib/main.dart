import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:osl/concerts/concerts_page.dart';
import 'package:osl/programe/programme_page.dart';
import 'package:osl/repetitions/repetitions_page.dart';
import 'package:osl/index_page.dart';

import 'bottom_navigation_bar_component.dart';
import 'nav_bar_items.dart';

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
      themeMode: ThemeMode.light,
      theme: ThemeData(
          brightness: Brightness.light, colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 209, 51, 61)), useMaterial3: true),
      darkTheme: ThemeData(
          brightness: Brightness.light, colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(0, 209, 51, 61)), useMaterial3: true),
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
  static const List<Widget> _pages = <Widget>[IndexPage(), RepetitionsPage(), ConcertsPage(), ProgrammePage()];

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
