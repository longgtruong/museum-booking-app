import 'package:app/models/exhibition.dart';
import 'package:app/models/museum.dart';
import 'package:dio/dio.dart';

class MuseumRepository {
  final Dio _dio = Dio();
  final baseUrl = "https://museum-booking.ew.r.appspot.com";

  Future<List<Exhibition>> getExhibitions() async {
    Response result = await _dio.get(baseUrl + "/exhibitions");
    return result.data
        .map<Exhibition>((json) => Exhibition.fromJson(json))
        .toList();
  }

  Future<List<Museum>> getMuseums() async {
    try {
      Response result = await _dio.get(baseUrl + "/museums");
      return result.data.map<Museum>((json) => Museum.fromJson(json)).toList();
    } catch (err) {
      return [];
    }
  }

  Future<Museum> getMuseumsById(String id) async {
    try {
      Response result = await _dio.get(baseUrl + "/museums/" + id);
      return Museum.fromJson(result.data);
    } catch (err) {
      throw Error();
    }
  }
}
