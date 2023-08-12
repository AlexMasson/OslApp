import 'package:flutter/material.dart';
import 'package:osl/concerts/concerts_list_component.dart';

class ConcertsPage extends StatefulWidget {
  const ConcertsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ConcertsPageState();
}

class _ConcertsPageState extends State<ConcertsPage> {
  @override
  Widget build(BuildContext context) {
    return const ConcertsListComponent();
  }
}
