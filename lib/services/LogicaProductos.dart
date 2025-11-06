import 'package:flutter_application/models/Productos.dart';

class Logicaproductos {
  static final List<Productos> ListaProductos = [
    Productos(
      nombre: "Pre Entreno Calavera",
      descripcion: "Energía explosiva y máxima concentración para tus entrenamientos más intensos. Ideal para quienes buscan romper sus límites.",
      precio: 10.0,
      imagenProducto: "assets/images/imagenesProductos/preEntrenoCalavera.png",
    ),
    Productos(
      nombre: "Pre Entreno Goku",
      descripcion: "Despierta tu poder interior con una fórmula avanzada que aumenta fuerza, enfoque y resistencia. ¡Entrena como un verdadero guerrero!",
      precio: 20.0,
      imagenProducto: "assets/images/imagenesProductos/preEntrenoGoku.png",
    ),
    Productos(
      nombre: "Pre Entreno Gorilla",
      descripcion: "Potencia tu rendimiento con una dosis extrema de energía y bombeo muscular. Perfecto para sesiones de alto rendimiento.",
      precio: 30.0,
      imagenProducto: "assets/images/imagenesProductos/preGorilla.png",
    ),
  ];
  static List<Productos> getlistaProductos() {
    return ListaProductos;
  }

  static void anadirProducto(Productos producto) {
    ListaProductos.add(producto);
  }
}
