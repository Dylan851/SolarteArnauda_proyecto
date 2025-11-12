import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/LoginProductos.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';

class PantallaSecundaria extends StatefulWidget {
  const PantallaSecundaria({super.key});

  @override
  State<PantallaSecundaria> createState() => _PantallaSecundariaState();
}

class _PantallaSecundariaState extends State<PantallaSecundaria> {
  int currentPageIndex = 0;

  // Mapa que guarda la cantidad seleccionada por cada producto
  Map<int, int> cantidades = {};

  double _calcularTotal(List productos) {
    double total = 0;
    cantidades.forEach((index, cantidad) {
      // Solo calcular el total para productos disponibles
      if (productos[index]['disponible'] == true) {
        total += productos[index]['precio'] * cantidad;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final productos = LoginProductos.recorrerProductos();

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
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
        title: Text(
          "Bienvenido ${usuarioActual?.name}",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: <Widget>[
        Card(
          child: SizedBox.expand(
            child: Column(
              children: [
                // 🔹 Lista de productos
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ListView.builder(
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final producto = productos[index];
                        // Solo mostrar productos disponibles
                        if (producto['disponible'] != true) {
                          return const SizedBox.shrink(); // No mostrar productos no disponibles
                        }
                        final cantidad = cantidades[index] ?? 0;

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                // Imagen del producto
                                Image.asset(
                                  producto['imagenProducto'],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 10),

                                // Información del producto
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        producto['nombre'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        producto['descripcion'],
                                        style: const TextStyle(fontSize: 13),
                                      ),
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

                                // Botones de + y -
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (cantidad > 0) {
                                            cantidades[index] = cantidad - 1;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '$cantidad',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
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

                // 🔹 Botón fijo al final
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total: \$${_calcularTotal(productos).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 00.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Comprar directamente desde aquí
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.backgroundColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Resumen de compra',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Center(
            child: Text(
              'Página de Pedidos',
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ),
        Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300.0),
                  child: ElevatedButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.contact_mail),
                        SizedBox(width: 10, height: 50),
                        Text('contacto'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300.0),
                  child: ElevatedButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.person),
                        SizedBox(width: 10, height: 50),
                        Text('Editar Usuario'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}
