import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:yakalma/global/constantes.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  Location location = Location();

  //Geolocator geolocator=Geolocator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          //initialCenter: LatLng(14.497401,-14.452362),
          initialCenter: LatLng(Constantes.latLng!.latitude!,Constantes.latLng!.longitude!) ,// position actuelle
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate:'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a','b','c'],
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              customMarker(14.497401,-14.452362),
              customMarker(2.064982,-0.292807),
              customMarker(14.603518,-17.422416),
              customMarker(14.717734,-17.451547),
              customMarker(14.743301,-17.443653),
              customMarker(14.727032,-17.438505),
              customMarker(14.733843,-17.469725),

            ],
          )
        ],
      ),
      /**body: Stack(
        children: [
          FutureBuilder(
            future: location.getLocation(),
            builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
              return FlutterMap(
                options: MapOptions(
                  //initialCenter: LatLng(14.497401,-14.452362),
                  initialCenter: snapshot.data != null ? LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!) :const  LatLng(14.717734,-17.451547),// camp leclerc
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a','b','c'],
                    userAgentPackageName: 'com.example.app',
                  ),
                  /**CircleLayer(
                    circles: [
                      CircleMarker(
                        //color: Colors.transparent,
                        borderColor: Colors.blueAccent,
                        point: LatLng(snapshot.data!.latitude!,snapshot.data!.longitude!),
                        radius: 1000,
                        useRadiusInMeter: true,
                      ),
                    ],
                  ),*/
                  /**
                      PolygonLayer(
                      polygonCulling: false,
                      polygons: [
                      Polygon(
                      points: [
                      const LatLng(36.95, -9.5),
                      const LatLng(42.25, -9.5),
                      const LatLng(42.25, -6.2),
                      const LatLng(36.95, -6.2),
                      ],
                      color: Colors.blue.withOpacity(0.5),
                      borderStrokeWidth: 2,
                      borderColor: Colors.blue,
                      isFilled: true
                      ),
                      ],
                      ),
                      PolylineLayer(
                      polylines: [
                      Polyline(
                      points: [
                      const LatLng(38.73, -9.14), // Lisbon, Portugal
                      const LatLng(51.50, -0.12), // London, United Kingdom
                      const LatLng(52.37, 4.90), // Amsterdam, Netherlands
                      const LatLng(2.213749, 46.227638), // France
                      const LatLng(-14.452362, 14.497401), // Senegal
                      ],
                      color: Colors.blue,
                      strokeWidth: 2,
                      ),
                      ],
                      ),*/
                  MarkerLayer(
                    markers: [
                      customMarker(14.497401,-14.452362),
                      customMarker(2.064982,-0.292807),
                      customMarker(14.603518,-17.422416),
                      customMarker(14.717734,-17.451547),
                      customMarker(14.743301,-17.443653),
                      customMarker(14.727032,-17.438505),
                      customMarker(14.733843,-17.469725),

                    ],
                  )
                ],
              );
            },

          ),
        ],
      ),*/
    );
  }

  customMarkerIcon(){
    return const Icon(Icons.location_on_outlined,color: Colors.blueAccent,size: 30,);
  }

  customMarker(double lat,double long) {
    return Marker(
      point: LatLng(lat, long),
      //width: 80,
      //height: 80,
      child: customMarkerIcon(),
    );
  }
}
