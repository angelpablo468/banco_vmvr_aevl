import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/banco_provider.dart';

class TarjetaBancaria extends StatelessWidget {
  const TarjetaBancaria({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<BancoProvider>(context);

    final usuario = provider.usuarioActual;

    if (usuario == null) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0F2027),
            Color(0xFF203A43),
            Color(0xFF2C5364),
          ],
        ),
      ),
      child: Stack(
        children: [

          // CHIP
          const Positioned(
            top: 10,
            left: 10,
            child: Icon(
              Icons.memory,
              color: Colors.amber,
              size: 40,
            ),
          ),

        
          const Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.credit_card,
              color: Colors.white,
            ),
          ),

        
          Positioned(
            top: 80,
            left: 10,
            child: Text(
              usuario.numeroCuenta,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          
          Positioned(
            bottom: 20,
            left: 10,
            child: Text(
              usuario.nombre.toUpperCase(),
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),

      
          Positioned(
            bottom: 20,
            right: 10,
            child: Text(
              provider.ocultarSaldo
                  ? '••••••'
                  : '\$${usuario.saldo.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}