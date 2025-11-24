import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/CarritoController.dart';
import 'package:flutter_application/controllers/LoginPedido.dart';
import 'package:flutter_application/models/Pedido.dart';

class CompraController {
  static void realizarCompra(List productos) {
    List<Map<String, dynamic>> productosPedido =
        CarritoController.obtenerProductosCarrito(productos);

    double total = CarritoController.calcularTotal(productos);

    final nuevoPedido = Pedido(
      id: DateTime.now().microsecondsSinceEpoch,
      Usuario: usuarioActual!.name,
      productos: productosPedido,
      total: total,
      fecha: DateTime.now(),
    );

    LogicaPedidos.agregarPedido(nuevoPedido);
    CarritoController.limpiarCarrito();
  }
}
