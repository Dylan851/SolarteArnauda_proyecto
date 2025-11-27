import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/screens/PantallaPrincipal.dart';
import 'package:flutter_application/screens/admin/gestion/GestionUsuarios.dart';
import 'package:flutter_application/screens/admin/gestion/GestionPedidos.dart';
import 'package:flutter_application/screens/admin/gestion/GestionProductos.dart';
import 'package:flutter_application/screens/admin/gestion/GestionInventario.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

// Pantalla principal del administrador con opciones de gestión
class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          title: Text(l10n.adminPanel),
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
          actions: [Padding(padding: const EdgeInsets.only(right: 8), child: buildLanguageDropdown())],
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
                child: Text(l10n.manageUsers, style: const TextStyle(color: Colors.white)),
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
                child: Text(l10n.manageOrders, style: const TextStyle(color: Colors.white)),
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
                child: Text(l10n.manageProducts, style: const TextStyle(color: Colors.white)),
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
                child: Text(l10n.manageInventory, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
