// Controlador del carrito de compras
class CarritoController {
  // Mapa que almacena las cantidades de cada producto en el carrito
  static Map<int, int> cantidades = {};

  // Calcula el total del carrito multiplicando cantidad por precio
  static double calcularTotal(List productos) {
    double total = 0;
    cantidades.forEach((index, cantidad) {
      if (productos[index]['disponible'] == true) {
        total += productos[index]['precio'] * cantidad;
      }
    });
    return total;
  }

  // Aumenta la cantidad de un producto en el carrito
  static void incrementarCantidad(int index) {
    cantidades[index] = (cantidades[index] ?? 0) + 1;
  }

  // Disminuye la cantidad de un producto (no puede ser negativa)
  static void decrementarCantidad(int index) {
    final cantidad = cantidades[index] ?? 0;
    if (cantidad > 0) {
      cantidades[index] = cantidad - 1;
    }
  }

  // Obtiene la cantidad de un producto en el carrito
  static int obtenerCantidad(int index) {
    return cantidades[index] ?? 0;
  }

  // Vacía el carrito eliminando todos los productos
  static void limpiarCarrito() {
    cantidades.clear();
  }

  // Obtiene la lista de productos del carrito listos para crear un pedido
  static List<Map<String, dynamic>> obtenerProductosCarrito(List productos) {
    List<Map<String, dynamic>> productosPedido = [];

    cantidades.forEach((index, cant) {
      if (cant > 0 && productos[index]['disponible'] == true) {
        productosPedido.add({
          "nombre": productos[index]['nombre'],
          "cantidad": cant,
          "precio": productos[index]['precio'],
        });
      }
    });

    return productosPedido;
  }
}
