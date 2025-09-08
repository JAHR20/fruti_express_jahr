class Frutas {
  final String titulo;
  final String precio;
  final String imagen;

  const Frutas({
    required this.titulo,
    required this.precio,
    required this.imagen,
  });
}

class FrutasData {
  static List<Frutas> get ofertasDelDia => [
    Frutas(
      titulo: 'Manzana gala',
      precio: '\$55.00',
      imagen: 'assets/images/frutas/manzanas.jpg',
    ),
    Frutas(
      titulo: 'Uva Morada',
      precio: '\$100.00',
      imagen: 'assets/images/frutas/uvas_moradas.jpg',
    ),
    Frutas(
      titulo: 'Uva Verde',
      precio: '\$120.00',
      imagen: 'assets/images/frutas/uvas_verdes.jpg',
    ),
    Frutas(
      titulo: 'Plátano',
      precio: '\$15.00',
      imagen: 'assets/images/frutas/platanos.jpg',
    ),
    Frutas(
      titulo: 'Piña',
      precio: '\$20.00',
      imagen: 'assets/images/frutas/pinias.jpg',
    ),
    Frutas(
      titulo: 'Durazno',
      precio: '\$85.00',
      imagen: 'assets/images/frutas/duraznos.jpg',
    ),
  ];
}
