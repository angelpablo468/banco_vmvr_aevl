import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/banco_provider.dart';
import '../screens/login_screen.dart';

class AjustesScreen extends StatelessWidget {
  const AjustesScreen({super.key});

  Future<void> llamarSoporte() async {
    final Uri telefono = Uri(
      scheme: 'tel',
      path: '8999384758',
    );

    await launchUrl(telefono);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BancoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            SwitchListTile(
              title: const Text('Ocultar saldo'),
              secondary: const Icon(Icons.visibility_off),
              value: provider.ocultarSaldo,
              onChanged: (value) {
                provider.cambiarOcultarSaldo();
              },
            ),

            const Divider(),

          
            SwitchListTile(
              title: const Text("Modo oscuro"),
              secondary: const Icon(Icons.dark_mode),
              value: provider.modoOscuro,
              onChanged: (value) {
                provider.cambiarModoOscuro();
              },
            ),

            const Divider(),

            ListTile(
              title: const Text('Llamar soporte'),
              leading: const Icon(Icons.call),
              onTap: llamarSoporte,
            ),

            const Divider(),

            ListTile(
              title: const Text('Cerrar sesión'),
              leading: const Icon(Icons.logout),
              onTap: () {
                provider.cerrarSesion();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}