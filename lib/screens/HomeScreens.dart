import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/model/Categorias_Productos.dart';
import 'package:fruti_express_jahr/model/OfertaProducto_data.dart';
import 'package:fruti_express_jahr/widgets/CardCategoria.dart';
import 'package:fruti_express_jahr/widgets/CardOferta.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inicio",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 12, 75, 193),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Text(
              "Ofertas del día",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: OfertasData.ofertasDelDia.length,
              itemBuilder: (context, index) {
                final oferta = OfertasData.ofertasDelDia[index];
                return CardOferta(
                  titulo: oferta.titulo,
                  precio: oferta.precio,
                  imagen: oferta.imagen,
                  descuento: oferta.descuento,
                  onTap: () {
                    print("Tocaste una oferta");
                  },
                );
              },
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Text(
              "Categorias",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Column(
            children: List.generate(CategoriasData.categorias.length, (index) {
              final categoria = CategoriasData.categorias[index];
              return CardCategoria(
                titulo: categoria.titulo,
                icono: categoria.icono,
                color: categoria.color,
                onTap: () {
                  Navigator.pushNamed(context, categoria.ruta);
                },
              );
            }),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'carrito');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(
              "Boton de prueba",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
