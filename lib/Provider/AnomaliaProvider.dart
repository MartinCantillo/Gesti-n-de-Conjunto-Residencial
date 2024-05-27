import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:gestionresidencial/localstore/sharepreference.dart';

import 'package:http/http.dart' as http;

import 'package:riverpod/riverpod.dart';



class AnomaliaProvider extends StateNotifier<List<AnomaliaModel>> {
  final PrefernciaUsuario prefs = PrefernciaUsuario();
  final String endpoint = "https://georgx12.pythonanywhere.com/api";
  AnomaliaProvider(List<AnomaliaModel> state) : super(state);

  Future<String> save(AnomaliaModel data) async {
    try {
      final url = "$endpoint/saveAnomalia";
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
      throw Exception("Error $e");
    }
  }
  
  Future<String> getToken() async {
    await prefs.initPrefs();
    return prefs.token;
  }

  Future<void> saveAnomalia(AnomaliaModel anomalia, String token) async {
    try {
      final url = "$endpoint/saveAnomalia";
      final anomaliaJson = jsonEncode(anomalia.toMap());

      print("Token de autenticación: $token");

      final response = await http.post(
        Uri.parse(url),
        body: anomaliaJson, 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
     // print("Código de estado de la respuesta: ${response.statusCode}");
      if (response.statusCode == 200) {
        state = [...state, anomalia];
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      
      throw Exception("Error $e");
    }
  }


  Future<List<AnomaliaModel>> getAll(String token) async {
  try {
    final url = "$endpoint/GetAllAnomalias"; // Endpoint correcto para obtener todas las anomalías
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Agregar el token en los encabezados de la solicitud
      },
    );
  //  print(response.body);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      final listData = Anomalia.fromJsonList(jsonData);
      state = listData.anomaliaList;
      return listData.anomaliaList;
    } else {
      throw Exception("Ocurrió algo ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error $e");
  }
}


  Future<List<AnomaliaModel>> getAnomaliaById(String idUser, String token) async {
  try {
    final url = '$endpoint/getAnomaliasByUserId?idUser=$idUser';
   // print("URL de getAnomaliaById: $url");
    print("Datos enviados: idUser=$idUser, token=$token");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

   // print("Código de estado de la respuesta: ${response.statusCode}");

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      final listData = Anomalia.fromJsonList(jsonData);
      return listData.anomaliaList; // Cambiar para devolver la lista correcta
    } else {
      throw Exception("Ocurrió algo ${response.statusCode}");
    }
  } catch (e) {
   // print("Excepción en getAnomaliaById: $e");
    throw Exception("Error $e");
  }
}



  Future<int> delete(String id, String token) async {
  try {
    final url = '$endpoint/deleteAnomalia';

    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'},
      
      body: jsonEncode({'id': id}), // Asegurarse de que los datos están en formato JSON
    );

    if (response.statusCode == 200) {
      state.removeWhere((anomalia) => anomalia.id == id);
      return 1;
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error $e");
  }
}

  Future<bool> update(String id, AnomaliaModel data, String token) async {
  try {
    final url = '$endpoint/updateAnomalia';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data.toMap()), // Asegurarse de que los datos están en formato JSON
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print(response.body);
    print("Request Body: ${data.toJson()}");
    if (response.statusCode == 200) {
      state[state.indexWhere((anomalia) => anomalia.id == data.id)] = data;
      return true;
    } else {
      throw Exception("Error ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error $e");
  }
}


  
}

