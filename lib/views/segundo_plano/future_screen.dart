import 'package:flutter/material.dart';
import '../../services/datos_service.dart';

enum Estado { inicial, cargando, exito, error }

class FutureScreen extends StatefulWidget {
  const FutureScreen({super.key});

  @override
  State<FutureScreen> createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {
  final _servicio = DatosService();
  Estado _estado = Estado.inicial;
  List<String> _datos = [];
  String _mensajeError = '';

  Future<void> _cargar({bool forzarError = false}) async {
    print('--- ANTES de la consulta ---');
    setState(() => _estado = Estado.cargando);

    try {
      print('--- DURANTE: esperando con await (la UI sigue libre) ---');
      final resultado =
          await _servicio.consultarDatos(forzarError: forzarError);
      if (!mounted) return;
      setState(() {
        _datos = resultado;
        _estado = Estado.exito;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _mensajeError = e.toString();
        _estado = Estado.error;
      });
    } finally {
      print('--- DESPUÉS: consulta finalizada (estado: $_estado) ---');
    }
  }

  Widget _contenido() {
    switch (_estado) {
      case Estado.inicial:
        return const Text('Presiona un botón para consultar');
      case Estado.cargando:
        return const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando...', style: TextStyle(fontSize: 20)),
          ],
        );
      case Estado.exito:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const Text('Éxito', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            ..._datos.map((d) => Text(d)),
          ],
        );
      case Estado.error:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const Text('Error', style: TextStyle(fontSize: 22)),
            Text(_mensajeError),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future / async / await')),
      body: Center(child: _contenido()),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'ok',
            onPressed: _estado == Estado.cargando ? null : () => _cargar(),
            label: const Text('Consultar'),
            icon: const Icon(Icons.cloud_download),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'err',
            backgroundColor: Colors.red.shade200,
            onPressed: _estado == Estado.cargando
                ? null
                : () => _cargar(forzarError: true),
            label: const Text('Forzar error'),
            icon: const Icon(Icons.warning),
          ),
        ],
      ),
    );
  }
}