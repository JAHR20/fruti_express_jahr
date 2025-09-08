import 'package:flutter/material.dart';

class CarritoCompra extends StatefulWidget {
  const CarritoCompra({super.key});

  @override
  State<CarritoCompra> createState() => _CarritoCompra();
}

class _CarritoCompra extends State<CarritoCompra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Carrito de compras",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 12, 75, 193),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(top: 15),
        child: Column(
          children: [
            Text(
              "Aqui se podrian los articulos añadidos",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
