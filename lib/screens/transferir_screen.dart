import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/banco_provider.dart';
import '../widgets/custom_button.dart';
import '../utils/colores.dart';


import '../widgets/custom_textfield.dart';

class TransferirScreen extends StatelessWidget {
  const TransferirScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cuentaController = TextEditingController();

    final montoController = TextEditingController();

    return Scaffold(

      backgroundColor: AppColors.background,

      appBar: AppBar(

        backgroundColor: AppColors.background,

        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),

        title: const Text(
          'Transferir',
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
                'Transferencia bancaria',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Envía dinero a otra cuenta',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              CustomTextField(
                controller: cuentaController,
                hint: 'Cuenta destino',
              ),

              const SizedBox(height: 20),


              CustomTextField(
                controller: montoController,
                hint: 'Monto',
              ),

              const SizedBox(height: 35),

              CustomButton(

                text: 'Transferir',

                onPressed: () {

                  final provider = Provider.of<BancoProvider>(
                    context,
                    listen: false,
                  );

                  final monto =
                      double.tryParse(montoController.text);

                  if (monto == null || monto <= 0) {

                    ScaffoldMessenger.of(context).showSnackBar(

                      const SnackBar(
                        content: Text(
                          'Ingresa un monto válido',
                        ),
                      ),
                    );

                    return;
                  }

                  bool success = provider.transferir(
                    cuentaController.text.trim(),
                    monto,
                  );

                  if (success) {

                    ScaffoldMessenger.of(context).showSnackBar(

                      const SnackBar(
                        content: Text(
                          'Transferencia realizada',
                        ),
                      ),
                    );

                    Navigator.pop(context);

                  } else {

                    ScaffoldMessenger.of(context).showSnackBar(

                      const SnackBar(
                        content: Text(
                          'No se pudo realizar la transferencia',
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