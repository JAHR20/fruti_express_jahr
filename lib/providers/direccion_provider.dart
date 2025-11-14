import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fruti_express_jahr/utils/constants.dart';

enum BusquedaEstado { inicial, cargando, exito, error }

class DireccionProvider extends ChangeNotifier {
  BusquedaEstado _estado = BusquedaEstado.inicial;
  String _error = "";
  List<String> _colonias = [];

  BusquedaEstado get estado => _estado;
  String get error => _error;
  List<String> get colonias => _colonias;

  Future<void> buscarCP(String cp) async {
    _estado = BusquedaEstado.cargando;
    _colonias = [];
    _error = "";
    notifyListeners();

    try {
      final url = Uri.parse(
        'https://sepomex.nitrostudio.com.mx/api/latest/cp/$cp.json',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data']['error'] != null) {
          throw Exception("C.P. no encontrado");
        }
        final List postcodes = data['data']['postcodes'];
        if (postcodes.isEmpty) {
          throw Exception("C.P. no encontrado");
        }
        final String municipioApi = postcodes[0]['d_mnpio'];
        if (municipioApi.toLowerCase() != APP_MUNICIPIO_FIJA.toLowerCase()) {
          throw Exception("Ese C.P. no pertenece a $APP_MUNICIPIO_FIJA");
        }

        final Set<String> coloniasUnicas = {};
        for (var asentamiento in postcodes) {
          coloniasUnicas.add(asentamiento['d_asenta']);
        }

        _colonias = coloniasUnicas.toList();

        _estado = BusquedaEstado.exito;
      } else {
        throw Exception("C.P. no encontrado");
      }
    } catch (e) {
      _estado = BusquedaEstado.error;
      _error = e.toString().replaceAll("Exception: ", "");
    }
    notifyListeners();
  }

  void limpiarBusqueda() {
    _estado = BusquedaEstado.inicial;
    _colonias = [];
    _error = "";
    notifyListeners();
  }
}
