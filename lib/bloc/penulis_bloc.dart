import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/penulis.dart';

class PenulisBloc {
  static Future<List<Penulis>> getPenulis() async {
    String apiUrl = ApiUrl.listPenulis;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listPenulis = (jsonObj as Map<String, dynamic>)['data'];
    List<Penulis> penulis = [];
    for (int i = 0; i < listPenulis.length; i++) {
      penulis.add(Penulis.fromJson(listPenulis[i]));
    }
    return penulis;
  }

  static Future addPenulis({Penulis? penulis}) async {
    String apiUrl = ApiUrl.createPenulis;

    var body = {
      "author_name": penulis!.author_name,
      "nationality": penulis.nationality,
      "birth_year": penulis.birth_year.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updatePenulis({required Penulis penulis}) async {
    String apiUrl = ApiUrl.updatePenulis(penulis.id!);
    print(apiUrl);

    var body = {
      "author_name": penulis.author_name,
      "nationality": penulis.nationality,
      "birth_year": penulis.birth_year
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deletePenulis({int? id}) async {
    String apiUrl = ApiUrl.deletePenulis(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
