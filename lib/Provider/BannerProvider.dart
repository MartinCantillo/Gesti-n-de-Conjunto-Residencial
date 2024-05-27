import 'dart:convert';

import 'package:gestionresidencial/Models/Banner.dart';

import 'package:http/http.dart' as http;

import 'package:riverpod/riverpod.dart';

class BannerProvider extends StateNotifier<List<BannerModel>> {
  final String endpoint = "https://georgx12.pythonanywhere.com/api";
  BannerProvider(List<BannerModel> state) : super(state);

  Future<String> save(BannerModel data, String token) async {
    try {
      final url = "$endpoint/saveBanner";
      // print("Request Body: ${jsonEncode(data.toJson())}");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: data.toJson(),
      );

      if (response.statusCode == 200) { // Cambié a 201 para creación exitosa
        final responseData = jsonDecode(response.body);
        final String bannerId = responseData['banner_id'].toString();

        final newBanner = BannerModel(
          id: bannerId,
          titulo: data.titulo,
          descripcion: data.descripcion,
          fecha: data.fecha,
        );

        state = [...state, newBanner];
        return bannerId;
      } else {
        throw ("Error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  Future<List<BannerModel>> getAll(String token) async {
  final String url = "$endpoint/GetAllBanners";

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      
      String body = utf8.decode(response.bodyBytes);
      
      final List<dynamic> jsonData = jsonDecode(body);
      final List<BannerModel> listData = jsonData.map((banner) => BannerModel.fromMap(banner)).toList();
      // Asegúrate de que 'state' esté definido y pueda ser actualizado correctamente
      // state = listData; // Descomenta y ajusta según sea necesario
      return listData;
    } else {
      throw Exception("Ocurrió algo ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error $e");
  }
}

  Future<int> delete(String id) async {
    try {
      final url = '$endpoint/deleteBanner';

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

  Future<bool> update(BannerModel data) async {
    try {
      final url = "$endpoint/updateBanner";
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
