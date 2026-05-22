import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/colores.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String mensaje = 'Verificando datos...';

  final mensajes = [

    'Verificando datos...',
    'Buscando cuentas...',
    'Protegiendo información...',
    'Conectando al banco...',
    'Preparando sesión...',
  ];

  int index = 0;

  @override
  void initState() {

    super.initState();

    Timer.periodic(

      const Duration(seconds: 1),

      (timer) {

        if (index < mensajes.length - 1) {

          index++;

          setState(() {
            mensaje = mensajes[index];
          });

        }
      },
    );

    Timer(

      const Duration(seconds: 5),

      () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Image.asset(
              'assets/images/logo.png',
              height: 130,
            ),

            const SizedBox(height: 25),

            const Text(

              'Miku Destroyer Bank',

              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 30),

            Lottie.asset(
              'assets/animations/loading.json',
              height: 140,
            ),

            const SizedBox(height: 20),

            Text(

              mensaje,

              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}