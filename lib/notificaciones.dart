import 'package:flutter/material.dart';

class Alerta {
  String titulo;
  String descripcion;
  IconData icono;
  bool activa;

  Alerta({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.activa,
  });
}

class Notificaciones extends StatefulWidget {
  const Notificaciones({super.key});

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  bool notificacionesActivas = true;
  List<Alerta> alertas = [
    Alerta(
      titulo: "Camión cerca de tu parada",
      descripcion: "Te avisaremos cuando el camión esté cerca de tu parada.",
      icono: Icons.directions_bus,
      activa: true,
    ),
    Alerta(
      titulo: "Retrasos en la ruta",
      descripcion: "Recibe avisos cuando existan retrasos.",
      icono: Icons.access_time,
      activa: true,
    ),
    Alerta(
      titulo: "Cambios de ruta",
      descripcion: "Te notificaremos sobre cambios importantes.",
      icono: Icons.warning_amber,
      activa: true,
    ),
    Alerta(
      titulo: "Emergencias",
      descripcion: "Recibe alertas de seguridad importantes.",
      icono: Icons.campaign,
      activa: true,
    ),
    Alerta(
      titulo: "Noticias y actualizaciones",
      descripcion: "Novedades y mejoras de UTRide.",
      icono: Icons.star,
      activa: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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

          // Contenido principal
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 220,
              ), // espacio para no tapar con la barra
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        // Flecha de regreso
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),

                        // Título
                        const Expanded(
                          child: Text(
                            "Configuración de notificaciones",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 30),
                      ],
                    ),
                  ),

                  // Bloque de notificaciones activadas
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2B5A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 35, 63, 124),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notificaciones activadas",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Recibe alertas importantes sobre tus rutas, camiones y horarios.",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: notificacionesActivas,
                          onChanged: (value) {
                            setState(() {
                              notificacionesActivas = value;
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: const Color.fromARGB(
                            255,
                            250,
                            151,
                            3,
                          ),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Opciones de alertas
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.notification_add,
                          color: Colors.blue,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Opciones de alertas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Lista de alertas
                  ...alertas.asMap().entries.map((entry) {
                    int index = entry.key;
                    Alerta alerta = entry.value;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2B5A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(alerta.icono, color: Colors.white, size: 30),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  alerta.titulo,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  alerta.descripcion,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: alerta.activa,
                            onChanged: (value) {
                              setState(() {
                                alertas[index].activa = value;
                              });
                            },
                            activeColor: Colors.white,
                            activeTrackColor: const Color.fromARGB(
                              255,
                              250,
                              151,
                              3,
                            ),
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),

          // ===== Barra inferior estilo Homepage =====
          Positioned(
            bottom: 1,
            left: 1,
            child: Container(
              width: 600,
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 15, 4, 50),
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.home, size: 40, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, "/home");
              },
            ),
          ),
          Positioned(
            bottom: -1,
            right: 175,
            child: IconButton(
              icon: const Icon(
                Icons.directions_bus,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Positioned(
            bottom: -1,
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
          Positioned(
            bottom: 45,
            left: 10,
            right: 10,
            child: const Divider(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
