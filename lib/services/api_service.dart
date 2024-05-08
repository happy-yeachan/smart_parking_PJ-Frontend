import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_parking/models/parkingLot_detail_model.dart';
import 'package:smart_parking/models/parkingLot_model.dart';

class ApiService {
  static const String baseUrl = "https://gguldangi.shop/parking";

  static Future<List<parkingLotModel>> getParkingLots() async {
    List<parkingLotModel> parkingLotInstances = [];
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> parkingLots =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var parkingLot in parkingLots) {
        parkingLotInstances.add(parkingLotModel.fromJson(parkingLot));
      }
      return parkingLotInstances;
    }
    throw Error();
  }

  static Future<ParkingLotDetailModel> getLotById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final parkingLot = jsonDecode(utf8.decode(response.bodyBytes));
      return ParkingLotDetailModel.fromJson(parkingLot);
    }
    throw Error();
  }
}
