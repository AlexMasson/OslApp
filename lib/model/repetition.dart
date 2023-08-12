class Repetition {
  final DateTime date;
  final String type;
  final String? lieu;
  final String? confirmation;
  final String? commentaire;
  final String? horaire;

  final List<String>? programmeList;

  Repetition(this.date, this.type, this.lieu, this.confirmation, this.commentaire, this.horaire, this.programmeList);
}
