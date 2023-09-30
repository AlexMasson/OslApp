class Programme {
  final String nom;
  final String? lienPartitions;

  final List<String>? liensExtraits;

  Programme(this.nom, this.lienPartitions, this.liensExtraits);

  static String nomCsvField = 'Nom';
  static String lienPartitionsCsvField = 'Lien_Partitions';
  static String liensExtraits1CsvField = 'Lien_Extrait_1';
  static String liensExtraits2CsvField = 'Lien_Extrait_2';
  static String liensExtraits3CsvField = 'Lien_Extrait_3';
}
