import 'dart:convert';

import 'package:gestionresidencial/Models/Anomalia.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class AnomaliaProvider extends StateNotifier<List<AnomaliaModel>> {
  final String endpoint = "https://backendmovil2-default-rtdb.firebaseio.com/";
  AnomaliaProvider(List<AnomaliaModel> state) : super(state);

  Future<String> save(AnomaliaModel data) async {
    try {
      final url = "$endpoint/Anomalia.json";
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

  Future<List<AnomaliaModel>> getAll() async {
    print("getallaentro");
    try {
      final url = "$endpoint/Anomalia.json";
      final response = await http.get(Uri.parse(url));
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

  Future<List<AnomaliaModel>> getAnomaliaById(String idUser) async {
    
    try {
      final url = '$endpoint/Anomalia.json';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        
        // Verificar si el cuerpo de la respuesta está vacío
        if (jsonData == null || jsonData.isEmpty) {
          throw Exception("Respuesta null");
        }

        // Verificar si alguno de los documentos contiene el idUser
        final listData = Anomalia.fromJsonListById(jsonData, idUser);

        if (listData.anomaliaListByUser.isEmpty) {
          throw Exception(" No se encontraron anomalías para el idUser");
        }
        
        state = listData.anomaliaListByUser;
        return listData.anomaliaListByUser;
      } else {
        throw Exception("Ocurrió algo ${response.statusCode}");
      }
    } catch (e) {
      throw Exception (e);
    }
  }

  Future<int> delete(String id) async {
    try {
      final url = '$endpoint/Anomalia/$id.json';

      final response = await http.delete(Uri.parse(url));

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

  Future<bool> update(AnomaliaModel data) async {
    try {
      final url = "$endpoint/Anomalia.json";
      final response = await http.put(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        //final decodeData = jsonDecode(response.body);
        state[state.indexWhere((anomalia) => anomalia.id == data.id)] = data;
        return true;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}
