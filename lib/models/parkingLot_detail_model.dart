class ParkingLotDetailModel {
  final String parkingName, image, id, emptySpace, totalSpace, currentCar;

  ParkingLotDetailModel.fromJson(Map<String, dynamic> json)
      : parkingName = json['parkingName'],
        id = json['id'].toString(),
        image = json['image'],
        emptySpace = json['emptySpace'].toString(),
        totalSpace = json['totalSpace'].toString(),
        currentCar = json['currentCar'].toString();
}
