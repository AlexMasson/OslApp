import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../model/repetition.dart';

final client = Client();

Future<List<Repetition>> fetchRepetitionsAsync() async {
  final url = Uri.parse(
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vQNB-kUvZtTUSBMKoA2t0bZJRamP167JYV0s9q4OuR2FwNHwn4pmZwQTGN1XG71Gv17lIgfyfvPmQj5/pub?output=csv&version=${DateTime.now().toIso8601String()}');
  final response = await client.get(url);

  final repetitionsRaw = const CsvToListConverter().convert(utf8.decode(response.bodyBytes), eol: "\n", fieldDelimiter: ',');

  repetitionsRaw.removeAt(0);

  var repetitions = <Repetition>[];
  for (var item in repetitionsRaw) {
    final date = DateFormat('dd-MM-yyyy').parse(item[0]);
    final lieu = item[1].toString().trim();
    final lieuConfirme = item[2].toString().trim() == 'Ok';

    if (lieu != '') {
      repetitions.add(Repetition(date, lieu, lieuConfirme));
    }
  }

  // Filter date in the past, then sort by date ascending
  repetitions.where((element) => element.date.isAfter(DateTime.now())).toList().sort((a, b) => a.date.compareTo(b.date));
  return repetitions;
}
