import 'package:flutter/material.dart';
import 'package:osl/programe/programme_list_component.dart';

class ProgrammePage extends StatefulWidget {
  const ProgrammePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProgrammePageState();
}

class _ProgrammePageState extends State<ProgrammePage> {
  @override
  Widget build(BuildContext context) {
    return const ProgrammeListComponent();
  }
}
