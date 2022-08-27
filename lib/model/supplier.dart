import 'dart:convert';

List<Supplier> supplierFromJson(String str) => List<Supplier>.from(json.decode(str).map((x) => Supplier.fromJson(x)));

String supplierToJson(List<Supplier> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supplier {
  Supplier({
    required this.id,
    required this.levnr,
    required this.levname,
    required this.levadres,
  });

  String id;
  String levnr;
  String levname;
  String levadres;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["ID"],
    levnr: json["Levnr"],
    levname: json["Levname"],
    levadres: json["Levadres"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Levnr": levnr,
    "Levname": levname,
    "Levadres": levadres,
  };
}
