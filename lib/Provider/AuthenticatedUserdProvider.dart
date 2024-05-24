import 'dart:convert';

import 'package:gestionresidencial/Models/User.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:http/http.dart' as http;

import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticatedUserdProvider extends StateNotifier<List<UserModel>> {
  final String endpoint = "https://georgx12.pythonanywhere.com/api/";

  AuthenticatedUserdProvider(List<UserModel> state) : super(state);

  Future<List<UserModel>> authenticate(String username, String password) async {
   
    try {
      final url = "$endpoint/Usuario.json";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        
        final authenticatedUser =
            User.fromJsonListUserAuthenticate(jsonData, username, password);
            if (authenticatedUser.usersAuthenticatedList.isEmpty) {
             throw Exception("No se encontraron usuarios autenticados.");
            }
          
        state = authenticatedUser.usersAuthenticatedList;
        return authenticatedUser.usersAuthenticatedList;
      } else {
        throw Exception("Ocurrió algo ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
  Future<List<UserModel>?> authenticateUser(String username, String password) async {
  try {
    final url = "$endpoint/login";
    final response = await http.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      final userId = responseData['user_id'].toString(); // Obtener el ID del usuario de la respuesta


      final prefs = PrefernciaUsuario();
      prefs.token = token; // Guardar el token en SharedPreferences

      return [UserModel(id: userId, username: username, password: password)]; // Devuelve el usuario autenticado con el ID
    } else {
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Error $e");
  }
}
}
