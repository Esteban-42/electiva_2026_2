import 'dart:math';

class DatosService {
  /// Simula una consulta a un servidor (2-3 segundos).
  Future<List<String>> consultarDatos({bool forzarError = false}) async {
    print('[SERVICIO] Iniciando consulta...');
    final segundos = 2 + Random().nextInt(2); // 2 o 3 s
    await Future.delayed(Duration(seconds: segundos));

    if (forzarError) {
      throw Exception('Error simulado de red');
    }

    print('[SERVICIO] Consulta terminada en $segundos s');
    return ['Usuario 1', 'Usuario 2', 'Usuario 3', 'Usuario 4'];
  }
}