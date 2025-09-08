import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/screens/CategoriaFrutasScreen.dart';
import 'package:fruti_express_jahr/screens/HomeScreens.dart';
import 'package:fruti_express_jahr/screens/CarritoCompra.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fruti express Jahr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 12, 75, 193),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/frutas': (context) => CategoriafrutasScreen(),
        '/carrito': (context) => CarritoCompra(),
      },
    );
  }
}
