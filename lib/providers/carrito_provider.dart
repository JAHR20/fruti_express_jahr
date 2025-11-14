import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/models/Producto.dart';
import 'package:fruti_express_jahr/models/carrito_item.dart';

class CarritoProvider extends ChangeNotifier {
  final Map<String, CarritoItem> _items = {};

  Map<String, CarritoItem> get itemsMap => _items;

  List<CarritoItem> get items => _items.values.toList();

  int get totalUnidades {
    int total = 0;
    _items.forEach((key, item) {
      total += item.cantidad;
    });
    return total;
  }

  void agregarAlCarrito(Producto producto) {
    if (_items.containsKey(producto.titulo)) {
      _items[producto.titulo]!.cantidad++;
    } else {
      _items[producto.titulo] = CarritoItem(producto: producto, cantidad: 1);
    }
    notifyListeners();
  }

  void reducirDelCarrito(Producto producto) {
    if (_items.containsKey(producto.titulo)) {
      if (_items[producto.titulo]!.cantidad > 1) {
        _items[producto.titulo]!.cantidad--;
      } else {
        _items.remove(producto.titulo);
      }
      notifyListeners();
    }
  }

  void eliminarProducto(Producto producto) {
    _items.remove(producto.titulo);
    notifyListeners();
  }

  double get subtotal {
    double totalAcumulado = 0.0;
    _items.forEach((key, item) {
      totalAcumulado += (item.producto.precioConDescuento * item.cantidad);
    });
    return totalAcumulado;
  }

  double get costoEnvio {
    if (subtotal > 500.0) {
      return 0.0;
    } else {
      return 50.0;
    }
  }

  double get total {
    return subtotal + costoEnvio;
  }
}
