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
            // TÍTULO
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

            // MAPA + BOTÓN SOS
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

                    // BOTÓN SOS
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
                              width: 3,
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

            // Boton para di
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

            // Panel inferior
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: mostrarPanel ? 60 : -140,
              left: 6,
              right: 6,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 15, 4, 50),
                  border: Border.all(color: Colors.blue, width: 3),
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

            // Barra inferior
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: const Color.fromARGB(255, 15, 4, 50),
              ),
            ),

            // Probablemente se elimine
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

            // Boton para las distintas rutas
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

            // Historial de notificaciones
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
