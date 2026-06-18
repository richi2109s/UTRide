import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              left: 150,
              top: 50,
              child: Text(
                "UT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Positioned(
              left: 194,
              top: 50,
              child: Text(
                "Ride",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // MAPA
            Positioned(
              top: 110,
              left: 10,
              right: 10,
              bottom: 190,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(31.766367, -106.561674),
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.utride.app',
                    ),
                    const MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(31.766367, -106.561674),
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.directions_bus,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // PERFIL
            Positioned(
              top: 44,
              right: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/perfil_usuario");
                },
              ),
            ),

            // BOTÓN SOS CON BORDE
            Positioned(
              bottom: 178,
              right: 6,
              child: Container(
                width: 100,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(255, 75, 47, 255),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            Positioned(
              bottom: 175,
              right: 18,
              child: IconButton(
                icon: const Icon(
                  Icons.warning,
                  size: 60,
                  color: Color.fromARGB(255, 35, 42, 255),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/sos");
                },
              ),
            ),

            // PANEL INFERIOR
            Positioned(
              bottom: 60,
              left: 6,
              right: 6,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 15, 4, 50),
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Positioned(
              bottom: 45,
              left: 10,
              right: 10,
              child: Divider(color: Colors.white),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: const Color.fromARGB(255, 15, 4, 50),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.home, size: 40, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
              ),
            ),

            Positioned(
              bottom: 0,
              left: size.width / 2 - 20,
              child: IconButton(
                icon: const Icon(
                  Icons.directions_bus,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/camion");
                },
              ),
            ),

            Positioned(
              bottom: 0,
              right: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.notifications,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/notificaciones");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
