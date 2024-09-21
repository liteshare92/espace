import 'package:espace/build_appbart.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatelessWidget {
  final LatLng _location = const LatLng(14.781041, -16.956557);

  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Localisation', context),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _location,
              zoom: 14,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('Beeggee'),
                position: _location,
                infoWindow: const InfoWindow(title: 'Espace Beeggee', snippet: 'Pressing Thiès Azur'),
              ),
            },
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () => _launchMapsUrl(_location.latitude, _location.longitude),
              child: const Icon(Icons.directions),
            ),
          ),
        ],
      ),
    );
  }

  void _launchMapsUrl(double lat, double lon) async {
    final Uri url = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lon');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
