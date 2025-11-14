import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/models/carrito_item.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fruti_express_jahr/providers/carrito_provider.dart';

class CarritoCompra extends StatefulWidget {
  const CarritoCompra({super.key});
  @override
  State<CarritoCompra> createState() => _CarritoCompra();
}

class _CarritoCompra extends State<CarritoCompra> {
  @override
  Widget build(BuildContext context) {
    final Color colorPrimario = Color.fromARGB(255, 12, 75, 193);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Carrito de compras",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: colorPrimario,
      ),
      body: Consumer<CarritoProvider>(
        builder: (context, carrito, child) {
          if (carrito.items.isEmpty) {
            return _EstadoVacio(colorPrimario: colorPrimario);
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  itemCount: carrito.items.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = carrito.items[index];
                    return _CarritoItemCard(
                      item: item,
                      carritoProvider: carrito,
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal", style: TextStyle(fontSize: 16)),
                        Text(
                          "\$${carrito.subtotal.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Envío", style: TextStyle(fontSize: 16)),
                        Text(
                          "\$${carrito.costoEnvio.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Divider(thickness: 1, height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${carrito.total.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () {
                        context.push("/SeleciconarDirec");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Color.fromARGB(255, 12, 75, 193),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        "Iniciar Compra",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CarritoItemCard extends StatelessWidget {
  final CarritoItem item;
  final CarritoProvider carritoProvider;

  const _CarritoItemCard({required this.item, required this.carritoProvider});

  @override
  Widget build(BuildContext context) {
    final bool conDescuento = item.producto.descuento > 0;
    return Dismissible(
      key: Key(item.producto.titulo),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        carritoProvider.eliminarProducto(item.producto);
      },
      background: Container(
        color: Colors.red[700],
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete_forever, color: Colors.white, size: 30),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  item.producto.imagen,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.producto.titulo,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.red[700],
                          ),
                          onPressed: () {
                            carritoProvider.eliminarProducto(item.producto);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    if (conDescuento)
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${item.producto.descuento}% DE DESCUENTO",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),

                    if (conDescuento)
                      Text(
                        "Precio: \$${item.producto.precio.toStringAsFixed(2)} c/u",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),

                    Text(
                      conDescuento
                          ? "Ahora: \$${item.producto.precioConDescuento.toStringAsFixed(2)} c/u"
                          : "Precio: \$${item.producto.precioConDescuento.toStringAsFixed(2)} c/u",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontWeight: conDescuento
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "\$${(item.producto.precioConDescuento * item.cantidad).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        _ControlesCantidad(
                          item: item,
                          carritoProvider: carritoProvider,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlesCantidad extends StatelessWidget {
  const _ControlesCantidad({required this.item, required this.carritoProvider});

  final CarritoItem item;
  final CarritoProvider carritoProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            splashRadius: 20,
            visualDensity: VisualDensity.compact,
            icon: Icon(Icons.remove, size: 20),
            color: Colors.black87,
            onPressed: () {
              carritoProvider.reducirDelCarrito(item.producto);
            },
          ),

          Text(
            item.cantidad.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          IconButton(
            splashRadius: 20,
            visualDensity: VisualDensity.compact,
            icon: Icon(Icons.add, size: 20),
            color: Colors.black87,
            onPressed: () {
              carritoProvider.agregarAlCarrito(item.producto);
            },
          ),
        ],
      ),
    );
  }
}

class _EstadoVacio extends StatelessWidget {
  final Color colorPrimario;

  const _EstadoVacio({Key? key, required this.colorPrimario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 100,
              color: Colors.grey[400],
            ),
            SizedBox(height: 24),
            Text(
              "Tu carrito está vacío",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            Text(
              "¡Añade productos para empezar tu pedido!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text("Seguir comprando", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPrimario,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
