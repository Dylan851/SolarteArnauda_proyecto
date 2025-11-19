import 'package:flutter_application/models/Pedido.dart';

class LogicaPedidos {
  static List<Pedido> _pedidos = [];

  // Agregar pedido
  static void agregarPedido(Pedido pedido) {
    _pedidos.add(pedido);
  }

  // Obtener todos los pedidos
  static List<Pedido> obtenerPedidos() {
    return _pedidos;
  }

  // Obtener pedidos de un usuario
  static List<Pedido> obtenerPedidosDeUsuario(String usuario) {
    return _pedidos.where((pedido) => pedido.Usuario == usuario).toList();
  }

  // Eliminar un pedido
  static void eliminarPedido(Pedido pedido) {
    _pedidos.remove(pedido);
  }

  // Cambiar estado
  static void cambiarEstado(Pedido pedido, String nuevoEstado) {
    pedido.estado = nuevoEstado;
  }
}
