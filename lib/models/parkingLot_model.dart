class parkingLotModel {
  final String name, image, id;
  parkingLotModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'].toString(),
        image = json['image'];
}
