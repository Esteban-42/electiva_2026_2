import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taller 1 - Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variable de estado para el título
  String _titulo = 'Hola, Flutter';

  // Cambia el título utilizando setState()
  void _cambiarTitulo() {
    setState(() {
      if (_titulo == 'Hola, Flutter') {
        _titulo = '¡Título cambiado!';
      } else {
        _titulo = 'Hola, Flutter';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Título actualizado'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Nombre del estudiante
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              'Jaime Esteban Jurado Arce',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Imágenes',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          // Row con Image.network() e Image.asset()
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Imagen desde Internet
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a1b2121d08c6f.png',
                  width: 130,
                  height: 130,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 130,
                      height: 130,
                      alignment: Alignment.center,
                      color: Colors.grey.shade200,
                      child: const Text('Error de red'),
                    );
                  },
                ),
              ),

              // Imagen local
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/flutter_local.png',
                  width: 130,
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Botón para cambiar el título
          ElevatedButton.icon(
            onPressed: _cambiarTitulo,
            icon: const Icon(Icons.refresh),
            label: const Text('Cambiar título'),
          ),

          const SizedBox(height: 25),

          const Text(
            'Información del taller',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // ListView con elementos adicionales
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone_android),
              title: const Text('Aplicación móvil'),
              subtitle: const Text('Desarrollo con Flutter'),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.code),
              title: const Text('Código'),
              subtitle: const Text('Dart y widgets de Flutter'),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.account_tree),
              title: const Text('Control de versiones'),
              subtitle: const Text('Git y ramas del proyecto'),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Taller 1'),
              subtitle: const Text('StatefulWidget y setState()'),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: const Text(
              'Esta pantalla demuestra el uso de StatefulWidget, '
              'setState(), imágenes, botones, Container y ListView.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}