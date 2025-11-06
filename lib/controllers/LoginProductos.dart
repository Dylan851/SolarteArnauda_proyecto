import 'package:flutter_application/services/LogicaProductos.dart';

class LoginProductos {
  static List<Map<String, dynamic>> recorrerProductos() {
    List<Map<String, dynamic>> detalles = [];
    for (var producto in LogicaProductos.getListaProductos()) {
      detalles.add({
        'nombre': producto.getNombre,
        'descripcion': producto.getDescripcion,
        'precio': producto.getPrecio,
        'imagenProducto': producto.getImagenProducto,
        'disponible': producto.getDisponible,
      });
    }
    return detalles;
  }
}
