import 'package:flutter_application/services/LogicaProductos.dart';

class Loginproductos {
static List<Map<String, dynamic>> recorrerProductos() {
    List<Map<String, dynamic>> detalles = [];
    for (var producto in Logicaproductos.ListaProductos) {

      detalles.add({
        'nombre': producto.nombre,
        'descripcion': producto.descripcion,
        'precio': producto.precio,
        'imagenProducto': producto.imagenProducto,
      });
    }
    return detalles;
  }
}
