import 'package:flutter/material.dart';
import 'package:smart_parking/models/parkingLot_model.dart';
import 'package:smart_parking/services/api_service.dart';
import 'package:smart_parking/widgets/parkingLot_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<parkingLotModel>> _parkingLots;

  @override
  void initState() {
    super.initState();
    _parkingLots = ApiService.getParkingLots();
  }

  Future<void> _refreshParkingLots() async {
    setState(() {
      _parkingLots = ApiService.getParkingLots();
    });
  }

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
        actions: [
          IconButton(
            onPressed: _refreshParkingLots,
            icon: const Icon(Icons.refresh_sharp),
          )
        ],
        title: const Text(
          "Parking Spot",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _parkingLots,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return makeList(snapshot);
          }
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
