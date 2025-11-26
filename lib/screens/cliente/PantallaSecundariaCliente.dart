import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/CompraController.dart';
import 'package:flutter_application/controllers/LoginProductos.dart';
import 'package:flutter_application/controllers/CarritoController.dart';
import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/screens/cliente/contacto.dart';
import 'package:flutter_application/screens/cliente/editarUsuarioCliente.dart';
import 'package:flutter_application/widgets/cliente/PedidosPageWidget.dart';
import 'package:flutter_application/widgets/cliente/PerfilPageWidget.dart';
import 'package:flutter_application/widgets/cliente/ProductosPageWidget.dart';
import 'package:flutter_application/widgets/cliente/ResumenCompraDialog.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/services/LogicaProductos.dart';

class PantallaSecundaria extends StatefulWidget {
  const PantallaSecundaria({super.key});

  @override
  State<PantallaSecundaria> createState() => _PantallaSecundariaState();
}

class _PantallaSecundariaState extends State<PantallaSecundaria> {
  int currentPageIndex = 0;

  bool _validarStock(List productos) {
    for (int i = 0; i < productos.length; i++) {
      final cantidad = CarritoController.obtenerCantidad(i);
      final stock = productos[i]['stock'] ?? 0;
      if (cantidad > stock) {
        return false;
      }
    }
    return true;
  }

  void _realizarCompra(List productos) {
    if (!_validarStock(productos)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("La cantidad solicitada excede el stock disponible"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Restar el stock de cada producto comprado
    for (int i = 0; i < productos.length; i++) {
      final cantidad = CarritoController.obtenerCantidad(i);
      if (cantidad > 0) {
        final producto = LogicaProductos.getListaProductos()[i];
        final nuevoStock = producto.getStock - cantidad;
        producto.setStock = nuevoStock;
      }
    }

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
      MaterialPageRoute(builder: (context) => contacto(user: usuarioActual!)),
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
    var productos = LoginProductos.recorrerProductos();

    // Asegurar que todos los productos tengan stock
    productos = productos.map((p) {
      p['stock'] = p['stock'] ?? 0;
      return p;
    }).toList();

    final l10n = AppLocalizations.of(context)!;

    // Debug: imprime los productos para verificar que tengan stock
    for (var p in productos) {
      print('Producto: ${p['nombre']}, Stock: ${p['stock']}');
    }

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
          title: Text("${l10n.welcome} ${usuarioActual?.name ?? l10n.user}"),
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
