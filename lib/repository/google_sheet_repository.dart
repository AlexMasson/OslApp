import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:csv/csv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:osl/model/concert.dart';
import 'package:osl/model/programme.dart';

import '../model/repetition.dart';

final client = Client();

Future<List<Repetition>> fetchRepetitionsAsync() async {
  final url = Uri.parse('${dotenv.env['REPETITIONS_CSV_URL']}&version=${DateTime.now().toIso8601String()}');
  final response = await client.get(url);

  final repetitionsRaw = const CsvToListConverter().convert(utf8.decode(response.bodyBytes), eol: "\n", fieldDelimiter: ',');

  var fieldsMap = HashMap<String, int>();
  var fieldIndex = 0;
  for (var header in repetitionsRaw[0]) {
    fieldsMap[header.toString().trim()] = fieldIndex;
    fieldIndex++;
  }

  repetitionsRaw.removeAt(0);

  var repetitions = <Repetition>[];
  for (var item in repetitionsRaw) {
    try {
      final date = DateFormat('dd-MM-yyyy').parse(item[fieldsMap[Repetition.dateCsvField]!]);
      final type = item[fieldsMap[Repetition.typeCsvField]!].toString().trim();
      final lieu = item[fieldsMap[Repetition.lieuCsvField]!].toString().trim();
      final adresse = item[fieldsMap[Repetition.adresseCsvField]!].toString().trim();
      final confirmation = item[fieldsMap[Repetition.confirmationCsvField]!].toString().trim();
      final commentaireImportant = item[fieldsMap[Repetition.commentaireImportantCsvField]!].toString().trim();
      final commentaire = item[fieldsMap[Repetition.commentaireCsvField]!].toString().trim();
      final horaire = item[fieldsMap[Repetition.horaireCsvField]!].toString().trim();

      var programmeList = <String>[];
      void addProgrammeIfNotEmpty(dynamic programme) {
        var programmeStr = programme?.toString().trim();
        if (programmeStr != null && programmeStr.isNotEmpty) {
          programmeList.add(programmeStr);
        }
      }

      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme1CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme2CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme3CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme4CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme5CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme6CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme7CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme8CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme9CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Repetition.programme10CsvField]!]);

      if (type != '') {
        repetitions.add(Repetition(date, type, lieu, adresse, confirmation, commentaireImportant, commentaire, horaire, programmeList));
      }
    } catch (ex) {
      developer.log('Unable to load repetition.');
      developer.log(ex.toString());
    }
  }

  // Filter date in the past, then sort by date ascending
  repetitions = repetitions.where((element) => element.date.add(const Duration(days: 1)).isAfter(DateTime.now())).toList();
  repetitions.sort((a, b) => a.date.compareTo(b.date));
  return repetitions;
}

Future<List<Programme>> fetchProgrammeAsync() async {
  final url = Uri.parse('${dotenv.env['PROGRAMME_CSV_URL']}&version=${DateTime.now().toIso8601String()}');
  final response = await client.get(url);

  final programmeRaw = const CsvToListConverter().convert(utf8.decode(response.bodyBytes), eol: "\n", fieldDelimiter: ',');

  var fieldsMap = HashMap<String, int>();
  var fieldIndex = 0;
  for (var header in programmeRaw[0]) {
    fieldsMap[header.toString().trim()] = fieldIndex;
    fieldIndex++;
  }

  programmeRaw.removeAt(0);

  var programmeList = <Programme>[];
  for (var item in programmeRaw) {
    try {
      final nom = item[fieldsMap[Programme.nomCsvField]!].toString().trim();
      final lienPartitions = item[fieldsMap[Programme.lienPartitionsCsvField]!].toString().trim();

      var liensExtraits = <String>[];
      void addExtraitIfNotEmpty(dynamic extrait) {
        var extraitStr = extrait?.toString().trim();
        if (extraitStr != null && extraitStr.isNotEmpty) {
          liensExtraits.add(extraitStr);
        }
      }

      addExtraitIfNotEmpty(item[fieldsMap[Programme.liensExtraits1CsvField]!]);
      addExtraitIfNotEmpty(item[fieldsMap[Programme.liensExtraits2CsvField]!]);
      addExtraitIfNotEmpty(item[fieldsMap[Programme.liensExtraits3CsvField]!]);

      if (nom != '') {
        programmeList.add(Programme(nom, lienPartitions, liensExtraits));
      }
    } catch (ex) {
      developer.log('Unable to load programme.');
      developer.log(ex.toString());
    }
  }

  programmeList.sort((a, b) => a.nom.compareTo(b.nom));
  return programmeList;
}

Future<List<Concert>> fetchConcertsAsync() async {
  final url = Uri.parse('${dotenv.env['CONCERTS_CSV_URL']}&version=${DateTime.now().toIso8601String()}');
  final response = await client.get(url);

  final concertsRaw = const CsvToListConverter().convert(utf8.decode(response.bodyBytes), eol: "\n", fieldDelimiter: ',');

  var fieldsMap = HashMap<String, int>();
  var fieldIndex = 0;
  for (var header in concertsRaw[0]) {
    fieldsMap[header.toString().trim()] = fieldIndex;
    fieldIndex++;
  }

  concertsRaw.removeAt(0);

  var concerts = <Concert>[];
  for (var item in concertsRaw) {
    try {
      final date = DateFormat('dd-MM-yyyy').parse(item[fieldsMap[Concert.dateCsvField]!]);
      final nom = item[fieldsMap[Concert.nomCsvField]!].toString().trim();
      final confirmation = item[fieldsMap[Concert.confirmationCsvField]!].toString().trim();
      final adresse = item[fieldsMap[Concert.adresseCsvField]!].toString().trim();
      final heureArriveeMusiciens = item[fieldsMap[Concert.heureArriveeMusiciensCsvField]!].toString().trim();
      final heureConcert = item[fieldsMap[Concert.heureConcertCsvField]!].toString().trim();
      final commentaireImportant = item[fieldsMap[Concert.commentaireImportantCsvField]!].toString().trim();
      final commentaire = item[fieldsMap[Concert.commentaireCsvField]!].toString().trim();

      var programmeList = <String>[];
      void addProgrammeIfNotEmpty(dynamic programme) {
        var programmeStr = programme?.toString().trim();
        if (programmeStr != null && programmeStr.isNotEmpty) {
          programmeList.add(programmeStr);
        }
      }

      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme1CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme2CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme3CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme4CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme5CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme6CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme7CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme8CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme9CsvField]!]);
      addProgrammeIfNotEmpty(item[fieldsMap[Concert.programme10CsvField]!]);

      if (nom != '') {
        concerts
            .add(Concert(date, nom, confirmation, adresse, heureArriveeMusiciens, heureConcert, commentaireImportant, commentaire, programmeList));
      }
    } catch (ex) {
      developer.log('Unable to load concert.');
      developer.log(ex.toString());
    }
  }

  // Filter date in the past, then sort by date ascending
  concerts = concerts.where((element) => element.date.add(const Duration(days: 1)).isAfter(DateTime.now())).toList();
  concerts.sort((a, b) => a.date.compareTo(b.date));
  return concerts;
}
