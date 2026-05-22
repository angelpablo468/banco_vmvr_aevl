import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../providers/banco_provider.dart';

import '../utils/colores.dart';

import '../widgets/banco_header.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

import 'home_screen.dart';
import 'registrar_screen.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final nombreController = TextEditingController();

    final passwordController = TextEditingController();

    return Scaffold(

      backgroundColor: AppColors.background,

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              // =========================
              // HEADER
              // =========================

              const BancoHeader(),

              const SizedBox(height: 50),

              // =========================
              // TEXTO
              // =========================

              const Align(

                alignment: Alignment.centerLeft,

                child: Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Align(

                alignment: Alignment.centerLeft,

                child: Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // =========================
              // NOMBRE
              // =========================

              CustomTextField(
                controller: nombreController,
                hint: 'Nombre',
              ),

              const SizedBox(height: 20),

              // =========================
              // CONTRASEÑA
              // =========================

              CustomTextField(
                controller: passwordController,
                hint: 'Contraseña',
                obscure: true,
              ),

              const SizedBox(height: 35),

              // =========================
              // BOTÓN LOGIN
              // =========================

              CustomButton(

                text: 'Iniciar sesión',

                onPressed: () async {

                  // VALIDAR NOMBRE

                  if (nombreController.text
                      .trim()
                      .isEmpty) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          'Ingresa tu nombre',
                        ),
                      ),
                    );

                    return;
                  }

                  // VALIDAR PASSWORD

                  if (passwordController.text.length < 6) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          'La contraseña debe tener mínimo 6 caracteres',
                        ),
                      ),
                    );

                    return;
                  }

                  // LOADING

                  showDialog(

                    context: context,

                    barrierDismissible: false,

                    builder: (_) {

                      return AlertDialog(

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20),
                        ),

                        content: Column(

                          mainAxisSize: MainAxisSize.min,

                          children: [

                            Lottie.asset(
                              'assets/animations/Loading.json',
                              height: 120,
                            ),

                            const SizedBox(height: 15),

                            const Text(
                              'Verificando datos...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              'Buscando cuentas...',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  await Future.delayed(
                    const Duration(seconds: 3),
                  );

                  final provider =
                      Provider.of<BancoProvider>(
                    context,
                    listen: false,
                  );

                  bool success = provider.iniciarSesion(
                    nombreController.text.trim(),
                    passwordController.text.trim(),
                  );

                  Navigator.pop(context);

                  if (success) {

                    Navigator.pushReplacement(

                      context,

                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );

                  } else {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          'Nombre o contraseña incorrectos',
                        ),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              Row(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  const Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),

                  TextButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              const RegisterScreen(),
                        ),
                      );
                    },

                    child: const Text(
                      'Crear cuenta',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}