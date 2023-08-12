import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:osl/repetitions/repetitions_detail_component.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

import '../model/repetition.dart';
import '../repository/google_sheet_repository.dart';

class RepetitionsListComponent extends StatefulWidget {
  const RepetitionsListComponent({super.key});

  @override
  State<StatefulWidget> createState() => _RepetitionsListComponentState();
}

class _RepetitionsListComponentState extends State<RepetitionsListComponent> {
  List<Repetition>? repetitions;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    EasyLoading.show();
    repetitions = await fetchRepetitionsAsync();
    if (mounted) {
      EasyLoading.dismiss();
      super.setState(() {}); // to update widget data
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: repetitions?.length ?? 0,
        separatorBuilder: (context, index) {
          return const Divider(thickness: 0.4);
        },
        itemBuilder: (context, index) {
          return repetitions != null && repetitions!.isNotEmpty
              ? ListTile(
                  leading: SvgPicture.asset('icons/${getAssetFromRepetitionType(repetitions![index].type)}.svg', width: 30),
                  title: getTitle(repetitions![index]),
                  subtitle: getSubtitle(repetitions![index]),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RepetitionsDetailsComponent(repetition: repetitions![index])));
                  },
                )
              : null;
        });
  }

  String getAssetFromRepetitionType(String repetitionType) {
    switch (repetitionType) {
      case 'Tout le monde':
        return 'conductor';
      case 'Cuivres + Bois (Partiel)':
        return 'trumpet';
      case 'Cordes (Partiel)':
        return 'violin';
      default:
        return '';
    }
  }

  Row getTitle(Repetition repetition) {
    final date = DateFormat.yMMMMEEEEd('fr_FR').format(repetition.date);
    final lieu = repetition.lieu != null ? repetition.lieu! : 'Lieu non communiqué';

    return Row(children: [Text('$date | $lieu', style: const TextStyle(fontWeight: FontWeight.bold))]);
  }

  Row getSubtitle(Repetition repetition) {
    final confirmation = repetition.confirmation != null
        ? RoundedBackgroundText(repetition.confirmation!,
            backgroundColor: switch (repetition.confirmation) {
              'Confirmée' => Colors.green,
              'En attente de confirmation' => Colors.orange,
              'Annulée' => Colors.red,
              _ => Colors.grey
            },
            style: const TextStyle(color: Colors.white))
        : null;

    final type = Text(repetition.type);

    var items = <Widget>[];
    items.add(type);

    if (confirmation != null) {
      items.add(const SizedBox(width: 15));
      items.add(confirmation);
    }

    return Row(children: items);
  }
}
