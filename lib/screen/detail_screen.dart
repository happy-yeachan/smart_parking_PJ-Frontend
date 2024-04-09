import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parking/models/parkingLot_detail_model.dart';
import 'package:smart_parking/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String parkingName, image, id;

  const DetailScreen({
    super.key,
    required this.parkingName,
    required this.image,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<ParkingLotDetailModel> parkinglot;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPredfs() async {
    prefs = await SharedPreferences.getInstance();
    final likedParkingLots = prefs.getStringList('likedParkingLots');
    if (likedParkingLots != null) {
      if (likedParkingLots.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList("likedParkingLots", []);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parkinglot = ApiService.getLotById(widget.id);
    initPredfs();
  }

  onHeartTap() async {
    final likedParkingLots = prefs.getStringList('likedParkingLots');
    if (likedParkingLots != null) {
      if (isLiked) {
        likedParkingLots.remove(widget.id);
      } else {
        likedParkingLots.add(widget.id);
      }
      await prefs.setStringList('likedParkingLots', likedParkingLots);
      setState(() {
        isLiked = !isLiked;
      });
    }
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
            onPressed: onHeartTap,
            icon: Icon(isLiked
                ? Icons.favorite_rounded
                : Icons.favorite_outline_rounded),
          )
        ],
        title: Text(
          widget.parkingName,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
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
                      child: Image.memory(base64.decode(widget.image)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: parkinglot,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.parkingName,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          '주차 가능 공간 / 현재 차량 수',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${snapshot.data!.totalSpace} / ${snapshot.data!.currentCar}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
