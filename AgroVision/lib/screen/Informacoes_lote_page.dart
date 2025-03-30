import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapaLotePage extends StatefulWidget {
  const MapaLotePage({super.key});

  @override
  State<MapaLotePage> createState() => _MapaLotePage();
}

class _MapaLotePage extends State<MapaLotePage> {
  var selecIcon = [Colors.green, Colors.red, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(
        children: [
          // Mapa de fundo
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(-19.761801271351505, -47.96352284916885),
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 50,
                    height: 50,
                    point: const LatLng(-19.765578885587512, -47.95651791790178),
                    child: mark(0),
                  ),
                  Marker(
                    width: 50,
                    height: 50,
                    point: const LatLng(-19.767949107572836, -47.96950458779025),
                    child: mark(1),
                  ),
                  Marker(
                    width: 50,
                    height: 50,
                    point: const LatLng(-19.77313384547731, -47.96084680830409),
                    child: mark(2),
                  ),
                ],
              ),
            ],
          ),

          // Barra superior com informações

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          "Explorando os Lotes",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      infoCard("1,281", "Observaçoes"),
                      infoCard("252", "Espécies"),
                      infoCard("281", "Observadores"),
                      infoCard("418", "Identificados"),
                    ],
                  ),
                ],
              ),
            ),
          ),


          // Botões flutuantes no canto inferior direito
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Icon(Icons.layers, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
    ),
      ),
    );
  }

  Widget infoCard(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ],
    );
  }

  Widget mark(int pos) {
    return Icon(
      Icons.location_on,
      color: selecIcon[pos],
      size: 40,
    );
  }
}
