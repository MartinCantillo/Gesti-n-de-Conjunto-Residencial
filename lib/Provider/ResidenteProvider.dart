import 'dart:convert';

import 'package:gestionresidencial/Models/Residente.dart';

import 'package:http/http.dart' as http;

import 'package:riverpod/riverpod.dart';

class ResidenteProvider extends StateNotifier<List<ResidenteModel>> {
  final String endpoint = "https://georgx12.pythonanywhere.com/api/";
  ResidenteProvider(List<ResidenteModel> state) : super(state);

  Future<String> save(ResidenteModel data) async {
    try {
      final url = "$endpoint/saveResidente";
      final response = await http.post(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
        }, body: data.toJson());
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        state = [...state, data];
        return jsonData['name'];
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
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
  Future<List<ResidenteModel>> getResidenteById(String idUser) async {
    
    try {
      final url = '$endpoint/GetResidenteById';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        
        // Verificar si el cuerpo de la respuesta está vacío
        if (jsonData == null || jsonData.isEmpty) {
          throw Exception("Respuesta null");
        }

        // Verificar si alguno de los documentos contiene el idUser
        final listData = Residente.fromJsonListById(jsonData, idUser);

        if (listData.residenteListbyUser.isEmpty) {
          throw Exception(" No se encontraron anomalías para el idUser");
        }
        
        state = listData.residenteListbyUser;
        return listData.residenteListbyUser;
      } else {
        throw Exception("Ocurrió algo ${response.statusCode}");
      }
    } catch (e) {
      throw Exception (e);
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
        state[state.indexWhere(
            (residente) => residente.id == data.id)] = data;
        return true;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}

