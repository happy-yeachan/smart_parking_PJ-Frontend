class parkingLotModel {
  final String parkingName, image, id;
  parkingLotModel.fromJson(Map<String, dynamic> json)
      : parkingName = json['parkingName'],
        id = json['id'].toString(),
        image = json['image'];
}
