
import 'dart:convert';

List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  Article({
    required this.id,
    required this.artnr,
    required this.artnaam,
    required this.levId,
    required this.artpr,
  });

  String id;
  String artnr;
  String artnaam;
  String levId;
  String artpr;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["ID"],
    artnr: json["Artnr"],
    artnaam: json["Artnaam"],
    levId: json["LevID"],
    artpr: json["Artpr"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Artnr": artnr,
    "Artnaam": artnaam,
    "LevID": levId,
    "Artpr": artpr,
  };
}