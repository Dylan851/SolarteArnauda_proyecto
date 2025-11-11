import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/LoginProductos.dart';
import 'package:flutter_application/widgets/drawerGeneral.dart';

class PantallaSecundaria extends StatefulWidget {
  const PantallaSecundaria({super.key});

  @override
  State<PantallaSecundaria> createState() => _PantallaSecundariaState();
}

class _PantallaSecundariaState extends State<PantallaSecundaria> {
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
    final productos = LoginProductos.recorrerProductos();

    return Scaffold(
      drawer: drawerGeneral(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 14, 14),
        title: Text(
          "Bienvenido ${usuarioActual?.name}",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: [
          // 🔹 Lista de productos
          Expanded(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              icon: const Icon(Icons.remove_circle_outline),
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
                              icon: const Icon(Icons.add_circle_outline),
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
                ElevatedButton.icon(
                  onPressed: () {
                    // Comprar directamente desde aquí
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 230, 14, 14),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  label: const Text(
                    'Comprar Ahora',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
