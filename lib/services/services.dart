import 'dart:convert';
import 'dart:ffi';

import 'package:customer_management_system/model/article.dart';
import 'package:customer_management_system/model/supplier.dart';
import 'package:customer_management_system/model/users.dart';
import 'package:http/http.dart' as http;
import '../model/client.dart';

class Services {
  static const SERVER = "https://laptopdefect.be/cms/";
  static const Add_LINK = SERVER+'addClient.php';
  static const Get_LINK = SERVER+'getAll.php';
  static const Login_LINK = SERVER+'login.php';
  static const Get_Client_LINK = SERVER+'getClient.php';
  static const Delete_Client_LINK =
      SERVER+'deleteClient.php';
  static const Update_Client_LINK =
      SERVER+'updateClient.php';
  static const Add_Supplier_LINK =
      SERVER+'addSupplier.php';
  static const Get_All_Supplier_LINK =
      SERVER+'getAllSuppliers.php';
  static const Update_Supplier_LINK =
      SERVER+'updateSupplier.php';
  static const Get_Supplier_LINK =
      SERVER+'getSupplier.php';
  static const Delete_Supplier_LINK =
      SERVER+'deleteSupplier.php';
  static const Add_Article_LINK =
      SERVER+'addArticle.php';
  static const Get_All_Article_LINK =
      SERVER+'getAllArticles.php';
  static const Get_Article_LINK =
      SERVER+'getArticle.php';
  static const Delete_Article_LINK =
      SERVER+'deleteArticle.php';
  static const Update_Article_LINK =
      SERVER+'updateArticle.php';

  static const Add_Sale_LINK =
      SERVER+'addSale.php';

  static const _Add_Client = 'add_client';
  static const _Get_Clients = 'get_clients';

  static Future<String> addClient(
      String clnr, String clname, String claddress) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _Add_Client;
      map["clnr"] = clnr;
      map["clname"] = clname;
      map["claddress"] = claddress;
      final response = await http.post(Uri.parse(Add_LINK), body: map);
      print("Add client >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'Error';
    }
  }

  static Future<String> addSupplier(
      String levnr, String levname, String levadres) async {
    var map = <String, dynamic>{};
    map["levnr"] = levnr;
    map["levname"] = levname;
    map["levadres"] = levadres;
    final response = await http.post(Uri.parse(Add_Supplier_LINK), body: map);
    print("adding Supplier => ${response.body}");
    return response.body;
  }
  static Future<String> addSale(String client,String article,String price)async{
    var map = <String,dynamic>{};
    map["client_id"] = client;
    map["art_id"] = article;
    map["art"] = price;
    print(price);
    final respnse = await http.post(Uri.parse(Add_Sale_LINK),body: map);
    return respnse.body;
  }
  static Future<String> addArticle(String artnr,String artnaam,String levid,String artpr)async{
    var map = <String,dynamic>{};
    map["artnr"] = artnr;
    map["artnaam"] = artnaam;
    map["levid"] = levid;
    map["artpr"] = artpr;
    final response = await http.post(Uri.parse(Add_Article_LINK), body: map);
    return response.body;
  }

  static Future<List<Client>> getClients() async {
    var map = <String, dynamic>{};
    map["action"] = _Get_Clients;
    final response = await http.get(Uri.parse(Get_LINK));
    if (response.body.isNotEmpty) {
      return clientFromJson(response.body);
    }
    return <Client>[];
  }


  static Future<List<Supplier>> getAllSuppliers() async {
    final response = await http.get(Uri.parse(Get_All_Supplier_LINK));
    if (response.body.isNotEmpty) {
      return supplierFromJson(response.body);
    }
    return <Supplier>[];
  }
  static Future<List<Article>> getAllArticles()async{
    final response = await http.get(Uri.parse(Get_All_Article_LINK));
    if (response.body.isNotEmpty) {
      return articleFromJson(response.body);
    }
    return <Article>[];
  }

  static Future<List<User>> isValidUser(
      String username, String password) async {
    var map = <String, dynamic>{};
    map["username"] = username;
    map["password"] = password;
    final response = await http.post(Uri.parse(Login_LINK), body: map);
    print(response.body);
    if (response.body.isNotEmpty) {
      return userFromJson(response.body);
    }
    return <User>[];
  }

  static Future<List<Client>> getClient(String number) async {
    var map = <String, dynamic>{};
    map["clientNumber"] = number;
    final response = await http.post(Uri.parse(Get_Client_LINK), body: map);
    print(response.body);
    if (response.body.isNotEmpty) {
      return clientFromJson(response.body);
    }
    return <Client>[];
  }

  static Future<List<Supplier>> getSupplier(String levnr) async {
    var map = <String, dynamic>{};
    map["levnr"] = levnr;
    final response = await http.post(Uri.parse(Get_Supplier_LINK), body: map);
    print(response.body);
    if (response.body.isNotEmpty) {
      return supplierFromJson(response.body);
    }
    return <Supplier>[];
  }
  static Future<List<Article>> getArticle(String artnr)async{
    var map = <String,dynamic>{};
    map["artnr"] = artnr;
    final response = await http.post(Uri.parse(Get_Article_LINK),body: map);
    print(response.body);
    if(response.body.isNotEmpty){
      return articleFromJson(response.body);
    }
    return <Article>[];
  }

  static Future<String> deleteClient(String id) async {
    var map = <String, dynamic>{};
    map["id"] = id;
    final response = await http.post(Uri.parse(Delete_Client_LINK), body: map);
    print("Deleted => ${response.body}");
    return response.body;
  }

  static Future<String> deleteArticle(String id)async{
    var map = <String,dynamic>{};
    map["id"] = id;
    final response = await http.post(Uri.parse(Delete_Article_LINK),body: map);
    return response.body;
  }

  static Future<String> deleteSupplier(String id) async {
    var map = <String, dynamic>{};
    map["id"] = id;
    final response =
        await http.post(Uri.parse(Delete_Supplier_LINK), body: map);
    return response.body;
  }

  static Future<String> updateClient(
      String id, String number, String name, String address) async {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["clnr"] = number;
    map["clname"] = name;
    map["claddress"] = address;
    final response = await http.post(Uri.parse(Update_Client_LINK), body: map);
    print("updated => ${response.body}");
    return response.body;
  }
  static Future<String> updateArticle(String id,String artnr,String artnaam,String levid,String artpr)async{
    var map = <String,dynamic>{};
    map["id"] = id;
    map["artnr"] = artnr;
    map["artnaam"] = artnaam;
    map["levid"] = levid;
    map["artpr"] = artpr;
    final response = await http.post(Uri.parse(Update_Article_LINK), body: map);
    return response.body;
  }

  static Future<String> updateSupplier(
      String id, String levnr, String levname, String levadres) async {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["levnr"] = levnr;
    map["levname"] = levname;
    map["levadres"] = levadres;
    final response =
        await http.post(Uri.parse(Update_Supplier_LINK), body: map);
    print("update supplier => ${response.body}");
    return response.body;
  }
}
