import 'dart:convert';

import 'package:gestionresidencial/Models/EstadoAnomalia.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class EstadoAnomaliaProvider extends StateNotifier<List<EstadoAnomaliaModel>> {
  final String endpoint = "https://backendmovil2-default-rtdb.firebaseio.com/";
  EstadoAnomaliaProvider(List<EstadoAnomaliaModel> state) : super(state);

  Future<String> save(EstadoAnomaliaModel data) async {
    try {
      final url = "$endpoint/EstadoAnomalia.json";
      final response = await http.post(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        state = [...state, data];
        return jsonData;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<List<EstadoAnomaliaModel>> getAll() async {
    try {
      final url = "$endpoint/EstadoAnomalia.json";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        final listData = EstadoAnomalia.fromJsonList(jsonData);
        state = listData.anomaliaList;
        return listData.anomaliaList;
      } else {
        throw Exception("Ocurrió algo ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<int> delete(String id) async {
    try {
      final url = '$endpoint/EstadoAnomalia/$id.json';

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        state.removeWhere((anomaliaE) => anomaliaE.idEstadoAnomalia == id);
        return 1;
      } else {
        throw Exception("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<bool> update(EstadoAnomaliaModel data) async {
    try {
      final url = "$endpoint/EstadoAnomalia.json";
      final response = await http.put(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        //final decodeData = jsonDecode(response.body);
        state[state.indexWhere((anomaliaE) =>
            anomaliaE.idEstadoAnomalia == data.idEstadoAnomalia)] = data;
        return true;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}

