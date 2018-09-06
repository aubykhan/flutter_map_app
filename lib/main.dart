import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  GoogleMapController.init();
  final size = MediaQueryData.fromWindow(ui.window).size;
  final GoogleMapOverlayController controller =
      GoogleMapOverlayController.fromSize(
    width: size.width,
    height: size.height - 72.0,
  );
  final mapController = controller.mapController;
  final Widget mapWidget = GoogleMapOverlay(controller: controller);
  runApp(
    MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration.collapsed(hintText: 'Search'),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                final location = LatLng(24.934163, 67.044612);
                mapController.markers.clear();
                mapController.addMarker(MarkerOptions(
                  position: location,
                ));
                mapController.animateCamera(
                  CameraUpdate.newLatLngZoom(
                      location, 15.0),
                );
              },
            ),
          ],
        ),
        body: MapsDemo(mapWidget, controller.mapController),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.my_location),
        ),
      ),
      navigatorObservers: <NavigatorObserver>[controller.overlayController],
    ),
  );
}

class MapsDemo extends StatelessWidget {
  MapsDemo(this.mapWidget, this.controller);

  final Widget mapWidget;
  final GoogleMapController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Center(child: mapWidget),
        Text('Hey, on top of map'),
      ],
    );
  }
}
