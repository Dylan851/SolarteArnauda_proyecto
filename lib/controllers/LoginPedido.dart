import 'package:flutter_application/models/Pedido.dart';

class ControladorPedidos {
  static List<Pedido> pedidos = [];

  static void agregarPedido(Pedido pedido) {
    pedidos.add(pedido);
  }

  static List<Pedido> obtenerPedidosDeUsuario(String usuario) {
    List<Pedido> pedidoCliente = [];
    for (Pedido pedido in pedidos) {
      if (pedido.Usuario == usuario) {
        pedidoCliente.add(pedido);
      }
    }
    return pedidoCliente;
  }
}
