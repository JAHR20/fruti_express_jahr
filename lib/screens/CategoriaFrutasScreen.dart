import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/model/Frutas.dart';
import 'package:fruti_express_jahr/widgets/CardFruta.dart';

class CategoriafrutasScreen extends StatefulWidget {
  const CategoriafrutasScreen({super.key});

  @override
  State<CategoriafrutasScreen> createState() => _CategoriafrutasScreen();
}

class _CategoriafrutasScreen extends State<CategoriafrutasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Frutas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 12, 75, 193),
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
          itemCount: FrutasData.ofertasDelDia.length,
          itemBuilder: (context, index) {
            final fruta = FrutasData.ofertasDelDia[index];
            return CardFruta(
              titulo: fruta.titulo,
              precio: fruta.precio,
              imagen: fruta.imagen,
              onAgregar: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${fruta.titulo} agregado al carrito'),
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
