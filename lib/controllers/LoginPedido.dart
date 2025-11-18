import 'package:flutter_application/models/Pedido.dart';

class ControladorPedidos {
  static List<Pedido> pedidos = [];

  // Método para agregar un nuevo pedido
  static void agregarPedido(Pedido pedido) {
    pedidos.add(pedido);
  }

  // Método para obtener todos los pedidos
  static List<Pedido> obtenerPedidos() {
    return pedidos;
  }

  // Método para obtener los pedidos de un usuario
  static List<Pedido> obtenerPedidosDeUsuario(String usuario) {
    return pedidos.where((pedido) => pedido.Usuario == usuario).toList();
  }

  // Método para eliminar un pedido
  static void eliminarPedido(Pedido pedido) {
    pedidos.remove(pedido);
  }
}
