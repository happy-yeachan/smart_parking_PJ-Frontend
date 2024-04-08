import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_parking/models/parkingLot_detail_model.dart';
import 'package:smart_parking/models/parkingLot_model.dart';

class ApiService {
  static const String baseUrl = "http://3.35.138.59:8080/parking";

  static Future<List<parkingLotModel>> getParkingLots() async {
    List<parkingLotModel> parkingLotInstances = [];
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> parkingLots = jsonDecode(response.body);
      for (var parkingLot in parkingLots) {
        parkingLotInstances.add(parkingLotModel.fromJson(parkingLot));
      }
      return parkingLotInstances;
    }
    throw Error();
  }

  static Future<ParkingLotDetailModel> getLotById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final parkingLot = jsonDecode(response.body);
      return ParkingLotDetailModel.fromJson(parkingLot);
    }
    throw Error();
  }

  // static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
  //     String id) async {
  //   List<WebtoonEpisodeModel> episodeInstances = [];
  //   final url = Uri.parse('$baseUrl/$id/episodes');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final episodes = jsonDecode(response.body);
  //     for (var episode in episodes) {
  //       episodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
  //     }
  //     return episodeInstances;
  //   }
  //   throw Error();
  // }
}
