import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/repetition.dart';

class RepetitionsDetailsComponent extends StatelessWidget {
  const RepetitionsDetailsComponent({super.key, required this.repetition});

  final Repetition repetition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(child: Text('Répétition du ${DateFormat.yMMMMEEEEd('fr_FR').format(repetition.date)}')),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Adresse'),
            Text(getAddress(repetition.lieu)),
            const SizedBox(height: 15),
            const Text('Horaire'),
            const Text('19h00 - 21h00'),
          ])),
    );
  }

  String getAddress(String repetitionLieu) {
    switch (repetitionLieu) {
      case 'Opéra':
        return '102 rue de Marseille 69007 Lyon';
      case 'Emile Cohl':
        return '1 rue Felix Rollet 69003 Lyon';
      case 'ENS':
        return '46 allée d\'Italie 69007 Lyon';
      default:
        return '';
    }
  }
}
