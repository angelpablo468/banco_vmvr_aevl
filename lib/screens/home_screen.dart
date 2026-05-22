import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/banco_provider.dart';
import '../utils/colores.dart';
import '../widgets/tarjeta_bancaria.dart';

import 'depositar_screen.dart';
import 'retirar_screen.dart';
import 'transferir_screen.dart';
import 'historial_screen.dart';
import 'ajustes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BancoProvider>(context);
    final usuario = provider.usuarioActual;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text(
              "MIKU BANK",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      backgroundColor: AppColors.background,

      body: Column(
        children: [

          // 🔔 NOTIFICACIÓN CORREGIDA (MAP → STRING)
          if (provider.notificacion != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.green,
              child: Text(
                provider.notificacion!["mensaje"] ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [

               
                SingleChildScrollView(
                  child: Column(
                    children: [

                      
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 60,
                          left: 20,
                          right: 20,
                          bottom: 100,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [

                                const Text(
                                  "banco miku destroyer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: [

                                    const Text(
                                      'Saldo total',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),

                                    Text(
                                      provider.ocultarSaldo
                                          ? '••••••'
                                          : '\$${usuario?.saldo.toStringAsFixed(2) ?? '0.00'}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 35),

                            Text(
                              'Hola ${usuario?.nombre ?? ''} 👋',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              'Bienvenido a Miku Destroyer Bank',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // esta cosa de la tarejta 
                      Transform.translate(
                        offset: const Offset(0, -70),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TarjetaBancaria(),
                        ),
                      ),

                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            actionButton(
                              icon: Icons.add,
                              text: 'Depositar',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const DepositarScreen(),
                                  ),
                                );
                              },
                            ),
                            actionButton(
                              icon: Icons.remove,
                              text: 'Retirar',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const RetirarScreen(),
                                  ),
                                );
                              },
                            ),
                            actionButton(
                              icon: Icons.swap_horiz,
                              text: 'Transferir',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const TransferirScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 35),

                      // esta cosa hacer q vea opciones de esta vaina
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const Text(
                              'Últimos movimientos',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            if (usuario == null ||
                                usuario.historial.isEmpty)
                              const Text('No hay movimientos'),

                            if (usuario != null)
                              ...usuario.historial.reversed
                                  .take(3)
                                  .map(
                                    (movimiento) => Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(18),
                                      ),
                                      child: Text(movimiento),
                                    ),
                                  ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),

                const HistorialScreen(),
                const AjustesScreen(),
              ],
            ),
          ),
        ],
      ),

      // BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menú',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }

  Widget actionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}