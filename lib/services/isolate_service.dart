import 'dart:isolate';

class TareaPesada {
  final SendPort sendPort;
  final int limite;
  TareaPesada(this.sendPort, this.limite);
}

/// Función CPU-bound (top-level, requisito para Isolate.spawn).
void _suma(TareaPesada tarea) {
  print('[ISOLATE] Iniciando cálculo pesado...');
  int total = 0;
  for (int i = 1; i <= tarea.limite; i++) {
    total += i;
  }
  print('[ISOLATE] Cálculo terminado: $total');
  tarea.sendPort.send(total);
}

class IsolateService {
  Future<int> ejecutarEnIsolate(int limite) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      _suma,
      TareaPesada(receivePort.sendPort, limite),
    );

    final resultado = await receivePort.first as int;

    receivePort.close();
    isolate.kill(priority: Isolate.immediate);
    return resultado;
  }

  /// Misma suma en el hilo principal, para comparar (congela la UI).
  int ejecutarEnHiloPrincipal(int limite) {
    print('[MAIN] Iniciando cálculo pesado en hilo principal...');
    int total = 0;
    for (int i = 1; i <= limite; i++) {
      total += i;
    }
    print('[MAIN] Cálculo terminado: $total');
    return total;
  }
}