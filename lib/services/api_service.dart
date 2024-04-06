import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_parking/models/parkingLot_model.dart';

class ApiService {
  static const String baseUrl =
      "https://2735-203-230-103-176.ngrok-free.app/parking";

  static Future<List<parkingLot_model>> getParkingLots() async {
    List<parkingLot_model> parkingLotInstances = [];
    final url = Uri.parse(baseUrl);
    final response =
        await http.get(url, headers: {"ngrok-skip-browser-warning": "123"});
    // final response = await http.get(url, headers: {
    //   "ngrok-skip-browser-warning": "123",
    // });
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> parkingLots = jsonDecode(response.body);
      print("hello");
      for (var parkingLot in parkingLots) {
        parkingLotInstances.add(parkingLot_model.fromJson(parkingLot));
      }
      return parkingLotInstances;
    }
    throw Error();
  }

  // static Future<WebtoonDetailModel> getToonById(String id) async {
  //   final url = Uri.parse('$baseUrl/$id');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final webtoon = jsonDecode(response.body);
  //     return WebtoonDetailModel.fromJson(webtoon);
  //   }
  //   throw Error();
  // }

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
