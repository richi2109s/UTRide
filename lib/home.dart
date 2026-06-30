import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool mostrarPanel = true;

  final MapController _mapController = MapController();
  double currentZoom = 15;

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
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "UT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Ride",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: 110,
              left: 10,
              right: 10,
              bottom: mostrarPanel ? 190 : 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: const MapOptions(
                        initialCenter: LatLng(31.766367, -106.561674),
                        initialZoom: 15,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
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

                    Positioned(
                      top: 20,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 5),
                          ],
                        ),
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                currentZoom++;
                                _mapController.move(
                                  _mapController.camera.center,
                                  currentZoom,
                                );
                              },
                            ),
                            const Divider(height: 1),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                currentZoom--;
                                _mapController.move(
                                  _mapController.camera.center,
                                  currentZoom,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/sos");
                        },
                        child: Container(
                          width: 90,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 75, 47, 255),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.warning,
                              size: 45,
                              color: Color.fromARGB(255, 35, 42, 255),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 40,
              right: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/perfil_usuario");
                },
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: mostrarPanel ? 60 : -140,
              left: 6,
              right: 6,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 15, 4, 50),
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Información de la ruta",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),

            if (mostrarPanel)
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
                onPressed: () {},
              ),
            ),

            Positioned(
              bottom: 0,
              left: size.width / 2 - 20,
              child: IconButton(
                icon: Icon(
                  mostrarPanel
                      ? Icons.keyboard_arrow_down
                      : Icons.directions_bus,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    mostrarPanel = !mostrarPanel;
                  });
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
