class Pedido {
  final int id;
  final String Usuario;
  final List<Map<String, dynamic>> productos;
  final double total;
  String estado; // en_tramite, enviado, denegado
  final DateTime fecha;

  Pedido({
    required this.id,
    required this.Usuario,
    required this.productos,
    required this.total,
    this.estado = "en_tramite",
    required this.fecha,
  });
  // Getters
  int get getIdPedido => id;
  String get getId => Usuario;
  List<Map<String, dynamic>> get getProductos => productos;
  double get getTotal => total;
  String get getEstado => estado;
  DateTime get getFecha => fecha;
}
