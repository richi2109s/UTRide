import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Cerrar sesión'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushReplacementNamed(context, '/perfil_usuario');
              },
              child: const Text('Perfil de usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
