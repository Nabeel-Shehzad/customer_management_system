import 'dart:convert';

List<Client> clientFromJson(String str) => List<Client>.from(json.decode(str).map((x) => Client.fromJson(x)));

String clientToJson(List<Client> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Client {
  Client({
    required this.id,
    required this.cLnr,
    required this.cLname,
    required this.clAdres,
  });

  String id;
  String cLnr;
  String cLname;
  String clAdres;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["ID"],
    cLnr: json["CLnr"],
    cLname: json["CLname"],
    clAdres: json["CL adres"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CLnr": cLnr,
    "CLname": cLname,
    "CL adres": clAdres,
  };
}
