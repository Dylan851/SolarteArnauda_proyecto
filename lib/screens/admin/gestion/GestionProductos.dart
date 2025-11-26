import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/models/Productos.dart';
import 'package:flutter_application/screens/admin/editarInformacionAdmin/EditarProducto.dart';
import 'package:flutter_application/services/LogicaProductos.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

class GestionProductos extends StatefulWidget {
  const GestionProductos({super.key});

  @override
  State<GestionProductos> createState() => _GestionProductosState();
}

class _GestionProductosState extends State<GestionProductos> {
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

  void _crearProducto() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditarProducto()),
    );

    if (result != null) {
      final newProduct = Productos(
        nombre: result['nombre'],
        descripcion: result['descripcion'],
        precio: result['precio'],
        imagenProducto: result['imagenProducto'],
        disponible: result['disponible'],
      );

      LogicaProductos.agregarProducto(newProduct);
      _cargarProductos();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Producto creado exitosamente")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.productsManagementTitle),
        backgroundColor: Appcolor.backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: buildLanguageDropdown(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Appcolor.backgroundColor,
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditarProducto(producto: producto),
                                ),
                              );

                              if (result != null) {
                                LogicaProductos.actualizarProducto(
                                  producto.getNombre,
                                  result['nombre'],
                                  result['descripcion'],
                                  result['precio'],
                                  result['imagenProducto'],
                                  result['disponible'],
                                );
                                _cargarProductos();
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.productUpdated),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Appcolor.backgroundColor,
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(l10n.confirmDeletionTitle),
                                  content: Text(
                                    '${l10n.deleteProductQuestionPrefix} "${producto.getNombre}"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text(l10n.cancel),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text(l10n.delete),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                LogicaProductos.eliminarProducto(
                                  producto.getNombre,
                                );
                                _cargarProductos();
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${l10n.delete} "${producto.getNombre}"',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          Icon(
                            Icons.circle,
                            color: producto.getDisponible
                                ? Appcolor.accent
                                : Colors.grey,
                            size: 12,
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                side: const BorderSide(
                  color: Appcolor.backgroundColor,
                  width: 1.5,
                ),
              ),
              onPressed: _crearProducto,
              child: Text(l10n.createUser.replaceAll('Usuario', 'Producto')),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                side: const BorderSide(
                  color: Appcolor.backgroundColor,
                  width: 1.5,
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.returnText),
            ),
          ],
        ),
      ),
    );
  }
}
