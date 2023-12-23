import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_project/utils/location_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GoogleMapController _mapController;
  late final StreamSubscription _streamSubscription;
  Position? _position;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(23.7808186, 90.3372882),
    zoom: 1,
  );

  void _listenAndUpdateLocationOnMap() async {
    // Getting Permission
    try {
      await LocationServices.getPermission();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade900,
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
      return;
    }

    // Getting Current Position
    _position = await LocationServices.getCurrentPosition();

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_position?.latitude ?? 37.42796133580664, _position?.longitude ?? -122.085749655962),
          zoom: 17,
        ),
      ),
    );

    // Updating location
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Real-Time Location Tracker"),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _listenAndUpdateLocationOnMap();
        },
      ),
    );
  }
}
