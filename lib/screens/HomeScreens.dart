// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/models/Categoria_Producto.dart';
import 'package:fruti_express_jahr/models/Producto.dart';
import 'package:fruti_express_jahr/services/notification_service.dart';
import 'package:fruti_express_jahr/widgets/CardCategoria.dart';
import 'package:fruti_express_jahr/widgets/CardOferta.dart';
import 'package:fruti_express_jahr/widgets/UserProfileModal.dart';
import 'package:fruti_express_jahr/providers/carrito_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ofertas = CatalogoData.ofertasDelDia;
  @override
  void initState() {
    super.initState();
    NotificationService.instance.initialize(context);
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        context.go("/login");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sesión cerrada con exitó'),
            backgroundColor: Colors.deepOrange,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cerrar sesión: ${e.toString()}')),
        );
      }
    }
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Cerrar Sesión'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  void _showUserProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        return UserProfileModal(
          onLogout: () async {
            Navigator.of(modalContext).pop();
            final bool? didConfirm = await _showConfirmationDialog(context);
            if (didConfirm == true) {
              _signOut(context);
            }
          },
        );
      },
    );
  }

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
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _showUserProfileModal(context),
            color: Colors.white,
          ),
        ],
        backgroundColor: Color.fromARGB(255, 12, 75, 193),
      ),
      body: SingleChildScrollView(
        child: Column(
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
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ofertas.length,
                itemBuilder: (context, index) {
                  final oferta = ofertas[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(22),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Imagen
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    oferta.imagen,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  oferta.titulo,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$${oferta.precio}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        "%${oferta.descuento}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<CarritoProvider>()
                                          .agregarAlCarrito(oferta);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "${oferta.titulo} agregado al carrito",
                                          ),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.add_shopping_cart),
                                    label: const Text("Agregar al carrito"),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: CardOferta(producto: oferta),
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
              children: List.generate(CategoriasData.categorias.length, (
                index,
              ) {
                final categoria = CategoriasData.categorias[index];
                return CardCategoria(
                  titulo: categoria.titulo,
                  icono: categoria.icono,
                  color: categoria.color,
                  onTap: () {
                    context.push("/categoria", extra: categoria);
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            /*ElevatedButton(
              onPressed: () {
                context.push("/carrito");
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                "Boton de prueba para ir al carrito",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registro');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                "Boton para ir a ingresar usuario",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ApiRickAndMorty');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                "Boton para ir a consumir la API REST",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),¨*/
          ],
        ),
      ),
    );
  }
}
