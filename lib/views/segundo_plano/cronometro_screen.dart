import 'dart:async';
import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';

class CronometroScreen extends StatefulWidget {
  const CronometroScreen({super.key});

  @override
  State<CronometroScreen> createState() => _CronometroScreenState();
}

class _CronometroScreenState extends State<CronometroScreen> {
  Timer? _timer;
  int _milisegundos = 0;
  bool _corriendo = false;
  bool _iniciado = false;

  void _iniciar() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() => _milisegundos += 100);
    });
    setState(() {
      _corriendo = true;
      _iniciado = true;
    });
    print('[TIMER] Iniciado/Reanudado');
  }

  void _pausar() {
    _timer?.cancel();
    setState(() => _corriendo = false);
    print('[TIMER] Pausado en $_milisegundos ms');
  }

  void _reiniciar() {
    _timer?.cancel();
    setState(() {
      _milisegundos = 0;
      _corriendo = false;
      _iniciado = false;
    });
    print('[TIMER] Reiniciado');
  }

  String _formato() {
    final d = Duration(milliseconds: _milisegundos);
    String dos(int n) => n.toString().padLeft(2, '0');
    final decimas = d.inMilliseconds.remainder(1000) ~/ 100;
    return '${dos(d.inMinutes)}:${dos(d.inSeconds.remainder(60))}.$decimas';
  }

  @override
  void dispose() {
    _timer?.cancel(); // limpieza de recursos al salir de la vista
    print('[TIMER] dispose: timer cancelado');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronómetro')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _formato(),
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              children: [
                if (!_corriendo && !_iniciado)
                  ElevatedButton(
                      onPressed: _iniciar, child: const Text('Iniciar')),
                if (_corriendo)
                  ElevatedButton(
                      onPressed: _pausar, child: const Text('Pausar')),
                if (!_corriendo && _iniciado)
                  ElevatedButton(
                      onPressed: _iniciar, child: const Text('Reanudar')),
                OutlinedButton(
                    onPressed: _reiniciar, child: const Text('Reiniciar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}