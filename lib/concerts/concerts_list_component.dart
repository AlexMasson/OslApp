import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:osl/concerts/concerts_detail_component.dart';
import 'package:osl/model/concert.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

import '../repository/google_sheet_repository.dart';

class ConcertsListComponent extends StatefulWidget {
  const ConcertsListComponent({super.key});

  @override
  State<StatefulWidget> createState() => _ConcertsListComponentState();
}

class _ConcertsListComponentState extends State<ConcertsListComponent> {
  List<Concert>? concerts;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    EasyLoading.show();
    concerts = await fetchConcertsAsync();
    if (mounted) {
      EasyLoading.dismiss();
      super.setState(() {}); // to update widget data
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.separated(
            itemCount: concerts?.length ?? 0,
            separatorBuilder: (context, index) {
              return const Divider(thickness: 0.4);
            },
            itemBuilder: (context, index) {
              return concerts != null && concerts!.isNotEmpty
                  ? ListTile(
                      leading: const Icon(Icons.star, size: 30),
                      title: getTitle(concerts![index]),
                      subtitle: getSubtitle(concerts![index]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConcertsDetailsComponent(concert: concerts![index])));
                      },
                    )
                  : null;
            },
            physics: const AlwaysScrollableScrollPhysics()),
        onRefresh: () async {
          concerts = await fetchConcertsAsync();
          super.setState(() {}); // to update widget data
        });
  }

  Row getTitle(Concert concert) {
    final date = DateFormat.yMMMMEEEEd('fr_FR').format(concert.date);

    return Row(children: [Text(date, style: const TextStyle(fontWeight: FontWeight.bold))]);
  }

  Row getSubtitle(Concert concert) {
    final confirmation = concert.confirmation != null && concert.confirmation!.isNotEmpty
        ? RoundedBackgroundText(concert.confirmation!,
            backgroundColor: switch (concert.confirmation) {
              'Confirmé' => Colors.green,
              'En attente de confirmation' => Colors.orange,
              'Annulé' => Colors.red,
              _ => Colors.grey
            },
            style: const TextStyle(color: Colors.white))
        : null;

    final commentaireImportant = concert.commentaireImportant != null && concert.commentaireImportant!.isNotEmpty
        ? RoundedBackgroundText(concert.commentaireImportant!,
            backgroundColor: Colors.yellow, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
        : null;

    var items = <Widget>[];

    if (commentaireImportant != null) {
      items.add(commentaireImportant);
      items.add(const SizedBox(width: 15));
    }

    items.add(Text(concert.nom));

    if (confirmation != null) {
      items.add(const SizedBox(width: 15));
      items.add(confirmation);
    }

    return Row(children: items);
  }
}
