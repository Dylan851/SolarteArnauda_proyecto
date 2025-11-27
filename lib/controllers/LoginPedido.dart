import 'package:flutter_application/models/Pedido.dart';

// Servicio que gestiona los pedidos del sistema
class LogicaPedidos {
  // Lista de todos los pedidos realizados
  static List<Pedido> _pedidos = [];

  // Añade un nuevo pedido al sistema
  static void agregarPedido(Pedido pedido) {
    _pedidos.add(pedido);
  }

  // Retorna todos los pedidos del sistema
  static List<Pedido> obtenerPedidos() {
    return _pedidos;
  }

  // Obtiene los pedidos de un usuario específico
  static List<Pedido> obtenerPedidosDeUsuario(String usuario) {
    return _pedidos.where((pedido) => pedido.Usuario == usuario).toList();
  }

  // Elimina un pedido del sistema
  static void eliminarPedido(Pedido pedido) {
    _pedidos.remove(pedido);
  }

  // Actualiza el estado de un pedido
  static void cambiarEstado(Pedido pedido, String nuevoEstado) {
    pedido.estado = nuevoEstado;
  }
}
