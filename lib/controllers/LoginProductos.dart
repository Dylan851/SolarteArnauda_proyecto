import 'package:flutter_application/services/LogicaProductos.dart';

class Loginproductos {
  static List<String> recorrerProductos() {
    List<String> detalles =
        []; // Lista para almacenar los detalles de los productos.

    for (var producto in Logicaproductos.ListaProductos) {
      // Accedemos directamente a las propiedades públicas del modelo Productos
      String nombreProducto = producto.nombre;
      String descripcion = producto.descripcion;
      String precio = producto.precio.toStringAsFixed(2);

      // Concatenamos los detalles en un formato legible.
      detalles.add(
        'Producto: $nombreProducto\n'
        'Descripción: $descripcion\n'
        'Precio: $precio\n',
      );
    }
    return detalles; // Retornamos la lista de detalles de productos.
  }
}
