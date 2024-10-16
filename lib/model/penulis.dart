class Penulis {
  int? id;
  String? author_name;
  String? nationality;
  int? birth_year;
  Penulis({this.id, this.author_name, this.nationality, this.birth_year});
  factory Penulis.fromJson(Map<String, dynamic> obj) {
    return Penulis(
        id: obj['id'],
        author_name: obj['author_name'],
        nationality: obj['nationality'],
        birth_year: obj['birth_year']);
  }
}
