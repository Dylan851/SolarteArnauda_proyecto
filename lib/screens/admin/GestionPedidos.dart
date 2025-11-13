import 'package:flutter/material.dart';

class GestionPedidos extends StatelessWidget {
  const GestionPedidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Pedidos'),
        backgroundColor: const Color.fromARGB(255, 230, 14, 14),
      ),
      body: const Center(child: Text('Aquí irá la gestión de pedidos.')),
    );
  }
}
