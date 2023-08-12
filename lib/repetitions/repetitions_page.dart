import 'package:flutter/material.dart';
import 'package:osl/repetitions/repetitions_list_component.dart';

class RepetitionsPage extends StatefulWidget {
  const RepetitionsPage({super.key});

  @override
  State<StatefulWidget> createState() => _RepetitionsPageState();
}

class _RepetitionsPageState extends State<RepetitionsPage> {
  @override
  Widget build(BuildContext context) {
    return const RepetitionsListComponent();
  }
}
