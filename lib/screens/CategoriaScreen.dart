// screens/categoria_screen.dart
import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/models/Categoria_Producto.dart';
import 'package:fruti_express_jahr/providers/carrito_provider.dart';
import 'package:fruti_express_jahr/widgets/CardProducto.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoriaScreen extends StatelessWidget {
  // ¡Solo recibe esto!
  final Categoria categoria;

  const CategoriaScreen({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          categoria.titulo,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Consumer<CarritoProvider>(
            builder: (context, carrito, child) {
              final int totalUnidades = carrito.totalUnidades;
              return IconButton(
                icon: Badge(
                  label: Text(totalUnidades.toString()),
                  isLabelVisible: totalUnidades > 0,
                  child: const Icon(Icons.shopping_cart, color: Colors.white),
                ),
                onPressed: () {
                  context.push('/carrito');
                },
              );
            },
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: categoria.color,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categoria.productos.length,
          itemBuilder: (context, index) {
            final producto = categoria.productos[index];
            return CardProducto(
              producto: producto,
              onAgregar: () {
                context.read<CarritoProvider>().agregarAlCarrito(producto);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${producto.titulo} agregado al carrito'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
