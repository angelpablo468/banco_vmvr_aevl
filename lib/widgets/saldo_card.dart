import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/banco_provider.dart';
import '../utils/colores.dart';

class SaldoCard extends StatelessWidget {

  const SaldoCard({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<BancoProvider>(context);

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: AppColors.secondary,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            'Saldo disponible',

            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 10),

          Text(

            provider.ocultarSaldo
                ? '••••••'
                : '\$${provider.usuarioActual?.saldo.toStringAsFixed(2) ?? '0.00'}',

            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}