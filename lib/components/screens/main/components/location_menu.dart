import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

const latitude = -6.9775495;
const longitude = 107.6299839;

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(latitude, longitude),
        zoom: 15.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/anantand/cl4dkq6jz000315s2r98vukpl/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5hbnRhbmQiLCJhIjoiY2w0N3c5cXVyMGJ5dTNkcDhqOWJoeHR5ciJ9.WgGznLo-f-ISwe9lFVsoWg",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiYW5hbnRhbmQiLCJhIjoiY2w0N3c5cXVyMGJ5dTNkcDhqOWJoeHR5ciJ9.WgGznLo-f-ISwe9lFVsoWg',
            'id': 'mapbox.country-boundaries-v1'
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(latitude, longitude), //mark klinik telkom
              builder: (ctx) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 40.0,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
