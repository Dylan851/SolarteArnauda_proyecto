import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';
import 'package:flutter_application/screens/admin/gestion/GestionUsuarios.dart';
import 'package:flutter_application/screens/admin/gestion/GestionPedidos.dart';
import 'package:flutter_application/screens/admin/gestion/GestionProductos.dart';
import 'package:flutter_application/screens/admin/gestion/GestionInventario.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Clear user session
        usuarioActual = null;
        // Navigate to login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Panel de administración'),
          backgroundColor: Appcolor.backgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Clear user session
              usuarioActual = null;
              // Navigate to login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const PantallaPrincipal()),
                (route) => false,
              );
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  backgroundColor: Appcolor.backgroundColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GestionUsuarios(),
                    ),
                  );
                },
                child: const Text('Gestion Usuarios', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  backgroundColor: Appcolor.backgroundColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GestionPedidos(),
                    ),
                  );
                },
                child: const Text('Gestion Pedidos', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  backgroundColor: Appcolor.backgroundColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GestionProductos(),
                    ),
                  );
                },
                child: const Text('Gestion Productos', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  backgroundColor: Appcolor.backgroundColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GestionInventario(),
                    ),
                  );
                },
                child: const Text('Gestion Inventario', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
