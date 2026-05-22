import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/banco_provider.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  IconData _getIcon(String texto) {
    if (texto.toLowerCase().contains('deposit')) {
      return Icons.arrow_downward;
    } else if (texto.toLowerCase().contains('retir')) {
      return Icons.arrow_upward;
    } else {
      return Icons.info;
    }
  }

  Color _getColor(String texto) {
    if (texto.toLowerCase().contains('deposit')) {
      return Colors.green;
    } else if (texto.toLowerCase().contains('retir')) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BancoProvider>(context);
    final historial = provider.usuarioActual?.historial ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text(
          'Historial',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFF5F6FA),
        foregroundColor: Colors.black,
      ),

      body: historial.isEmpty
          ? const Center(
              child: Text(
                'No hay movimientos todavía',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historial.length,
              itemBuilder: (context, index) {
                final item = historial[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          _getColor(item).withOpacity(0.15),
                      child: Icon(
                        _getIcon(item),
                        color: _getColor(item),
                      ),
                    ),

                    title: Text(
                      item,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    subtitle: const Text(
                      'Movimiento bancario',
                      style: TextStyle(fontSize: 12),
                    ),

                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
    );
  }
}