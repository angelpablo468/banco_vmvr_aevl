class Usuario {
  final String nombre;
  final String correo;
  final String password;
  final String numeroCuenta;

  double saldo;

  List<String> historial;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.password,
    required this.numeroCuenta,
    this.saldo = 0,
    List<String>? historial,
  }) : historial = historial ?? [];
}