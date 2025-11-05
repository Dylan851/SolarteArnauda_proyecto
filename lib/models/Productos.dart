class Productos {
  String nombre;
  String descripcion;
  double precio;
  String? imagenProducto;

  Productos({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagenProducto,
  });
  String get getNombre => nombre;
  String get getDescripcion => descripcion;
  double get getPrecio => precio;
  String? get getImagenProducto => imagenProducto;
}
