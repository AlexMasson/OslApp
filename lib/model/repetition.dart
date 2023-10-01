class Repetition {
  final DateTime date;
  final String type;
  final String? lieu;
  final String? confirmation;
  final String? commentaire;
  final String? horaire;

  final List<String>? programmeList;

  Repetition(this.date, this.type, this.lieu, this.confirmation, this.commentaire, this.horaire, this.programmeList);

  static String dateCsvField = 'Date';
  static String typeCsvField = 'Type';
  static String lieuCsvField = 'Lieu';
  static String confirmationCsvField = 'Confirmation';
  static String commentaireCsvField = 'Commentaire';
  static String horaireCsvField = 'Horaire';
  static String programme1CsvField = 'Programme_1';
  static String programme2CsvField = 'Programme_2';
  static String programme3CsvField = 'Programme_3';
  static String programme4CsvField = 'Programme_4';
  static String programme5CsvField = 'Programme_5';
  static String programme6CsvField = 'Programme_6';
  static String programme7CsvField = 'Programme_7';
  static String programme8CsvField = 'Programme_8';
  static String programme9CsvField = 'Programme_9';
  static String programme10CsvField = 'Programme_10';
}
