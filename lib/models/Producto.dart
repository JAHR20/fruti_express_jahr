import 'package:fruti_express_jahr/utils/constants.dart';

enum CategoriaProducto { fruta, verdura, especia }

class Producto {
  final String titulo;
  final double precio;
  final String imagen;
  final CategoriaProducto categoria;
  final int descuento;

  const Producto({
    required this.titulo,
    required this.precio,
    required this.imagen,
    required this.categoria,
    this.descuento = 0,
  });

  double get precioConDescuento {
    if (descuento == 0) return precio;
    return precio - (precio * descuento / 100);
  }
}

class CatalogoData {
  static final List<Producto> _todosLosProductos = [
    Producto(
      titulo: 'Manzana gala',
      precio: 55.00,
      imagen: "assets/images/productos/manzanas.jpg",
      categoria: CategoriaProducto.fruta,
    ),
    Producto(
      titulo: 'Uva Morada',
      precio: 100.00,
      imagen: "$IMAGES_PRODUCT_PATH/uvas_moradas.jpg",
      categoria: CategoriaProducto.fruta,
    ),
    Producto(
      titulo: 'Uva Verde',
      precio: 120.00,
      imagen: "$IMAGES_PRODUCT_PATH/uvas_verdes.jpg",
      categoria: CategoriaProducto.fruta,
    ),
    Producto(
      titulo: 'Plátano',
      precio: 15.00,
      imagen: "$IMAGES_PRODUCT_PATH/platanos.jpg",
      categoria: CategoriaProducto.fruta,
    ),
    Producto(
      titulo: 'Piña',
      precio: 20.00,
      imagen: "$IMAGES_PRODUCT_PATH/pinias.jpg",
      categoria: CategoriaProducto.fruta,
    ),
    Producto(
      titulo: 'Durazno',
      precio: 85.00,
      imagen: "$IMAGES_PRODUCT_PATH/duraznos.jpg",
      categoria: CategoriaProducto.fruta,
    ),
    Producto(
      titulo: 'Naranja',
      precio: 45.50,
      imagen: "$IMAGES_PRODUCT_PATH/naranja.jpg",
      categoria: CategoriaProducto.fruta,
      descuento: 15,
    ),
    Producto(
      titulo: 'Limón',
      precio: 19.99,
      imagen: "$IMAGES_PRODUCT_PATH/limon.jpg",
      categoria: CategoriaProducto.fruta,
      descuento: 30,
    ),
    //----------------------Verduras----------------------------------
    Producto(
      titulo: 'Tomate',
      precio: 29.99,
      imagen: "$IMAGES_PRODUCT_PATH/tomate.jpg",
      categoria: CategoriaProducto.verdura,
      descuento: 20,
    ),
    Producto(
      titulo: 'Cebolla',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/cebolla_blanca.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    Producto(
      titulo: 'Cebolla Morada',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/cebolla_morada.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    Producto(
      titulo: 'Zanahoria',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/zanahoria.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    Producto(
      titulo: 'Papa',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/papa.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    Producto(
      titulo: 'Brocoli',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/brocoli.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    Producto(
      titulo: 'Calabacita',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/calabacita.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    Producto(
      titulo: 'Coliflor',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/coliflor.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    Producto(
      titulo: 'Chile Jalapeño',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/chile_jalapeno.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    Producto(
      titulo: 'Chayote',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/chayote.jpg",
      categoria: CategoriaProducto.verdura,
    ),
    //-----------Especias y chiles secos -------------------------
    Producto(
      titulo: 'Canela',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/canela.jpg",
      categoria: CategoriaProducto.especia,
    ),
    Producto(
      titulo: 'Ajo',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/ajo.jpg",
      categoria: CategoriaProducto.especia,
    ),
    Producto(
      titulo: 'Pimienta Negra',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/pimienta_negra.jpg",
      categoria: CategoriaProducto.especia,
    ),
    Producto(
      titulo: 'Almendra',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/almendra.jpg",
      categoria: CategoriaProducto.especia,
    ),
    Producto(
      titulo: 'Comino',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/comino.jpg",
      categoria: CategoriaProducto.especia,
    ),
    Producto(
      titulo: 'Chipotle',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/chipotle.jpg",
      categoria: CategoriaProducto.especia,
    ),
    Producto(
      titulo: 'Chile de arbol',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/canela.jpg",
      categoria: CategoriaProducto.especia,
    ),
    Producto(
      titulo: 'Canela',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/chile_de_arbol.jpg",
      categoria: CategoriaProducto.especia,
    ),
    Producto(
      titulo: 'Chile_guajillo',
      precio: 50.00,
      imagen: "$IMAGES_PRODUCT_PATH/guajillo.jpg",
      categoria: CategoriaProducto.especia,
    ),
  ];

  static List<Producto> get frutas {
    return _todosLosProductos
        .where((producto) => producto.categoria == CategoriaProducto.fruta)
        .toList();
  }

  static List<Producto> get verduras {
    return _todosLosProductos
        .where((producto) => producto.categoria == CategoriaProducto.verdura)
        .toList();
  }

  static List<Producto> get especias {
    return _todosLosProductos
        .where((producto) => producto.categoria == CategoriaProducto.especia)
        .toList();
  }

  static List<Producto> get todos {
    return _todosLosProductos;
  }

  static List<Producto> get ofertasDelDia {
    return _todosLosProductos.where((p) => p.descuento > 0).toList();
  }
}
