// Modelo de producto para la tienda
class Productos {
  String nombre;
  String descripcion;
  double precio;
  String? imagenProducto;
  bool disponible;
  int cantidad;

  Productos({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagenProducto,
    this.disponible = true,
    this.cantidad = 0,
  });

  // Getters para acceder a los datos del producto
  String get getNombre => nombre;
  String get getDescripcion => descripcion;
  double get getPrecio => precio;
  String? get getImagenProducto => imagenProducto;
  bool get getDisponible => disponible;
  int get getCantidad => cantidad;

  // Setters para modificar los datos del producto
  set setNombre(String value) => nombre = value;
  set setDescripcion(String value) => descripcion = value;
  set setPrecio(double value) => precio = value;
  set setImagenProducto(String? value) => imagenProducto = value;
  set setDisponible(bool value) => disponible = value;
  set setCantidad(int value) => cantidad = value;
}
