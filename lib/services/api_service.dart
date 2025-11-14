import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character_model.dart';

class ApiService {
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception(
        'Falló la solicitud a la API. Código de estado: ${response.statusCode}',
      );
    }
  }
}
