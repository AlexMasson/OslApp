import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:osl/repetitions/repetitions-detail-component.dart';

import '../model/repetition.dart';
import '../repository/google-sheet-repository.dart';

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
    EasyLoading.dismiss();
    super.setState(() {}); // to update widget data
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
                  leading: repetitions![index].lieuConfirme
                      ? Container(height: 20, width: 20, decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(100)))
                      : Container(height: 20, width: 20, decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(100))),
                  title: Text(DateFormat.yMMMMEEEEd('fr_FR').format(repetitions![index].date), style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(repetitions![index].lieu),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RepetitionsDetailsComponent(repetition: repetitions![index])));
                  },
                )
              : null;
        });
  }
}
