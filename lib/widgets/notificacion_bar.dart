import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/banco_provider.dart';

class NotificacionBar extends StatelessWidget {
  const NotificacionBar({super.key});

  IconData _getIcon(String icono) {
    switch (icono) {
      case "deposit":
        return Icons.arrow_downward;
      case "withdraw":
        return Icons.arrow_upward;
      case "transfer":
        return Icons.swap_horiz;
      default:
        return Icons.info;
    }
  }

  Color _getColor(String tipo) {
    switch (tipo) {
      case "success":
        return Colors.green;
      case "error":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BancoProvider>(context);

    if (provider.notificacion == null) {
      return const SizedBox.shrink();
    }

    final data = provider.notificacion!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: _getColor(data["tipo"]),
      child: Row(
        children: [
          Icon(
            _getIcon(data["icono"]),
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              data["mensaje"],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}