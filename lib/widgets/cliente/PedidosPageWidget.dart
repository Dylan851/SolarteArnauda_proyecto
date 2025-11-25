import 'package:flutter/material.dart';
import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/LoginPedido.dart';
import 'package:flutter_application/models/Pedido.dart';
import 'package:flutter_application/l10n/app_localizations.dart';

class PedidosPageWidget extends StatelessWidget {
  final ThemeData theme;

  const PedidosPageWidget({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                l10n.noOrdersYet,
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
                  txtEstado = l10n.sent;
                  break;
                case "denegado":
                  colorEstado = Colors.red;
                  txtEstado = l10n.denied;
                  break;
                default:
                  colorEstado = Colors.orange;
                  txtEstado = l10n.inProcess;
              }

              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${l10n.order} #${pedido.id}",
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
                        "${l10n.total}: \$${pedido.total.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${l10n.status}: ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                        "${l10n.date}: ${pedido.fecha.toLocal()}",
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
