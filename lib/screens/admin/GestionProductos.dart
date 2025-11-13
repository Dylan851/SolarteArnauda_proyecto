import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/Productos.dart';
import 'package:flutter_application/screens/admin/EditarProducto.dart';
import 'package:flutter_application/services/LogicaProductos.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        backgroundColor: const Color.fromARGB(255, 230, 14, 14),
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
                              child: kIsWeb
                                  ? Image.network(
                                      producto.getImagenProducto!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.image_not_supported,
                                              ),
                                    )
                                  : Image.network(
                                      producto.getImagenProducto!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.image_not_supported,
                                              ),
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
                              color: Colors.green,
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
                              color: const Color.fromARGB(255, 230, 14, 14),
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
                                    const SnackBar(
                                      content: Text(
                                        "Producto actualizado exitosamente",
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirmar eliminación'),
                                  content: Text(
                                    '¿Eliminar el producto "${producto.getNombre}"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text('Eliminar'),
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
                                        'Producto "${producto.getNombre}" eliminado',
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
                                ? Colors.green
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
                  color: const Color.fromARGB(255, 230, 14, 14),
                  width: 1.5,
                ),
              ),
              onPressed: _crearProducto,
              child: const Text('Crear Producto'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                side: const BorderSide(
                  color: const Color.fromARGB(255, 230, 14, 14),
                  width: 1.5,
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
