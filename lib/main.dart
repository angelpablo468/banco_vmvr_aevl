import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/banco_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BancoProvider(),
      child: Consumer<BancoProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
            ),

     
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),

            themeMode: provider.modoOscuro
                ? ThemeMode.dark
                : ThemeMode.light,

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}