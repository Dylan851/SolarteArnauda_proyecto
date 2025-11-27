import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/CompraController.dart';
import 'package:flutter_application/controllers/LoginProductos.dart';
import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/screens/cliente/contactoCliente.dart';
import 'package:flutter_application/screens/cliente/editarUsuarioCliente.dart';
import 'package:flutter_application/widgets/cliente/PedidosPageWidget.dart';
import 'package:flutter_application/widgets/cliente/PerfilPageWidget.dart';
import 'package:flutter_application/widgets/cliente/ProductosPageWidget.dart';
import 'package:flutter_application/widgets/cliente/ResumenCompraDialog.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';
import 'package:flutter_application/l10n/app_localizations.dart';

// Pantalla principal del cliente con acceso a productos, perfil, pedidos y contacto
class PantallaSecundaria extends StatefulWidget {
  const PantallaSecundaria({super.key});

  @override
  State<PantallaSecundaria> createState() => _PantallaSecundariaState();
}

class _PantallaSecundariaState extends State<PantallaSecundaria> {
  int currentPageIndex = 0;

  void _realizarCompra(List productos) {
    CompraController.realizarCompra(productos);
    setState(() {});

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Pedido realizado con éxito")));
  }

  void _mostrarResumenCompra(List productos) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ResumenCompraDialog(
        productos: productos,
        onRealizarCompra: () => _realizarCompra(productos),
      ),
    );
  }

  void _contactoCliente() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => contactoCliente(user: usuarioActual!),
      ),
    );
  }

  void _editarUsuarioCliente() async {
    final updatedUser = await Navigator.push<AppUser>(
      context,
      MaterialPageRoute(
        builder: (context) => EditarUsuarioCliente(user: usuarioActual!),
      ),
    );
    if (updatedUser != null) {
      setState(() {
        usuarioActual = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productos = LoginProductos.recorrerProductos();
    final l10n = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) =>
              setState(() => currentPageIndex = index),
          indicatorColor: Appcolor.backgroundColor,
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: const Icon(Icons.home),
              icon: const Icon(Icons.home_outlined),
              label: l10n.home,
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.shopping_cart),
              icon: const Icon(Icons.shopping_cart_outlined),
              label: l10n.orders,
            ),
            NavigationDestination(
              icon: const Badge(child: Icon(Icons.person)),
              label: l10n.me,
            ),
          ],
        ),
        drawer: const drawerGeneral(),
        appBar: AppBar(
          backgroundColor: Appcolor.backgroundColor,
          title: Text("${l10n.welcome} ${usuarioActual?.name}"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: buildLanguageDropdown(),
            ),
          ],
        ),
        body: <Widget>[
          ProductosPageWidget(
            productos: productos,
            onMostrarResumen: _mostrarResumenCompra,
            onCantidadChanged: () => setState(() {}),
          ),
          PedidosPageWidget(theme: theme),
          PerfilPageWidget(
            onContacto: _contactoCliente,
            onEditarUsuario: _editarUsuarioCliente,
          ),
        ][currentPageIndex],
      ),
    );
  }
}
