class OfertaProducto {
  final String titulo;
  final String precio;
  final String imagen;
  final String descuento;

  const OfertaProducto({
    required this.titulo,
    required this.precio,
    required this.imagen,
    required this.descuento,
  });
}

class OfertasData {
  static List<OfertaProducto> get ofertasDelDia => [
    OfertaProducto(
      titulo: 'Tomate',
      precio: '\$29.99',
      imagen: 'assets/images/ofertas/tomate.jpg',
      descuento: '20%',
    ),
    OfertaProducto(
      titulo: 'Naranja',
      precio: '\$45.50',
      imagen: 'assets/images/ofertas/naranja.jpg',
      descuento: '15%',
    ),
    OfertaProducto(
      titulo: 'Limón',
      precio: '\$19.99',
      imagen: 'assets/images/ofertas/limon.jpg',
      descuento: '30%',
    ),
  ];
}
