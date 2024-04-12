import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parking/models/parkingLot_model.dart';
import 'package:smart_parking/services/api_service.dart';
import 'package:smart_parking/widgets/parkingLot_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<parkingLotModel>> parkingLots = ApiService.getParkingLots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "Parking Spot",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: parkingLots,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<parkingLotModel>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: (snapshot.data!.length / 2).ceil(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        final int firstIndex = index * 2;
        final int secondIndex = index * 2 + 1;
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ParkingLot(
                  parkingName: snapshot.data![firstIndex].parkingName,
                  image: snapshot.data![firstIndex].image,
                  id: snapshot.data![firstIndex].id,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ParkingLot(
                  parkingName: snapshot.data![secondIndex].parkingName,
                  image: snapshot.data![secondIndex].image,
                  id: snapshot.data![secondIndex].id,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
