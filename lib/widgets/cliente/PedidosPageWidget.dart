import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/LoginPedido.dart';
import 'package:flutter_application/models/Pedido.dart';

class PedidosPageWidget extends StatelessWidget {
  final ThemeData theme;

  const PedidosPageWidget({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder(
        future: Future.delayed(
          const Duration(milliseconds: 200),
          () => LogicaPedidos.obtenerPedidosDeUsuario(usuarioActual!.name),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final pedidos = snapshot.data as List<Pedido>;

          if (pedidos.isEmpty) {
            return Center(
              child: Text(
                "No tienes pedidos aún",
                style: theme.textTheme.headlineMedium,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidos[index];

              Color colorEstado;
              String txtEstado;

              switch (pedido.estado) {
                case "enviado":
                  colorEstado = Colors.green;
                  txtEstado = "Enviado";
                  break;
                case "denegado":
                  colorEstado = Colors.red;
                  txtEstado = "Denegado";
                  break;
                default:
                  colorEstado = Colors.orange;
                  txtEstado = "En trámite";
              }

              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pedido #${pedido.id}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...pedido.productos.map((prod) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${prod['cantidad']} x ${prod['nombre']}"),
                            Text(
                              "\$${(prod['cantidad'] * prod['precio']).toStringAsFixed(2)}",
                            ),
                          ],
                        );
                      }),
                      const Divider(),
                      Text(
                        "Total: \$${pedido.total.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Estado: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            txtEstado,
                            style: TextStyle(
                              color: colorEstado,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Fecha: ${pedido.fecha.toLocal()}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
