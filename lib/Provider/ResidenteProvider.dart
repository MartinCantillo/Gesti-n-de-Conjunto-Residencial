import 'dart:convert';

import 'package:gestionresidencial/Models/Residente.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

class ResidenteProvider extends StateNotifier<List<ResidenteModel>> {
  final String endpoint = "https://backendmovil2-default-rtdb.firebaseio.com/";
  ResidenteProvider(List<ResidenteModel> state) : super(state);

  Future<bool> save(ResidenteModel data) async {
    try {
      final url = "$endpoint/Residente.json";
      final response = await http.post(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        state = [...state, data];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Exception(e);
      return false;
    }
  }

  Future<List<ResidenteModel>> getAll() async {
    try {
      final url = "$endpoint/Residente.json";
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

  Future<int> delete(String id) async {
    try {
      final url = '$endpoint/Residente/$id.json';

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        state.removeWhere((residente) => residente.idResidente == id);
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
      final url = "$endpoint/Residente.json";
      final response = await http.put(Uri.parse(url), body: data.toJson());
      if (response.statusCode == 200) {
        //final decodeData = jsonDecode(response.body);
        state[state.indexWhere(
            (residente) => residente.idResidente == data.idResidente)] = data;
        return true;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
}

//1 estado (StateNotifier), 2 tipo de estado(List<AdministradorModel>)
final residenteProvider =
    StateNotifierProvider<ResidenteProvider, List<ResidenteModel>>((ref) {
  return ResidenteProvider([]);
});
