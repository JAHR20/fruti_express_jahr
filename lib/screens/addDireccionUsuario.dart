import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/service_locator.dart';
import 'package:fruti_express_jahr/services/SyncService.dart';
import 'package:fruti_express_jahr/widgets/FormDireccion.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import 'package:fruti_express_jahr/data/local/database.dart';
import 'package:fruti_express_jahr/providers/auth_provider.dart';
import 'package:fruti_express_jahr/utils/constants.dart';

class SeleccionarDireccionScreen extends StatefulWidget {
  const SeleccionarDireccionScreen({super.key});

  @override
  _SeleccionarDireccionScreenState createState() =>
      _SeleccionarDireccionScreenState();
}

class _SeleccionarDireccionScreenState
    extends State<SeleccionarDireccionScreen> {
  final AppDatabase database = locator<AppDatabase>();

  final _formKey = GlobalKey<FormState>();

  final _aliasController = TextEditingController();
  final _calleController = TextEditingController();
  final _numeroExtController = TextEditingController();
  final _numeroIntController = TextEditingController();
  final _coloniaController = TextEditingController();
  final _codigoPostalController = TextEditingController();

  Direccion? _direccionSeleccionada;

  @override
  void dispose() {
    _aliasController.dispose();
    _calleController.dispose();
    _numeroExtController.dispose();
    _numeroIntController.dispose();
    _coloniaController.dispose();
    _codigoPostalController.dispose();
    super.dispose();
  }

  void _mostrarFormularioDialog({Direccion? direccion}) {
    if (direccion != null) {
      _aliasController.text = direccion.alias;
      _calleController.text = direccion.calle;
      _numeroExtController.text = direccion.numeroExt;
      _numeroIntController.text = direccion.numeroInt;
      _coloniaController.text = direccion.colonia;
      _codigoPostalController.text = direccion.codigoPostal;
    } else {
      _aliasController.clear();
      _calleController.clear();
      _numeroExtController.clear();
      _numeroIntController.clear();
      _coloniaController.clear();
      _codigoPostalController.clear();
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            direccion == null ? "Añadir Dirección" : "Editar Dirección",
          ),
          content: SingleChildScrollView(
            child: FormDireccion(
              formKey: _formKey,
              aliasController: _aliasController,
              calleController: _calleController,
              numeroExtController: _numeroExtController,
              numeroIntController: _numeroIntController,
              coloniaController: _coloniaController,
              codigoPostalController: _codigoPostalController,
            ),
          ),
          actions: [
            TextButton(child: Text("Cancelar"), onPressed: () => context.pop()),
            ElevatedButton(
              child: Text("Guardar"),
              onPressed: () {
                _guardarDireccion(direccionAEditar: direccion);
              },
            ),
          ],
        );
      },
    );
  }

  void _guardarDireccion({Direccion? direccionAEditar}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final perfil = context.read<AuthProvider>().perfilLocal;
    if (perfil == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: Usuario no encontrado"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final int idUsuarioLocal = perfil.id;

    final companion = DireccionesCompanion(
      usuarioId: drift.Value(idUsuarioLocal),
      alias: drift.Value(_aliasController.text),
      calle: drift.Value(_calleController.text),
      numeroExt: drift.Value(_numeroExtController.text),
      numeroInt: drift.Value(_numeroIntController.text),
      colonia: drift.Value(_coloniaController.text),
      codigoPostal: drift.Value(_codigoPostalController.text),
      municipio: drift.Value(APP_MUNICIPIO_FIJA),
      estado: drift.Value(APP_ESTADO_FIJO),

      isSynced: drift.Value(false),
      updatedAt: drift.Value(DateTime.now()),
    );

    try {
      if (direccionAEditar == null) {
        await database.insertDireccion(companion);
      } else {
        final companionConId = companion.copyWith(
          id: drift.Value(direccionAEditar.id),
        );
        await database.updateDireccion(companionConId);
      }
      locator<SyncService>().syncPendingData();
      context.pop(); // Cierra el diálogo
    } catch (e) {
      // Error (usualmente de la BD local, que es muy raro)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al guardar localmente: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Icon _getIconForAlias(String alias) {
    // Normaliza el texto para encontrar la palabra clave
    final String aliasLower = alias.toLowerCase();

    if (aliasLower.contains('casa')) {
      return Icon(Icons.home, color: Colors.brown[400]);
    } else if (aliasLower.contains('oficina') ||
        aliasLower.contains('trabajo')) {
      return Icon(Icons.work, color: Colors.deepPurple[400]);
    } else {
      // Ícono por defecto
      return Icon(Icons.location_on, color: Colors.grey[600]);
    }
  }

  // --- ¡MÉTODO BUILD ACTUALIZADO! ---
  @override
  Widget build(BuildContext context) {
    final perfilLocal = context.watch<AuthProvider>().perfilLocal;

    if (perfilLocal == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("Cargando perfil...")),
      );
    }

    final int idUsuarioLocalReal = perfilLocal.id;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Seleccionar Dirección",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 75, 193),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormularioDialog(),
        child: const Icon(Icons.add),
        tooltip: 'Añadir nueva dirección',
        backgroundColor: const Color.fromARGB(255, 12, 75, 193),
        foregroundColor: Colors.white,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 12, 75, 193),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: _direccionSeleccionada == null
              ? null
              : () {
                  context.push('/pago', extra: _direccionSeleccionada);
                },
          child: const Text(
            "Continuar al Pago",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),

      body: StreamBuilder<List<Direccion>>(
        stream: database.watchDireccionesDelUsuario(idUsuarioLocalReal),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final direcciones = snapshot.data ?? [];

          if (direcciones.isEmpty) {
            return const Center(
              child: Text("No tienes direcciones registradas."),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              12,
              12,
              12,
              100,
            ), // ← Para que NO lo tape el FAB
            itemCount: direcciones.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final direccion = direcciones[index];
              final bool isSelected =
                  _direccionSeleccionada?.id == direccion.id;

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isSelected
                      ? const BorderSide(
                          color: Color.fromARGB(255, 12, 75, 193),
                          width: 2,
                        )
                      : BorderSide.none,
                ),
                clipBehavior: Clip.antiAlias,
                child: RadioListTile<int>(
                  contentPadding: const EdgeInsets.fromLTRB(8, 12, 12, 12),
                  value: direccion.id,
                  groupValue: _direccionSeleccionada?.id,
                  onChanged: (_) {
                    setState(() => _direccionSeleccionada = direccion);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      _getIconForAlias(direccion.alias),
                      const SizedBox(width: 10),
                      Text(
                        direccion.alias,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "${direccion.calle} ${direccion.numeroExt}, ${direccion.colonia}\n"
                    "${direccion.codigoPostal}, ${direccion.municipio}, ${direccion.estado}",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  isThreeLine: true,
                  secondary: PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'editar') {
                        _mostrarFormularioDialog(direccion: direccion);
                      } else if (value == 'eliminar') {
                        await database.markDireccionAsDeleted(direccion.id);
                        locator<SyncService>().syncPendingData();
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'editar', child: Text("Editar")),
                      PopupMenuItem(value: 'eliminar', child: Text("Eliminar")),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
