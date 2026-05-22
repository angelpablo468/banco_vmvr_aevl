import 'package:flutter/material.dart';
import '../utils/constantes.dart';

class BancoHeader extends StatelessWidget {
  const BancoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),

        Image.asset(
          'assets/images/logo.png',
          height: 100,
        ),

        const SizedBox(height: 10),

        const Text(
          Constantes.appNombre,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}