import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:utride_app/perfil_usuario.dart';
import 'firebase_options.dart';

import 'login.dart';
import 'register.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const UtrideApp());
}

class UtrideApp extends StatelessWidget {
  const UtrideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utride',
      debugShowCheckedModeBanner: false,

      initialRoute: FirebaseAuth.instance.currentUser != null
          ? '/home'
          : '/login',

      routes: {
        '/login': (context) => const MyLogin(),

        '/register': (context) => const MyRegister(),

        '/home': (context) => const Homepage(),

        '/perfil_usuario': (context) => Perfil(),
      },
    );
  }
}
