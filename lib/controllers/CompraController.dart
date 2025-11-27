import 'package:flutter_application/config/utils/globals.dart';
import 'package:flutter_application/controllers/CarritoController.dart';
import 'package:flutter_application/controllers/LoginPedido.dart';
import 'package:flutter_application/models/Pedido.dart';

// Controlador que gestiona el proceso de compra
class CompraController {
  // Procesa la compra del usuario: crea pedido, guarda datos y limpia carrito
  static void realizarCompra(List productos) {
    // Obtiene los productos del carrito
    List<Map<String, dynamic>> productosPedido =
        CarritoController.obtenerProductosCarrito(productos);

    // Calcula el total de la compra
    double total = CarritoController.calcularTotal(productos);

    // Crea un nuevo pedido con los datos de la compra
    final nuevoPedido = Pedido(
      id: DateTime.now().microsecondsSinceEpoch,
      Usuario: usuarioActual!.name,
      productos: productosPedido,
      total: total,
      fecha: DateTime.now(),
    );

    // Guarda el pedido en el sistema y limpia el carrito
    LogicaPedidos.agregarPedido(nuevoPedido);
    CarritoController.limpiarCarrito();
  }
}
