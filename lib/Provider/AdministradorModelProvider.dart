import 'dart:convert';

import 'package:gestionresidencial/Models/Administrador.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class AdministradorProvider extends StateNotifier<List<AdministradorModel>> {
  final String endpoint = "https://backendmovil2-default-rtdb.firebaseio.com/";
  AdministradorProvider(List<AdministradorModel> state) : super(state);

  Future<String> save(AdministradorModel data) async {
    try {
      final url = "$endpoint/Administrador.json";
      final response = await http.post(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        state = [...state, data];
        return jsonData['name'];
      } else {
        throw Exception("Error ${response.statusCode}");
      }
    } catch (e) {
      Exception(e);
      throw Exception("Error $e");
    }
  }

  Future<List<AdministradorModel>> getAll() async {
    try {
      final url = "$endpoint/Administrador.json";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        final listData = Administrador.fromJsonList(jsonData);
        state = listData.adminList;
        return listData.adminList;
      } else {
        throw Exception("Ocurrió algo ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<int> delete(String id) async {
    try {
      final url = '$endpoint/Administrador/$id.json';

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        state.removeWhere((admin) => admin.id == id);
        return 1;
      } else {
        throw Exception("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<bool> update(AdministradorModel data) async {
    try {
      final url = "$endpoint/Administrador.json";
      final response = await http.put(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        //final decodeData = jsonDecode(response.body);
        state[state.indexWhere((admin) => admin.id == data.id)] = data;
        return true;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}

//PrimayKey
final primaryKeyProvider = StateProvider<String>((ref) => "");

//