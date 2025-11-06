import 'package:flutter_application/models/Productos.dart';

class LogicaProductos {
  static final List<Productos> _listaProductos = [
    Productos(
      nombre: "Pre Entreno Calavera",
      descripcion:
          "Energía explosiva y máxima concentración para tus entrenamientos más intensos. Ideal para quienes buscan romper sus límites.",
      precio: 10.0,
      imagenProducto: "assets/images/imagenesProductos/preEntrenoCalavera.png",
    ),
    Productos(
      nombre: "Pre Entreno Goku",
      descripcion:
          "Despierta tu poder interior con una fórmula avanzada que aumenta fuerza, enfoque y resistencia. ¡Entrena como un verdadero guerrero!",
      precio: 20.0,
      imagenProducto: "assets/images/imagenesProductos/preEntrenoGoku.png",
    ),
    Productos(
      nombre: "Pre Entreno Gorilla",
      descripcion:
          "Potencia tu rendimiento con una dosis extrema de energía y bombeo muscular. Perfecto para sesiones de alto rendimiento.",
      precio: 30.0,
      imagenProducto: "assets/images/imagenesProductos/preGorilla.png",
    ),
  ];

  static List<Productos> getListaProductos() {
    return _listaProductos;
  }

  static void agregarProducto(Productos producto) {
    _listaProductos.add(producto);
  }

  static void eliminarProducto(String nombre) {
    _listaProductos.removeWhere((p) => p.nombre == nombre);
  }

  static void actualizarProducto(
    String nombreOriginal,
    String nuevoNombre,
    String nuevaDescripcion,
    double nuevoPrecio,
    String? nuevaImagen,
    bool nuevoDisponible,
  ) {
    final producto = _listaProductos.firstWhere(
      (p) => p.nombre == nombreOriginal,
      orElse: () => throw Exception('Producto no encontrado'),
    );

    producto.setNombre = nuevoNombre;
    producto.setDescripcion = nuevaDescripcion;
    producto.setPrecio = nuevoPrecio;
    producto.setImagenProducto = nuevaImagen;
    producto.setDisponible = nuevoDisponible;
  }
}
