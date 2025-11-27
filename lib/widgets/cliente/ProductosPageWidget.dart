import 'dart:io';
import 'package:flutter/foundation.dart';
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

  Widget _buildProductImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
      );
    } else if (imagePath.startsWith('http://') ||
        imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
      );
    } else {
      return kIsWeb
          ? Image.network(imagePath, fit: BoxFit.cover)
          : Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            );
    }
  }

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
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: _buildProductImage(
                                producto['imagenProducto'],
                              ),
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
                                  Text(
                                    '${l10n.stock}: ${producto['stock'] ?? 0}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (producto['stock'] ?? 0) > 0
                                          ? Colors.blue
                                          : Colors.red,
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
                                  onPressed: cantidad > 0
                                      ? () {
                                          CarritoController.decrementarCantidad(
                                            index,
                                          );
                                          onCantidadChanged();
                                        }
                                      : null,
                                ),
                                Text('$cantidad'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: cantidad < (producto['stock'] ?? 0)
                                      ? () {
                                          CarritoController.incrementarCantidad(
                                            index,
                                          );
                                          onCantidadChanged();
                                        }
                                      : null,
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
