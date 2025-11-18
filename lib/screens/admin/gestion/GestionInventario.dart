import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/Productos.dart';
import 'package:flutter_application/services/LogicaProductos.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        backgroundColor: const Color.fromARGB(255, 230, 14, 14),
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
                      isThreeLine: true,
                      trailing: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              int nuevaCantidad = producto.getCantidad;
                              return AlertDialog(
                                title: const Text('Modificar Cantidad'),
                                content: TextFormField(
                                  initialValue: producto.getCantidad.toString(),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Cantidad',
                                  ),
                                  onChanged: (value) {
                                    nuevaCantidad = int.tryParse(value) ?? 0;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        producto.setCantidad = nuevaCantidad;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Guardar'),
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
                          backgroundColor: const Color.fromARGB(
                            255,
                            230,
                            14,
                            14,
                          ),
                        ),
                        child: const Text(
                          'Modificar Cantidad',
                          style: TextStyle(fontSize: 12),
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
                side: const BorderSide(
                  color: Color.fromARGB(255, 230, 14, 14),
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
