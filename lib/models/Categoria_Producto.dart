import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/models/Producto.dart';

class Categoria {
  final String titulo;
  final IconData icono;
  final Color color;
  final List<Producto> productos;

  const Categoria({
    required this.titulo,
    required this.icono,
    required this.color,
    required this.productos,
  });
}

class CategoriasData {
  static List<Categoria> get categorias => [
    Categoria(
      titulo: 'Frutas',
      icono: Icons.apple,
      color: Colors.red[400]!,
      productos: CatalogoData.frutas,
    ),
    Categoria(
      titulo: 'Verduras',
      icono: Icons.eco,
      color: Colors.green[400]!,
      productos: CatalogoData.verduras,
    ),
    Categoria(
      titulo: 'Especias y chiles secos',
      icono: Icons.grass,
      color: Colors.orange[400]!,
      productos: CatalogoData.especias,
    ),
  ];
}
