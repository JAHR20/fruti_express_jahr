// lib/widgets/FormDireccion.dart
import 'package:flutter/material.dart';
import 'package:fruti_express_jahr/providers/direccion_provider.dart';
import 'package:provider/provider.dart';

class FormDireccion extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController aliasController;
  final TextEditingController calleController;
  final TextEditingController numeroExtController;
  final TextEditingController numeroIntController;
  final TextEditingController coloniaController;
  final TextEditingController codigoPostalController;

  const FormDireccion({
    Key? key,
    required this.formKey,
    required this.aliasController,
    required this.calleController,
    required this.numeroExtController,
    required this.numeroIntController,
    required this.coloniaController,
    required this.codigoPostalController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final direccionProvider = context.watch<DireccionProvider>();
    final Key dropdownKey = ValueKey(direccionProvider.colonias);

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Actualmente solo hacemos entregas en Jáltipan, Veracruz.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue[800], fontSize: 13),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: aliasController,
            decoration: InputDecoration(
              labelText: 'Alias (ej. "Casa")',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Campo requerido' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: calleController,
            decoration: InputDecoration(
              labelText: 'Calle',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Campo requerido' : null,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: numeroExtController,
                  decoration: InputDecoration(
                    labelText: 'Número Ext.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Campo requerido'
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: numeroIntController,
                  decoration: InputDecoration(
                    labelText: 'Num. Int. (Opcional)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: codigoPostalController,
            decoration: InputDecoration(
              labelText: 'Código Postal',
              border: OutlineInputBorder(),
              suffixIcon: direccionProvider.estado == BusquedaEstado.cargando
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(),
                    )
                  : null,
            ),
            keyboardType: TextInputType.number,
            maxLength: 5,
            validator: (value) => (value != null && value.length == 5)
                ? null
                : 'Debe tener 5 dígitos',
            onChanged: (value) {
              coloniaController.clear();
              if (value.length == 5) {
                context.read<DireccionProvider>().buscarCP(value);
              } else if (value.length < 5) {
                context.read<DireccionProvider>().limpiarBusqueda();
              }
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: dropdownKey,
            decoration: InputDecoration(
              labelText: 'Colonia',
              border: OutlineInputBorder(),
            ),
            hint: Text(
              direccionProvider.estado == BusquedaEstado.inicial
                  ? 'Ingresa tu C.P. primero'
                  : 'Selecciona una colonia',
            ),
            isExpanded: true,
            items: direccionProvider.colonias.map((String colonia) {
              return DropdownMenuItem<String>(
                value: colonia,
                child: Text(colonia, overflow: TextOverflow.ellipsis),
              );
            }).toList(),

            selectedItemBuilder: (BuildContext context) {
              return direccionProvider.colonias.map<Widget>((String colonia) {
                return Text(
                  colonia,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                );
              }).toList();
            },

            onChanged: (String? newValue) {
              coloniaController.text = newValue ?? '';
            },
            validator: (value) {
              if (coloniaController.text.isEmpty) {
                return 'Por favor, selecciona una colonia';
              }
              return null;
            },
          ),
          if (direccionProvider.estado == BusquedaEstado.error)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12.0),
              child: Text(
                direccionProvider.error,
                style: TextStyle(color: Colors.red[700], fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }
}
