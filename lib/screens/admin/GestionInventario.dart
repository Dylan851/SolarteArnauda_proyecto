import 'package:flutter/material.dart';

class GestionInventario extends StatelessWidget {
  const GestionInventario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Inventario'),
        backgroundColor: const Color.fromRGBO(61, 180, 228, 1),
      ),
      body: const Center(child: Text('Aquí irá la gestión de inventario.')),
    );
  }
}
