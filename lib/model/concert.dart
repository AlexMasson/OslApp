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
}
