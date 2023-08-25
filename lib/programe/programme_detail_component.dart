import 'package:flutter/material.dart';
import 'package:osl/model/programme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgrammeDetailsComponent extends StatelessWidget {
  const ProgrammeDetailsComponent({super.key, required this.programme});

  final Programme programme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(child: Text(programme.nom)),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Nom', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            Text(programme.nom),
            const SizedBox(height: 10),
            Text('Partitions', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            getPartitions(),
            const SizedBox(height: 10),
            Text('Extraits', style: Theme.of(context).textTheme.titleLarge),
            const Divider(thickness: 0.4),
            getExtraits(context)
          ])),
    );
  }

  Row getPartitions() {
    if (programme.lienPartitions == null) {
      return const Row(
        children: [Text('Aucune partition')],
      );
    }

    return Row(children: [
      const Text('\u2022 Lien'),
      IconButton(icon: const Icon(Icons.link), onPressed: () => launchUrl(Uri.parse(programme.lienPartitions!)))
    ]);
  }

  Column getExtraits(BuildContext context) {
    if (programme.liensExtraits == null) {
      return const Column(
        children: [Text('Aucun extrait')],
      );
    }

    List<Widget> extraits = [];

    var i = 1;
    for (var extrait in programme.liensExtraits!.where((element) => element != '')) {
      extraits
          .add(Row(children: [Text('\u2022 Extrait $i'), IconButton(icon: const Icon(Icons.link), onPressed: () => launchUrl(Uri.parse(extrait)))]));
      i++;
    }

    if (extraits.isEmpty) {
      return const Column(
        children: [Text('Aucun extrait')],
      );
    }

    List<Widget> widgets = [];
    for (final extrait in extraits) {
      widgets.add(extrait);
    }
    return Column(children: widgets);
  }
}
