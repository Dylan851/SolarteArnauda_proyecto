class CarritoController {
  static Map<int, int> cantidades = {};

  static double calcularTotal(List productos) {
    double total = 0;
    cantidades.forEach((index, cantidad) {
      if (productos[index]['disponible'] == true) {
        total += productos[index]['precio'] * cantidad;
      }
    });
    return total;
  }

  static void incrementarCantidad(int index) {
    cantidades[index] = (cantidades[index] ?? 0) + 1;
  }

  static void decrementarCantidad(int index) {
    final cantidad = cantidades[index] ?? 0;
    if (cantidad > 0) {
      cantidades[index] = cantidad - 1;
    }
  }

  static int obtenerCantidad(int index) {
    return cantidades[index] ?? 0;
  }

  static void limpiarCarrito() {
    cantidades.clear();
  }

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
