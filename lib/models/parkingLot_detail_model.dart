class ParkingLotDetailModel {
  final String name, image, id, cnt;

  ParkingLotDetailModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'].toString(),
        image = json['image'],
        cnt = json['cnt'].toString();
}
