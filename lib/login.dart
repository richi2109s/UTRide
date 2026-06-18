import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      User? user = userCredential.user;

      if (!mounted) return;

      if (user != null && !user.emailVerified) {
        await FirebaseAuth.instance.signOut();

        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Debes verificar tu correo antes de iniciar sesión'),
          ),
        );

        return;
      }
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Inicio de sesión exitoso')));

      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      String message = '';

      if (e.code == 'user-not-found') {
        message = 'Usuario no encontrado';
      } else if (e.code == 'wrong-password') {
        message = 'Contraseña incorrecta';
      } else if (e.code == 'invalid-email') {
        message = 'Correo inválido';
      } else if (e.code == 'invalid-credential') {
        message = 'Correo o contraseña incorrectos';
      } else {
        message = e.message ?? 'Error al iniciar sesión';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 100, top: 390),
              child: const Text(
                "Iniciar Sesion",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                  right: 35,
                  left: 35,
                ),

                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),

                        hintText: 'Correo Electronico',

                        hintStyle: const TextStyle(color: Colors.white),

                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextField(
                      controller: passwordController,
                      obscureText: true,

                      style: const TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),

                        hintText: 'Contraseña',

                        hintStyle: const TextStyle(color: Colors.white),

                        prefixIcon: const Icon(Icons.lock, color: Colors.white),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          'Iniciar Sesion',

                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFFF7931E),

                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : IconButton(
                                  color: Colors.white,

                                  onPressed: loginUser,

                                  icon: const Icon(Icons.arrow_forward),
                                ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },

                          child: const Text(
                            'Registrate',

                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/ocontracena');
                          },
                          child: const Text(
                            'Olvide mi contraseña',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
