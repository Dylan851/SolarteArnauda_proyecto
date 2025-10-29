import 'package:flutter/material.dart';

class GestionUsuarios extends StatelessWidget {
  const GestionUsuarios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        backgroundColor: const Color.fromRGBO(61, 180, 228, 1),
      ),
      body: const Center(child: Text('Aquí irá la gestión de usuarios.')),
    );
  }
}
