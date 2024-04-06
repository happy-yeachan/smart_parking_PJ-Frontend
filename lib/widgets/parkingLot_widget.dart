import 'package:flutter/material.dart';

class ParkingLot extends StatelessWidget {
  final String parkingName, id, image;

  const ParkingLot({
    super.key,
    required this.parkingName,
    required this.image,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailScreen(
        //       title: title,
        //       thumb: thumb,
        //       id: id,
        //     ),
        //     fullscreenDialog: true,
        //   ),
        // );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
              child: Image.memory(Uri.parse(image).data!.contentAsBytes()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            parkingName,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
