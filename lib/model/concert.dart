class Concert {
  final DateTime date;
  final String nom;
  final String? confirmation;
  final String? adresse;
  final String? heureArriveeMusiciens;
  final String? heureConcert;
  final String? commentaire;

  final List<String>? programmeList;

  Concert(this.date, this.nom, this.confirmation, this.adresse, this.heureArriveeMusiciens, this.heureConcert, this.commentaire, this.programmeList);

  static String dateCsvField = 'Date';
  static String nomCsvField = 'Nom';
  static String confirmationCsvField = 'Confirmation';
  static String adresseCsvField = 'Adresse';
  static String heureArriveeMusiciensCsvField = 'Heure arrivée musiciens';
  static String heureConcertCsvField = 'Heure concert';
  static String commentaireCsvField = 'Commentaire';
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
