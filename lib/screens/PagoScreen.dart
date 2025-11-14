import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/data/local/database.dart';
import 'package:fruti_express_jahr/providers/carrito_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ResumenDePagoScreen extends StatelessWidget {
  // 1. RECIBE LA DIRECCIÓN SELECCIONADA
  // (Necesitarás pasarla desde go_router)
  final Direccion direccion;

  const ResumenDePagoScreen({Key? key, required this.direccion})
    : super(key: key);

  // --- (Copiamos el helper de íconos de la pantalla anterior) ---
  Icon _getIconForAlias(String alias) {
    final String aliasLower = alias.toLowerCase();
    if (aliasLower.contains('casa')) {
      return Icon(Icons.home, color: Colors.brown[400]);
    } else if (aliasLower.contains('oficina') ||
        aliasLower.contains('trabajo')) {
      return Icon(Icons.work, color: Colors.deepPurple[400]);
    } else {
      return Icon(Icons.location_on, color: Colors.grey[600]);
    }
  }

  // --- (Helper "Clean Code" para las filas de totales) ---
  Widget _buildTotalRow(
    BuildContext context,
    String title,
    double value, {
    bool isTotal = false,
  }) {
    // Usa los estilos del Tema de la app
    final style = isTotal
        ? Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.grey[700]);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style),
          Text("\$${value.toStringAsFixed(2)}", style: style),
        ],
      ),
    );
  }

  // --- ¡EL MÉTODO BUILD! ---
  @override
  Widget build(BuildContext context) {
    // 2. LEE EL CARRITO (con 'watch' para que se actualice si algo cambia)
    final carrito = context.watch<CarritoProvider>();
    final totalString = carrito.total.toStringAsFixed(2);
    final colorPrimario = Color.fromARGB(255, 12, 75, 193); // Tu color

    return Scaffold(
      backgroundColor: Colors.grey[100], // Fondo sutil
      appBar: AppBar(
        title: const Text(
          "Resumen de Pedido",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: colorPrimario,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),

      // 3. EL BOTÓN DE PAGO FINAL (fijo abajo)
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0).copyWith(bottom: 24),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorPrimario,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Confirmación"),
                content: const Text(
                  "Se te redirigirá a la pasarela de pago (Stripe, MercadoPago, etc.). "
                  "Este paso simula el proceso de pago real.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cierra el alert
                      // Aquí iría la integración real posteriormente
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Redirigiendo al pago..."),
                        ),
                      );
                    },
                    child: const Text("Continuar"),
                  ),
                ],
              ),
            );
          },

          // Texto dinámico en el botón
          child: Text(
            "Pagar \$$totalString",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      // 4. EL CUERPO (con ListView para el scroll)
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- SECCIÓN 1: DIRECCIÓN DE ENTREGA ---
          Text(
            "Se entregará en:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: _getIconForAlias(direccion.alias),
              title: Text(
                direccion.alias,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              subtitle: Text(
                "${direccion.calle} ${direccion.numeroExt}, ${direccion.colonia}\n${direccion.municipio}, ${direccion.estado}",
              ),
              isThreeLine: true,
              // Botón para volver a la pantalla anterior a editar
              trailing: TextButton(
                child: Text("Editar"),
                onPressed: () {
                  context.pop(); // Vuelve a SeleccionarDireccionScreen
                },
              ),
            ),
          ),
          SizedBox(height: 24),

          // --- SECCIÓN 2: RESUMEN DE PRODUCTOS ---
          Text(
            "Productos en tu carrito:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            // Usamos un Column para los items (no un ListView anidado)
            child: Column(
              children: [
                ...carrito.items
                    .map(
                      (item) => ListTile(
                        leading: Text(
                          "${item.cantidad}x",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        title: Text(item.producto.titulo),
                        trailing: Text(
                          "\$${(item.producto.precio * item.cantidad).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          SizedBox(height: 24),

          // --- SECCIÓN 3: RESUMEN DE COSTOS ---
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTotalRow(context, "Subtotal", carrito.subtotal),
                  _buildTotalRow(context, "Envío", carrito.costoEnvio),
                  Divider(height: 24, thickness: 1, color: Colors.grey[300]),
                  _buildTotalRow(
                    context,
                    "Total",
                    carrito.total,
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
