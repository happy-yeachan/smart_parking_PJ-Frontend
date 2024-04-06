class parkingLot_model {
  final String parkingName, id, image;

  parkingLot_model.fromJson(Map<String, dynamic> json)
      : parkingName = json['parkingName'],
        id = json['id'],
        image = json['image'];
}
