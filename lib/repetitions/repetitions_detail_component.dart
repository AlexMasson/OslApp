import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';

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
            Text('Adresse', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            getAddress(),
            const SizedBox(height: 10),
            Text('Présence', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            Text(repetition.type),
            const SizedBox(height: 10),
            Text('Programme', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            Text(getProgramme()),
            const SizedBox(height: 10),
            Text('Horaire', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            Text(getHoraire()),
            const SizedBox(height: 10),
            Text('Commentaire', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            Text(getCommentaire()),
            const SizedBox(height: 10),
          ])),
    );
  }

  Row getAddress() {
    if (repetition.lieu == null) {
      return const Row(children: [Text('Non communiquée')]);
    }

    var adresse = 'Non communiquée';
    switch (repetition.lieu) {
      case 'Opéra':
        adresse = '102 rue de Marseille 69007 Lyon';
        break;
      case 'Ecole Emile Cohl':
        adresse = '1 rue Felix Rollet 69003 Lyon';
      case 'ENS':
        adresse = '46 allée d\'Italie 69007 Lyon';
    }

    if (adresse == 'Non communiquée') {
      return const Row(children: [Text('Non communiquée')]);
    }

    final iconButton = IconButton(icon: const Icon(Icons.map), onPressed: () => MapsLauncher.launchQuery(adresse));
    return Row(children: [Text('${repetition.lieu} - $adresse'), iconButton]);
  }

  String getProgramme() {
    if (repetition.programmeList == null) {
      return 'Non communiqué';
    }

    var programme = '';
    var i = 0;
    for (var programmeItem in repetition.programmeList!.where((element) => element != '')) {
      if (i > 0) {
        programme += '\n';
      }

      programme += '\u2022 $programmeItem';
      i++;
    }

    if (programme == '') {
      programme = 'Non communiqué';
    }

    return programme;
  }

  String getHoraire() {
    if (repetition.horaire == null || repetition.horaire!.isEmpty) {
      return 'Non communiqué';
    }

    return repetition.horaire!;
  }

  String getCommentaire() {
    if (repetition.commentaire == null || repetition.commentaire!.isEmpty) {
      return 'Aucun commentaire';
    }

    return repetition.commentaire!;
  }
}
