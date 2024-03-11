import 'dart:convert';

import 'package:gestionresidencial/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class AuthenticatedUserdProvider extends StateNotifier<List<UserModel>> {
  final String endpoint = "https://backendmovil2-default-rtdb.firebaseio.com/";

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
}
