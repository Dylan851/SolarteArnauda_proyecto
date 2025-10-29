import 'package:flutter/material.dart';

class GestionProductos extends StatelessWidget {
  const GestionProductos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        backgroundColor: const Color.fromRGBO(61, 180, 228, 1),
      ),
      body: const Center(child: Text('Aquí irá la gestión de productos.')),
    );
  }
}
