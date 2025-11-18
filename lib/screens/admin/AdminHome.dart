import 'package:flutter/material.dart';
import 'package:flutter_application/screens/admin/gestion/GestionUsuarios.dart';
import 'package:flutter_application/screens/admin/gestion/GestionPedidos.dart';
import 'package:flutter_application/screens/admin/gestion/GestionProductos.dart';
import 'package:flutter_application/screens/admin/gestion/GestionInventario.dart';

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
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                side: const BorderSide(color: Colors.blue, width: 1.5),
              ), //esta es la gestion de usuarios
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
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),

                side: const BorderSide(color: Colors.blue, width: 1.5),
              ),
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
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                side: const BorderSide(color: Colors.blue, width: 1.5),
              ),
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
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                side: const BorderSide(color: Colors.blue, width: 1.5),
              ),
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
