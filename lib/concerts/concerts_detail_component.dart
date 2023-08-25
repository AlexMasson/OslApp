import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:osl/model/concert.dart';

class ConcertsDetailsComponent extends StatelessWidget {
  const ConcertsDetailsComponent({super.key, required this.concert});

  final Concert concert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(child: Text('Concert du ${DateFormat.yMMMMEEEEd('fr_FR').format(concert.date)}')),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Nom', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            Text(concert.nom),
            const SizedBox(height: 10),
            Text('Adresse', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            getAddress(),
            const SizedBox(height: 10),
            Text('Heure arrivée musiciens', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            getHeureArriveeMusiciens(),
            const SizedBox(height: 10),
            Text('Heure concert', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            getHeureConcert(),
            const SizedBox(height: 10),
            Text('Programme', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            Text(getProgramme()),
            const SizedBox(height: 10),
          ])),
    );
  }

  Row getAddress() {
    if (concert.adresse == null || concert.adresse!.isEmpty) {
      return const Row(children: [Text('Non communiquée')]);
    }

    return Row(
        children: [Text(concert.adresse!), IconButton(icon: const Icon(Icons.map), onPressed: () => MapsLauncher.launchQuery(concert.adresse!))]);
  }

  Row getHeureArriveeMusiciens() {
    if (concert.heureArriveeMusiciens == null || concert.heureArriveeMusiciens!.isEmpty) {
      return const Row(children: [Text('Non communiquée')]);
    }

    return Row(children: [Text(concert.heureArriveeMusiciens!)]);
  }

  Row getHeureConcert() {
    if (concert.heureConcert == null || concert.heureConcert!.isEmpty) {
      return const Row(children: [Text('Non communiquée')]);
    }

    return Row(children: [Text(concert.heureConcert!)]);
  }

  String getProgramme() {
    if (concert.programmeList == null) {
      return 'Non communiqué';
    }

    var programme = '';
    var i = 0;
    for (var programmeItem in concert.programmeList!.where((element) => element != '')) {
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
}
