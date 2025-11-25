import 'package:flutter/material.dart';
import 'package:flutter_application/config/resources/appColor.dart';
import 'package:flutter_application/controllers/CarritoController.dart';
import 'package:flutter_application/l10n/app_localizations.dart';

class ResumenCompraDialog extends StatelessWidget {
  final List productos;
  final VoidCallback onRealizarCompra;

  const ResumenCompraDialog({
    super.key,
    required this.productos,
    required this.onRealizarCompra,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.purchaseSummary,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...CarritoController.cantidades.entries
                .where((e) => e.value > 0)
                .map((e) {
                  final producto = productos[e.key];
                  return ListTile(
                    leading: Image.asset(
                      producto['imagenProducto'],
                      width: 40,
                      height: 40,
                    ),
                    title: Text(producto['nombre']),
                    subtitle: Text("${l10n.quantity}: ${e.value}"),
                    trailing: Text(
                      "\$${(producto['precio'] * e.value).toStringAsFixed(2)}",
                    ),
                  );
                }),
            const Divider(),
            Text(
              "${l10n.total}: \$${CarritoController.calcularTotal(productos).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onRealizarCompra();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.backgroundColor,
                minimumSize: const Size(double.infinity, 45),
              ),
              child: Text(
                l10n.makePurchase,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
