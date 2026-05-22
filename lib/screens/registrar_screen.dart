import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../providers/banco_provider.dart';
import '../utils/colores.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final nombreController = TextEditingController();

    final correoController = TextEditingController();

    final passwordController = TextEditingController();

    return Scaffold(

      backgroundColor: AppColors.background,

      appBar: AppBar(

        backgroundColor: AppColors.background,

        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const Text(
                'Crear cuenta',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Completa los datos para registrarte',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              CustomTextField(
                controller: nombreController,
                hint: 'Nombre completo',
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: correoController,
                hint: 'Correo',
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: passwordController,
                hint: 'Contraseña',
                obscure: true,
              ),

              const SizedBox(height: 35),

              CustomButton(

                text: 'Crear cuenta',

                onPressed: () async {

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

                  if (!correoController.text
                      .contains('@gmail.com')) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          'Ingresa un Gmail válido',
                        ),
                      ),
                    );

                    return;
                  }

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

                  final provider =
                      Provider.of<BancoProvider>(
                    context,
                    listen: false,
                  );

                  bool success = provider.crearCuenta(

                    nombre:
                        nombreController.text.trim(),

                    correo:
                        correoController.text.trim(),

                    password:
                        passwordController.text.trim(),
                  );

                  if (success) {

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

                            mainAxisSize:
                                MainAxisSize.min,

                            children: [

                              Lottie.asset(
                                'assets/animations/success.json',
                                height: 140,
                              ),

                              const SizedBox(height: 15),

                              const Text(
                                'Cuenta creada correctamente',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );

                    await Future.delayed(
                      const Duration(seconds: 2),
                    );

                    Navigator.pop(context);

                    Navigator.pop(context);

                  } else {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          'Ese correo ya está registrado',
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}