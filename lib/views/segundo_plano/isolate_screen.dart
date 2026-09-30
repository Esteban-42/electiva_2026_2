import 'package:flutter/material.dart';
import '../../services/isolate_service.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  final _servicio = IsolateService();
  static const int _limite = 1000000000; // ajusta según tu equipo

  bool _trabajando = false;
  String _resultado = 'Sin ejecutar';
  String _tiempo = '';

  Future<void> _conIsolate() async {
    setState(() {
      _trabajando = true;
      _resultado = 'Calculando en Isolate...';
    });
    print('[UI] Lanzando Isolate');
    final sw = Stopwatch()..start();
    final total = await _servicio.ejecutarEnIsolate(_limite);
    sw.stop();
    print('[UI] Resultado recibido: $total en ${sw.elapsedMilliseconds} ms');
    if (!mounted) return;
    setState(() {
      _trabajando = false;
      _resultado = 'Resultado: $total';
      _tiempo = 'Con Isolate: ${sw.elapsedMilliseconds} ms (UI fluida)';
    });
  }

  Future<void> _sinIsolate() async {
    setState(() {
      _trabajando = true;
      _resultado = 'Calculando en hilo principal...';
    });
    // Un momento para que se pinte el mensaje antes de congelar la UI
    await Future.delayed(const Duration(milliseconds: 100));
    final sw = Stopwatch()..start();
    final total = _servicio.ejecutarEnHiloPrincipal(_limite);
    sw.stop();
    if (!mounted) return;
    setState(() {
      _trabajando = false;
      _resultado = 'Resultado: $total';
      _tiempo = 'Sin Isolate: ${sw.elapsedMilliseconds} ms (UI congelada)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Si se congela, se nota que la UI está bloqueada
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(_resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(_tiempo, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _trabajando ? null : _conIsolate,
              child: const Text('Ejecutar con Isolate'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _trabajando ? null : _sinIsolate,
              child: const Text('Ejecutar SIN Isolate (comparar)'),
            ),
          ],
        ),
      ),
    );
  }
}