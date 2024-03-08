import 'dart:convert';

import 'package:gestionresidencial/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class UserProvider extends StateNotifier<List<UserModel>> {
  final String endpoint = "https://backendmovil2-default-rtdb.firebaseio.com/";
  UserProvider(List<UserModel> state) : super(state);

  Future<String> save(UserModel data) async {
    try {
      final url = "$endpoint/Usuario.json";
      final response = await http.post(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        state = [...state, data];
        return jsonData;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<List<UserModel>> getAll() async {
    try {
      final url = "$endpoint/Usuario.json";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        final listData = User.fromJsonList(jsonData);
        state = listData.UserList;
        return listData.UserList;
      } else {
        throw Exception("Ocurrió algo ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<int> delete(String id) async {
    try {
      final url = '$endpoint/Usuario/$id.json';

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        state.removeWhere((user) => user.id == id);
        return 1;
      } else {
        throw Exception("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<bool> update(UserModel data) async {
    try {
      final url = "$endpoint/Usuario.json";
      final response = await http.put(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        //final decodeData = jsonDecode(response.body);
        state[state.indexWhere((user) => user.id == data.id)] =
            data;
        return true;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}
