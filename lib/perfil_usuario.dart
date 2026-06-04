import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/inicio.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Botón de regreso
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Perfil
          Center(
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: Colors.blue),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Perfil de Usuario",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text(
                      "Nombre",
                      style: TextStyle(color: Colors.white70),
                    ),
                    subtitle: Text("", style: TextStyle(color: Colors.white)),
                  ),

                  const ListTile(
                    leading: Icon(Icons.phone, color: Colors.white),
                    title: Text(
                      "Teléfono",
                      style: TextStyle(color: Colors.white70),
                    ),
                    subtitle: Text("", style: TextStyle(color: Colors.white)),
                  ),

                  const ListTile(
                    leading: Icon(Icons.email, color: Colors.white),
                    title: Text(
                      "Correo",
                      style: TextStyle(color: Colors.white70),
                    ),
                    subtitle: Text("", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
