import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/config/utils/Camera.dart';
import 'package:flutter_application/models/Productos.dart';

class EditarProducto extends StatefulWidget {
  final Productos? producto;

  const EditarProducto({super.key, this.producto});

  @override
  State<EditarProducto> createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;
  String? imageUrl;
  bool _disponible = true;

  @override
  void initState() {
    super.initState();
    // Inicializar con los datos del producto si existe
    _nombreController = TextEditingController(
      text: widget.producto?.getNombre ?? '',
    );
    _descripcionController = TextEditingController(
      text: widget.producto?.getDescripcion ?? '',
    );
    _precioController = TextEditingController(
      text: widget.producto?.getPrecio.toString() ?? '',
    );
    imageUrl = widget.producto?.getImagenProducto;
    _disponible = widget.producto?.getDisponible ?? true;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_nombreController.text.isEmpty ||
        _descripcionController.text.isEmpty ||
        _precioController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Todos los campos son obligatorios")),
      );
      return;
    }

    final double? precio = double.tryParse(_precioController.text);
    if (precio == null || precio <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("El precio debe ser un número válido mayor que 0"),
        ),
      );
      return;
    }

    // Retornar los datos del producto
    final productData = {
      'nombre': _nombreController.text,
      'descripcion': _descripcionController.text,
      'precio': precio,
      'imageUrl': imageUrl,
      'disponible': _disponible,
    };

    Navigator.pop(context, productData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 14, 14),
        title: Text(
          widget.producto == null ? "Nuevo Producto" : "Editar Producto",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: "Nombre del producto",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Descripción",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Precio",
                  prefixText: "\$",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Imagen del producto:"),
                  if (imageUrl != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: imageUrl!.startsWith('assets/')
                            ? Image.asset(imageUrl!, fit: BoxFit.cover)
                            : Image.file(File(imageUrl!), fit: BoxFit.cover),
                      ),
                    ),
                  const Spacer(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    label: const Text("Galería"),
                    onPressed: () async {
                      final path = await CameraGalleryService().selectPhoto();
                      if (path == null) return;
                      setState(() {
                        imageUrl = path;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Cámara"),
                    onPressed: () async {
                      final path = await CameraGalleryService().takePhoto();
                      if (path == null) return;
                      setState(() {
                        imageUrl = path;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Disponible para la venta"),
                  const Spacer(),
                  Switch(
                    value: _disponible,
                    onChanged: (bool value) {
                      setState(() {
                        _disponible = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 40),
                    backgroundColor: const Color.fromARGB(255, 230, 14, 14),
                  ),
                  onPressed: _guardar,
                  child: Text(
                    widget.producto == null
                        ? "Crear Producto"
                        : "Guardar Cambios",
                    style: const TextStyle(
                      color: const Color.fromARGB(255, 230, 14, 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 40),
                    backgroundColor: const Color.fromARGB(255, 230, 14, 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 230, 14, 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
