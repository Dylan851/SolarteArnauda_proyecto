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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pedido realizado con éxito")),
    );
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
    final updatedUser = await Navigator.push<User>(
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) =>
              setState(() => currentPageIndex = index),
          indicatorColor: Appcolor.backgroundColor,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Pedidos',
            ),
            NavigationDestination(
              icon: Badge(label: Text('2'), child: Icon(Icons.person)),
              label: 'Yo',
            ),
          ],
        ),
        drawer: const drawerGeneral(),
        appBar: AppBar(
          backgroundColor: Appcolor.backgroundColor,
          title: Text("Bienvenido ${usuarioActual?.name}"),
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
