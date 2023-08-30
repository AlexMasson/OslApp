import 'dart:convert';
import 'dart:developer' as developer;

import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:osl/model/concert.dart';
import 'package:osl/model/programme.dart';

import '../model/repetition.dart';

final client = Client();

Future<List<Repetition>> fetchRepetitionsAsync() async {
  final url = Uri.parse(
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSuC7HuQ64pXsuc008pSXuMZfCWys5wNR-qXmrIUEidi2VJOyFNbWLln3DQr5zegQMpRXVAXp9jkwVY/pub?output=csv&version=${DateTime.now().toIso8601String()}');
  final response = await client.get(url);

  final repetitionsRaw = const CsvToListConverter().convert(utf8.decode(response.bodyBytes), eol: "\n", fieldDelimiter: ',');

  repetitionsRaw.removeAt(0);

  var repetitions = <Repetition>[];
  for (var item in repetitionsRaw) {
    try {
      final date = DateFormat('dd-MM-yyyy').parse(item[0]);
      final type = item[1].toString().trim();
      final lieu = item[2].toString().trim();
      final confirmation = item[3].toString().trim();
      final commentaire = item[4].toString().trim();
      final horaire = item[5].toString().trim();

      var programmeList = <String>[];
      for (var i = 6; i < 16; i++) {
        programmeList.add(item[i].toString().trim());
      }

      if (type != '') {
        repetitions.add(Repetition(date, type, lieu, confirmation, commentaire, horaire, programmeList));
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
  final url = Uri.parse(
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vTtXBw2uW3QM-QTbjoaVt6dLi3lxdFWSapzL3pS_2WFh1jzGfAaq8d1uMDgCVzBliqgPzQj6eQySHde/pub?output=csv&version=${DateTime.now().toIso8601String()}');
  final response = await client.get(url);

  final programmeRaw = const CsvToListConverter().convert(utf8.decode(response.bodyBytes), eol: "\n", fieldDelimiter: ',');

  programmeRaw.removeAt(0);

  var programmeList = <Programme>[];
  for (var item in programmeRaw) {
    try {
      final nom = item[0].toString().trim();
      final lienPartitions = item[1].toString().trim();

      var liensExtraits = <String>[];
      for (var i = 2; i < 5; i++) {
        liensExtraits.add(item[i].toString().trim());
      }

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
  final url = Uri.parse(
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vS0JFtNhDQiSZnIgCS8ROalyyuiXL8gf82-BZCTu12yj_mkcxKOGmuW4KvNrhBi5bYkupjKBlITJ5wl/pub?output=csv&version=${DateTime.now().toIso8601String()}');
  final response = await client.get(url);

  final concertsRaw = const CsvToListConverter().convert(utf8.decode(response.bodyBytes), eol: "\n", fieldDelimiter: ',');

  concertsRaw.removeAt(0);

  var concerts = <Concert>[];
  for (var item in concertsRaw) {
    try {
      final date = DateFormat('dd-MM-yyyy').parse(item[0]);
      final nom = item[1].toString().trim();
      final confirmation = item[2].toString().trim();
      final adresse = item[3].toString().trim();
      final heureArriveeMusiciens = item[4].toString().trim();
      final heureConcert = item[5].toString().trim();
      final commentaire = item[6].toString().trim();

      var programmeList = <String>[];
      for (var i = 7; i < 17; i++) {
        programmeList.add(item[i].toString().trim());
      }

      if (nom != '') {
        concerts.add(Concert(date, nom, confirmation, adresse, heureArriveeMusiciens, heureConcert, commentaire, programmeList));
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
