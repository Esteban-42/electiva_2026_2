import 'package:flutter/material.dart';
import 'future_screen.dart';
import 'cronometro_screen.dart';
import 'isolate_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _ir(BuildContext context, Widget pantalla) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => pantalla));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taller Segundo Plano')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Future / async / await'),
            onTap: () => _ir(context, const FutureScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Cronómetro (Timer)'),
            onTap: () => _ir(context, const CronometroScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.memory),
            title: const Text('Tarea pesada (Isolate)'),
            onTap: () => _ir(context, const IsolateScreen()),
          ),
        ],
      ),
    );
  }
}