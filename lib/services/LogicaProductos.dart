import 'package:flutter_application/models/Productos.dart';

class Logicaproductos {
  static final List<Productos> _ListaProductos = [
    Productos(
      nombre: "Producto 1",
      descripcion: "Descripción del Producto 1",
      precio: 10.0,
      imagenProducto: "assets/images/producto1.png",
    ),
    Productos(
      nombre: "Producto 2",
      descripcion: "Descripción del Producto 2",
      precio: 20.0,
      imagenProducto: "assets/images/producto2.png",
    ),
    Productos(
      nombre: "Producto 3",
      descripcion: "Descripción del Producto 3",
      precio: 30.0,
      imagenProducto: "assets/images/producto3.png",
    ),
  ];
}
