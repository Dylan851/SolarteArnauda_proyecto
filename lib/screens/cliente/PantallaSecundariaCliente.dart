import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/LoginPedido.dart';
import 'package:flutter_application/controllers/LoginProductos.dart';
import 'package:flutter_application/models/Pedido.dart';
import 'package:flutter_application/models/User.dart';
import 'package:flutter_application/screens/cliente/contactoCliente.dart';
import 'package:flutter_application/screens/cliente/editarUsuarioCliente.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';

class PantallaSecundaria extends StatefulWidget {
  const PantallaSecundaria({super.key});

  @override
  State<PantallaSecundaria> createState() => _PantallaSecundariaState();
}

class _PantallaSecundariaState extends State<PantallaSecundaria> {
  int currentPageIndex = 0;

  Map<int, int> cantidades = {};

  double _calcularTotal(List productos) {
    double total = 0;
    cantidades.forEach((index, cantidad) {
      if (productos[index]['disponible'] == true) {
        total += productos[index]['precio'] * cantidad;
      }
    });
    return total;
  }

  void _realizarCompra(List productos) {
    List<Map<String, dynamic>> productosPedido = [];

    cantidades.forEach((index, cant) {
      if (cant > 0 && productos[index]['disponible'] == true) {
        productosPedido.add({
          "nombre": productos[index]['nombre'],
          "cantidad": cant,
          "precio": productos[index]['precio'],
        });
      }
    });

    double total = _calcularTotal(productos);

    final nuevoPedido = Pedido(
      id: DateTime.now().microsecondsSinceEpoch,
      Usuario: usuarioActual!.name,
      productos: productosPedido,
      total: total,
      fecha: DateTime.now(),
    );

    // AHORA → LogicaPedidos
    LogicaPedidos.agregarPedido(nuevoPedido);

    setState(() {
      cantidades.clear();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Pedido realizado con éxito")));
  }

  void _mostrarResumenCompra(List productos) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Resumen de compra",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                ...cantidades.entries.where((e) => e.value > 0).map((e) {
                  final producto = productos[e.key];
                  return ListTile(
                    leading: Image.asset(
                      producto['imagenProducto'],
                      width: 40,
                      height: 40,
                    ),
                    title: Text(producto['nombre']),
                    subtitle: Text("Cantidad: ${e.value}"),
                    trailing: Text(
                      "\$${(producto['precio'] * e.value).toStringAsFixed(2)}",
                    ),
                  );
                }),

                const Divider(),
                Text(
                  "Total: \$${_calcularTotal(productos).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _realizarCompra(productos);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.backgroundColor,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text(
                    "Realizar compra",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

    return Scaffold(
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

      drawer: drawerGeneral(),

      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        title: Text("Bienvenido ${usuarioActual?.name}"),
      ),

      body: <Widget>[
        // ----- PÁGINA DE PRODUCTOS -----
        _buildProductosPage(productos),

        // ----- PÁGINA DE PEDIDOS -----
        _buildPedidosPage(theme),

        // ----- PÁGINA DE USUARIO -----
        _buildPerfilPage(),
      ][currentPageIndex],
    );
  }

  // ------------------------------------------------------------
  // PÁGINA 1: PRODUCTOS
  // ------------------------------------------------------------
  Widget _buildProductosPage(List productos) {
    return Card(
      child: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    if (producto['disponible'] != true)
                      return SizedBox.shrink();

                    final cantidad = cantidades[index] ?? 0;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.asset(
                              producto['imagenProducto'],
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    producto['nombre'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(producto['descripcion']),
                                  Text(
                                    '\$${producto['precio'].toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    if (cantidad > 0) {
                                      setState(() {
                                        cantidades[index] = cantidad - 1;
                                      });
                                    }
                                  },
                                ),
                                Text('$cantidad'),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      cantidades[index] = cantidad + 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Total: \$${_calcularTotal(productos).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: () => _mostrarResumenCompra(productos),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.backgroundColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    label: Text(
                      'Resumen de compra',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PÁGINA 2: MIS PEDIDOS
  // ------------------------------------------------------------
  Widget _buildPedidosPage(ThemeData theme) {
    return Card(
      child: FutureBuilder(
        future: Future.delayed(
          Duration(milliseconds: 200),
          () => LogicaPedidos.obtenerPedidosDeUsuario(usuarioActual!.name),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final pedidos = snapshot.data as List<Pedido>;

          if (pedidos.isEmpty) {
            return Center(
              child: Text(
                "No tienes pedidos aún",
                style: theme.textTheme.headlineMedium,
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidos[index];

              Color colorEstado;
              String txtEstado;

              switch (pedido.estado) {
                case "enviado":
                  colorEstado = Colors.green;
                  txtEstado = "Enviado";
                  break;
                case "denegado":
                  colorEstado = Colors.red;
                  txtEstado = "Denegado";
                  break;
                default:
                  colorEstado = Colors.orange;
                  txtEstado = "En trámite";
              }

              return Card(
                margin: EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pedido #${pedido.id}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      ...pedido.productos.map((prod) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${prod['cantidad']} x ${prod['nombre']}"),
                            Text(
                              "\$${(prod['cantidad'] * prod['precio']).toStringAsFixed(2)}",
                            ),
                          ],
                        );
                      }),

                      Divider(),

                      Text(
                        "Total: \$${pedido.total.toStringAsFixed(2)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          Text(
                            "Estado: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            txtEstado,
                            style: TextStyle(
                              color: colorEstado,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),
                      Text(
                        "Fecha: ${pedido.fecha.toLocal()}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // PÁGINA 3: PERFIL USUARIO
  // ------------------------------------------------------------
  Widget _buildPerfilPage() {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300.0),
              child: ElevatedButton(
                onPressed: _contactoCliente,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.contact_mail),
                    SizedBox(width: 10),
                    Text('Contacto'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 300.0),
              child: ElevatedButton(
                onPressed: _editarUsuarioCliente,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text('Editar Usuario'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
