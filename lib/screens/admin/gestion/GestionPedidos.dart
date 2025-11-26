import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/controllers/LoginPedido.dart';
import 'package:flutter_application/l10n/app_localizations.dart';
import 'package:flutter_application/models/Pedido.dart';
import 'package:flutter_application/widgets/buildLanguageSwitch.dart';

class GestionPedidos extends StatefulWidget {
  const GestionPedidos({super.key});

  @override
  State<GestionPedidos> createState() => _GestionPedidosState();
}

class _GestionPedidosState extends State<GestionPedidos> {
  List<Pedido> pedidos = [];

  @override
  void initState() {
    super.initState();
    _cargarPedidos();
  }

  void _cargarPedidos() {
    setState(() {
      pedidos = LogicaPedidos.obtenerPedidos();
    });
  }

  void _mostrarCambiarEstado(Pedido pedido) {
    String estadoActual = pedido.estado;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Cambiar estado del pedido"),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return DropdownButton<String>(
                value: estadoActual,
                items: const [
                  DropdownMenuItem(
                    value: "en_tramite",
                    child: Text("En trámite"),
                  ),
                  DropdownMenuItem(value: "enviado", child: Text("Enviado")),
                  DropdownMenuItem(value: "denegado", child: Text("Denegado")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setStateDialog(() => estadoActual = value);
                  }
                },
              );
            },
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Guardar"),
              onPressed: () {
                LogicaPedidos.cambiarEstado(pedido, estadoActual);

                setState(() {});
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Estado actualizado a $estadoActual")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.manageOrders),
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
                itemCount: pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = pedidos[index];
                  return Card(
                    child: ListTile(
                      title: Text("Pedido #${pedido.id} de ${pedido.Usuario}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Estado: ${pedido.estado}"),
                          Text("Total: \$${pedido.total.toStringAsFixed(2)}"),
                          Text("Fecha: ${pedido.fecha.toLocal()}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Cambiar estado
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () => _mostrarCambiarEstado(pedido),
                          ),

                          // Eliminar
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Appcolor.backgroundColor,
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirmar eliminación'),
                                  content: Text(
                                    '¿Eliminar el pedido de "${pedido.Usuario}"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Cancelar'),
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                    ),
                                    TextButton(
                                      child: const Text('Eliminar'),
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                LogicaPedidos.eliminarPedido(pedido);
                                _cargarPedidos();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Pedido eliminado')),
                                );
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

            const SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                side: BorderSide(color: Appcolor.backgroundColor, width: 1.5),
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
