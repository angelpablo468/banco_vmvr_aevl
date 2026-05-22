import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../providers/banco_provider.dart';
import '../utils/colores.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class DepositarScreen extends StatelessWidget {
  const DepositarScreen({super.key});

  Future<void> mostrarLottie(BuildContext context, String archivo) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        });

        return Center(
          child: Lottie.asset(
            archivo,
            width: 200,
            height: 200,
            repeat: false,
          ),
        );
      },
    );
  }

  Future<void> mostrarImagen(BuildContext context, String archivo) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        });

        return Center(
          child: Image.asset(
            archivo,
            width: 200,
            height: 200,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Depositar',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const Text(
                'Depositar dinero',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Ingresa el monto a depositar',
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 40),

              CustomTextField(
                controller: controller,
                hint: 'Cantidad',
              ),

              const SizedBox(height: 35),

              CustomButton(
                text: 'Depositar',

                onPressed: () async {
                  final monto = double.tryParse(controller.text);

                  if (monto == null || monto <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ingresa un monto válido'),
                      ),
                    );
                    return;
                  }

                  final banco = Provider.of<BancoProvider>(
                    context,
                    listen: false,
                  );

                  banco.depositar(monto);

                  if (monto == 67) {
                    banco.mostrarNotificacion(
                      mensaje: "SIXSEVEN",
                      tipo: "info",
                      icono: "info",
                    );

                    await mostrarImagen(
                      context,
                      'assets/images/67.png',
                    );
                  } else {
                    banco.mostrarNotificacion(
                      mensaje:
                          "Depósito +\$${monto.toStringAsFixed(2)}",
                      tipo: "success",
                      icono: "deposit",
                    );

                    await mostrarLottie(
                      context,
                      'assets/animations/depositar.json',
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