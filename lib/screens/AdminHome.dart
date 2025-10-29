import 'package:flutter/material.dart';
import 'package:flutter_application/screens/GestionUsuarios.dart';
import 'package:flutter_application/screens/GestionPedidos.dart';
import 'package:flutter_application/screens/GestionProductos.dart';
import 'package:flutter_application/screens/GestionInventario.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de administración'),
        backgroundColor: const Color.fromRGBO(61, 180, 228, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GestionUsuarios(),
                  ),
                );
              },
              child: const Text('Gestion Usuarios'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GestionPedidos(),
                  ),
                );
              },
              child: const Text('Gestion Pedidos'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GestionProductos(),
                  ),
                );
              },
              child: const Text('Gestion Productos'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(300, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GestionInventario(),
                  ),
                );
              },
              child: const Text('Gestion Inventario'),
            ),
          ],
        ),
      ),
    );
  }
}
