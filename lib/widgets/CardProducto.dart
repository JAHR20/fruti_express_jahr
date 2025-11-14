// lib/widgets/CardProducto.dart
import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/models/Producto.dart'; // <-- ¡Importante!

class CardProducto extends StatelessWidget {
  // --- ¡EL GRAN CAMBIO! ---
  // Ya no aceptamos strings. Aceptamos el objeto completo.
  final Producto producto;
  final VoidCallback? onAgregar;

  const CardProducto({
    Key? key,
    required this.producto, // <-- Requerimos el objeto
    this.onAgregar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // El 'CardProducto' ahora sabe si hay descuento
    final bool conDescuento = producto.descuento > 0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias, // Para que el Stack respete los bordes
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- 1. IMAGEN (Ahora con Stack para la etiqueta) ---
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  // --- La Imagen (como la tenías) ---
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        producto.imagen, // <-- Usa el objeto
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                              size: 100,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // --- ¡LA ETIQUETA DE DESCUENTO! ---
                  // Solo se muestra si 'conDescuento' es true
                  if (conDescuento)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "%${producto.descuento}", // <-- Usa el objeto
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // --- 2. TÍTULO (Usa el objeto) ---
            Text(
              producto.titulo,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // --- 3. LÓGICA DE PRECIO (El gran cambio) ---
            if (conDescuento) ...[
              // Si hay descuento, muestra AMBOS precios

              // Precio CON descuento (grande)
              Text(
                "\$${producto.precioConDescuento.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.green[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              // Precio ORIGINAL (tachado y pequeño)
              Text(
                "\$${producto.precio.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough, // ¡Tachado!
                  fontSize: 14,
                ),
              ),
            ] else ...[
              // Si NO hay descuento, muestra solo un precio

              // Precio normal
              Text(
                "\$${producto.precio.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.green[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              // Añadimos un espacio para que no "salte" la UI
              const SizedBox(height: 19),
            ],

            const SizedBox(height: 5),

            // --- 4. BOTÓN (se queda igual) ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAgregar,
                icon: Icon(
                  Icons.add_shopping_cart,
                  size: 18,
                  color: Colors.white,
                ),
                label: Text(
                  'Agregar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
