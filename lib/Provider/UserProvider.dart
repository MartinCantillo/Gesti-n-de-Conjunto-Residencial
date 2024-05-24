import 'dart:convert';

import 'package:gestionresidencial/Models/User.dart';

import 'package:http/http.dart' as http;

import 'package:riverpod/riverpod.dart';


class UserProvider extends StateNotifier<List<UserModel>> {
  final String endpoint = "https://georgx12.pythonanywhere.com/api";
  UserProvider(List<UserModel> state) : super(state);

  Future<String> saveUser(UserModel data) async {
    try {
      final url = "$endpoint/saveUser";
      print("Request URL: $url");
      print("Request Body: ${data.toJson()}");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
        },
        body: data.toJson(),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String userId = responseData['user_id'].toString();

          final newUser = UserModel(
            id: userId,
            username: data.username,
            password: data.password,
          );

          state = [...state, newUser];
          return "saved";

      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error $e");
    }
  }


  Future<List<UserModel>> getAll() async {
    try {
      final url = "$endpoint/GetAllUsers";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        final listData = User.fromJsonList(jsonData);
        state = listData.userList;
        return listData.userList;
      } else {
        throw Exception("Ocurrió algo ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<int> delete(String id) async {
    try {
      final url = '$endpoint/deleteUser';

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
      final url = "$endpoint/updateUser";
      final response = await http.put(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        //final decodeData = jsonDecode(response.body);
        state[state.indexWhere((user) => user.id == data.id)] = data;
        return true;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
 
}
