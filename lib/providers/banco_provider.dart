import 'package:flutter/material.dart';
import '../models/usuario.dart';

class BancoProvider extends ChangeNotifier {

  List<Usuario> usuarios = [];
  Usuario? usuarioActual;

  bool ocultarSaldo = false;
  bool modoOscuro = false;

  int _contadorCuentas = 2;

  
  Map<String, dynamic>? notificacion;

  BancoProvider() {
    _initUsuarios();
  }

  void _initUsuarios() {
    usuarios.add(
      Usuario(
        nombre: "pablo",
        correo: "pablo@gmail.com",
        password: "123456",
        numeroCuenta: "0001",
        saldo: 1000,
        historial: [],
      ),
    );
  }

  void mostrarNotificacion({
    required String mensaje,
    String tipo = "info",
    String icono = "info",
  }) {
    notificacion = {
      "mensaje": mensaje,
      "tipo": tipo,
      "icono": icono,
      "timestamp": DateTime.now().toIso8601String(),
    };

    notifyListeners();

    Future.delayed(const Duration(seconds: 2), () {
      notificacion = null;
      notifyListeners();
    });
  }


  String procesarNumero(String input) {
    if (input == "67") return "SIXSEVEN";
    return input;
  }

  
  bool iniciarSesion(String nombre, String password) {
    try {
      usuarioActual = usuarios.firstWhere(
        (u) =>
            u.nombre.toLowerCase() == nombre.toLowerCase() &&
            u.password == password,
      );

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool crearCuenta({
    required String nombre,
    required String correo,
    required String password,
  }) {
    final existe = usuarios.any((u) => u.correo == correo);
    if (existe) return false;

    String numeroCuenta = _contadorCuentas.toString().padLeft(4, '0');
    _contadorCuentas++;

    usuarios.add(
      Usuario(
        nombre: nombre,
        correo: correo,
        password: password,
        numeroCuenta: numeroCuenta,
      ),
    );

    notifyListeners();
    return true;
  }

  void depositar(double monto) {
    usuarioActual!.saldo += monto;

    usuarioActual!.historial.add(
      'Depósito +\$${monto.toStringAsFixed(2)}',
    );

    mostrarNotificacion(
      mensaje: "Depósito +\$${monto.toStringAsFixed(2)}",
      tipo: "success",
      icono: "deposit",
    );

    notifyListeners();
  }

  bool retirar(double monto) {
    if (usuarioActual!.saldo < monto) return false;

    usuarioActual!.saldo -= monto;

    usuarioActual!.historial.add(
      'Retiro -\$${monto.toStringAsFixed(2)}',
    );

    mostrarNotificacion(
      mensaje: "Retiro -\$${monto.toStringAsFixed(2)}",
      tipo: "success",
      icono: "withdraw",
    );

    notifyListeners();
    return true;
  }

  bool transferir(String cuentaDestino, double monto) {
    if (usuarioActual == null) return false;
    if (monto > usuarioActual!.saldo) return false;

    try {
      final receptor = usuarios.firstWhere(
        (u) => u.numeroCuenta == cuentaDestino,
      );

      if (receptor.numeroCuenta == usuarioActual!.numeroCuenta) {
        return false;
      }

      usuarioActual!.saldo -= monto;
      receptor.saldo += monto;

      usuarioActual!.historial.add(
        'Transferencia enviada -\$${monto.toStringAsFixed(2)}',
      );

      receptor.historial.add(
        'Transferencia recibida +\$${monto.toStringAsFixed(2)}',
      );

      mostrarNotificacion(
        mensaje: "Transferencia a ${procesarNumero(cuentaDestino)}",
        tipo: "info",
        icono: "transfer",
      );

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void cambiarOcultarSaldo() {
    ocultarSaldo = !ocultarSaldo;
    notifyListeners();
  }

  void cambiarModoOscuro() {
    modoOscuro = !modoOscuro;
    notifyListeners();
  }

  void cerrarSesion() {
    usuarioActual = null;
    notifyListeners();
  }
}