import 'dart:convert';

import 'package:gestionresidencial/Models/Residente.dart';

import 'package:http/http.dart' as http;

import 'package:riverpod/riverpod.dart';

import 'package:gestionresidencial/localstore/sharepreference.dart';

class ResidenteProvider extends StateNotifier<List<ResidenteModel>> {
  final String endpoint = "https://georgx12.pythonanywhere.com/api";
  ResidenteProvider(List<ResidenteModel> state) : super(state);
  final PrefernciaUsuario prefs = PrefernciaUsuario();

  Future<String> getToken() async {
    await prefs.initPrefs();
    return prefs.token;
  }

  Future<String> save(ResidenteModel data) async {
    try {
      final url = "$endpoint/saveResidente";
      print("Request Body: ${data.toJson()}");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: data.toJson(),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String residenteId = responseData['residente_id'].toString();
        final String idUser = responseData['idUser'].toString();

        final newResidente = ResidenteModel(
          id: residenteId,
          nombreResidente: data.nombreResidente,
          apellidoResidente: data.apellidoResidente,
          numApartamento: data.numApartamento,
          numTelefono: data.numTelefono,
          idUser: idUser,
        );

        state = [...state, newResidente];
        return residenteId;
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Error: $e");
    }
  }

  Future<List<ResidenteModel>> getAll() async {
    try {
      final url = "$endpoint/GetAllresidentes";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        final listData = Residente.fromJsonList(jsonData);
        state = listData.residenteList;
        return listData.residenteList;
      } else {
        throw Exception("Ocurrió algo ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

 Future<List<ResidenteModel>> getResidenteById(String idUser, String token) async {
  try {
    final url = '$endpoint/GetResidenteById';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'IdUser': idUser}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      
      try {
        final residente = ResidenteModel.fromJson(body); // Convierte el JSON a un objeto
        return [residente]; // Retorna una lista con un solo elemento
      } catch (e) {
        throw Exception("Error al procesar los datos: $e");
      }
    } else {
      throw Exception("Ocurrió algo ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error $e");
  }
}



  Future<int> delete(String id) async {
    try {
      final url = '$endpoint/deleteResidente';

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        state.removeWhere((residente) => residente.id == id);
        return 1;
      } else {
        throw Exception("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<bool> update(ResidenteModel data) async {
    try {
      final url = "$endpoint/updateResidente";
      final response = await http.put(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        //final decodeData = jsonDecode(response.body);
        state[state.indexWhere((residente) => residente.id == data.id)] = data;
        return true;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}
