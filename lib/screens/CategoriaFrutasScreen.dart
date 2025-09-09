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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
    );
  }
}
