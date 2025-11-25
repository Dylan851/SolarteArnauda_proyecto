import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/controllers/CarritoController.dart';
import 'package:flutter_application/l10n/app_localizations.dart';

class ProductosPageWidget extends StatelessWidget {
  final List productos;
  final Function(List) onMostrarResumen;
  final VoidCallback onCantidadChanged;

  const ProductosPageWidget({
    super.key,
    required this.productos,
    required this.onMostrarResumen,
    required this.onCantidadChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                    if (producto['disponible'] != true) {
                      return const SizedBox.shrink();
                    }

                    final cantidad = CarritoController.obtenerCantidad(index);

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
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    CarritoController.decrementarCantidad(index);
                                    onCantidadChanged();
                                  },
                                ),
                                Text('$cantidad'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    CarritoController.incrementarCantidad(index);
                                    onCantidadChanged();
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
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '${l10n.total}: \$${CarritoController.calcularTotal(productos).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => onMostrarResumen(productos),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.backgroundColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    label: Text(
                      l10n.purchaseSummary,
                      style: const TextStyle(color: Colors.white),
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
}
