import 'package:flutter/material.dart';

class Categoria {
  final String titulo;
  final IconData icono;
  final Color color;
  final String ruta;

  const Categoria({
    required this.titulo,
    required this.icono,
    required this.color,
    required this.ruta,
  });
}

class CategoriasData {
  static List<Categoria> get categorias => [
    Categoria(
      titulo: 'Frutas',
      icono: Icons.apple,
      color: Colors.red[300]!,
      ruta: '/frutas',
    ),
    Categoria(
      titulo: 'Verduras',
      icono: Icons.eco,
      color: Colors.green[300]!,
      ruta: '/verduras',
    ),
    Categoria(
      titulo: 'Especias',
      icono: Icons.grass,
      color: Colors.yellow[300]!,
      ruta: '/especias',
    ),
  ];
}
