import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Encabezado
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Mi Perfil",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Tarjeta principal
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage('assets/user.jpg'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Carlos Hernández",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "carlos.hernandez@utpn.edu.mx",
                                style: TextStyle(color: Colors.white70),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  buildSection("Información personal", [
                    buildItem(
                      Icons.email_outlined,
                      "Correo",
                      "carlos.hernandez@utpn.edu.mx",
                    ),
                    buildItem(
                      Icons.phone_outlined,
                      "Teléfono",
                      "(871) 123 4567",
                    ),
                    buildItem(
                      Icons.location_on_outlined,
                      "Dirección",
                      "Av. Universidad #123",
                    ),
                  ]),

                  const SizedBox(height: 15),

                  buildSection("Información de transporte", [
                    buildItem(
                      Icons.directions_bus,
                      "Camión a tomar",
                      "Ruta 1A - Camión 07",
                    ),
                    buildItem(Icons.schedule, "Turno", "Matutino"),
                    buildItem(
                      Icons.pin_drop,
                      "Parada habitual",
                      "Parada Central",
                    ),
                    buildItem(Icons.access_time, "Horario salida", "06:40 AM"),
                  ]),

                  const SizedBox(height: 15),

                  buildSection("Seguridad y cuenta", [
                    buildItem(
                      Icons.lock_outline,
                      "Cambiar contraseña",
                      "",
                      onTap: () {
                        Navigator.pushNamed(context, '/ocontracena');
                      },
                    ),
                  ]),

                  const SizedBox(height: 15),

                  buildSection("Preferencias", [
                    buildItem(
                      Icons.notifications_none,
                      "Notificaciones",
                      "",
                      onTap: () {
                        Navigator.pushNamed(context, '/notificaciones');
                      },
                    ),
                  ]),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!context.mounted) return;
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text(
                        "Cerrar sesión",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget buildItem(
    IconData icon,
    String title,
    String value, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(color: Colors.white)),
          const SizedBox(width: 5),
          const Icon(Icons.chevron_right, color: Colors.white54),
        ],
      ),
      onTap: onTap,
    );
  }
}
