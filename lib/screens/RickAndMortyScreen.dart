import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class RickAndMortyScreen extends StatefulWidget {
  const RickAndMortyScreen({super.key});

  @override
  State<RickAndMortyScreen> createState() => _RickAndMortyScreenState();
}

class _RickAndMortyScreenState extends State<RickAndMortyScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Character>> futureCharacters;

  @override
  void initState() {
    super.initState();
    futureCharacters = apiService.fetchCharacters();
  }

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
          "Personajes de Rick and Morty",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 12, 75, 193),
      ),
      body: Center(
        child: FutureBuilder<List<Character>>(
          future: futureCharacters,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final characters = snapshot.data!;
              return ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              character.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: character.status == 'Alive'
                                          ? Colors.green
                                          : character.status == 'Dead'
                                          ? Colors.red
                                          : Colors.grey,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${character.status} - ${character.species}',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Última ubicación:',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  character.location,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Origen:',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  character.origin,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text('No se encontraron personajes.');
            }
          },
        ),
      ),
    );
  }
}
