import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/models/Productos.dart';
import 'package:flutter_application/services/LogicaProductos.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

class GestionInventario extends StatefulWidget {
  const GestionInventario({super.key});

  @override
  State<GestionInventario> createState() => _GestionInventarioState();
}

class _GestionInventarioState extends State<GestionInventario> {
  List<Productos> productos = [];

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  void _cargarProductos() {
    setState(() {
      productos = LogicaProductos.getListaProductos();
    });
  }

  Widget _buildProductImage(String imagePath) {
    // Si es una ruta de assets
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
      );
    }
    // Si es una URL (Chrome, web, etc.)
    else if (imagePath.startsWith('http://') ||
        imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
      );
    }
    // Si es una ruta local (Drag and Drop, cámara, galería)
    else {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.inventoryManagementTitle),
        backgroundColor: Appcolor.backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: buildLanguageDropdown(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return Card(
                    child: ListTile(
                      leading: producto.getImagenProducto != null
                          ? SizedBox(
                              width: 50,
                              height: 50,
                              child: _buildProductImage(
                                producto.getImagenProducto!,
                              ),
                            )
                          : const CircleAvatar(child: Icon(Icons.shopping_bag)),
                      title: Text(producto.getNombre),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(producto.getDescripcion),
                          Text(
                            '\$${producto.getPrecio.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Appcolor.accent,
                            ),
                          ),
                          Text(
                            '${l10n.stock}: ${producto.getStock}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              int nuevoStock = producto.getStock;
                              return AlertDialog(
                                title: Text(l10n.modifyQuantity),
                                content: TextFormField(
                                  initialValue: producto.getStock.toString(),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: l10n.stock,
                                  ),
                                  onChanged: (value) {
                                    nuevoStock = int.tryParse(value) ?? 0;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(l10n.cancel),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        producto.setStock = nuevoStock;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(l10n.save),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          backgroundColor: Appcolor.backgroundColor,
                        ),
                        child: Text(
                          l10n.modifyQuantity,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: Appcolor.backgroundColor,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.returnText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
