import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

GoogleMapController gmapController;

class ShowLocation extends StatefulWidget {
  @override
  _ShowLocation createState() => _ShowLocation();
}

class _ShowLocation extends State<ShowLocation> {
  Set<Marker> _markers = HashSet<Marker>();

  BitmapDescriptor _markerIcon;

  void _getLocationPermission() async {
    var location = new Location();
    try {
      location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    getBytesFromAsset('assets/logo.png', 128).then((onValue) {
      _markerIcon = BitmapDescriptor.fromBytes(onValue);
    });
    _getLocationPermission();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    gmapController = controller;

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(35.176517, 32.905591),
            infoWindow: InfoWindow(
              title: "Joya Italiano Steak house",
              snippet: "Best steak house in Cyprus",
            ),
            icon: _markerIcon),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      markers: _markers,
      myLocationButtonEnabled: true,
      onMapCreated: _onMapCreated,
      initialCameraPosition:
          CameraPosition(target: LatLng(35.176511, 32.905592), zoom: 15.0),
      mapType: MapType.normal,
    ));
  }
}
