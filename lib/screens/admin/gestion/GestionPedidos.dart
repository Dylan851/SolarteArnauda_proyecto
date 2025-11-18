import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/LoginPedido.dart';
import 'package:flutter_application/models/Productos.dart';
import 'package:flutter_application/models/Pedido.dart';
import 'package:flutter_application/services/LogicaProductos.dart';
import 'package:flutter_application/screens/admin/editarInformacionAdmin/EditarProducto.dart';

class GestionPedidos extends StatefulWidget {
  const GestionPedidos({super.key});

  @override
  State<GestionPedidos> createState() => _GestionPedidosState();
}

class _GestionPedidosState extends State<GestionPedidos> {
  // Lista de pedidos, la cual será cargada desde el controlador
  List<Pedido> pedidos = [];

  @override
  void initState() {
    super.initState();
    _cargarPedidos();
  }

  // Cargar los pedidos
  void _cargarPedidos() {
    setState(() {
      pedidos = ControladorPedidos
          .pedidos; // Obtener todos los pedidos desde el controlador
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Pedidos'),
        backgroundColor: const Color.fromARGB(255, 230, 14, 14),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = pedidos[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        "Pedido #${pedido.getIdPedido} de ${pedido.getId}",
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Estado: ${pedido.getEstado}"),
                          Text(
                            "Total: \$${pedido.getTotal.toStringAsFixed(2)}",
                          ),
                          Text("Fecha: ${pedido.getFecha.toLocal()}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () {
                              // Aquí podrías mostrar más detalles del pedido, como los productos
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
                                    '¿Eliminar el pedido de "${pedido.getId}"?',
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
                                // Aquí se podría eliminar el pedido (no implementado en el controlador)
                                ControladorPedidos.pedidos.remove(pedido);
                                _cargarPedidos();
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Pedido de "${pedido.getId}" eliminado',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
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
              onPressed: () {
                // Aquí podrías crear un nuevo pedido (si es necesario)
                // Navegar a una pantalla para crear pedidos, o hacer alguna acción
              },
              child: const Text('Crear Pedido'),
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
