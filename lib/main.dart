import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscar Pokémon',
      home: PokemonSearchPage(),
    );
  }
}

class PokemonSearchPage extends StatefulWidget {
  @override
  _PokemonSearchPageState createState() => _PokemonSearchPageState();
}

class _PokemonSearchPageState extends State<PokemonSearchPage> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? pokemonData;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPokemon(String pokemonName) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      pokemonData = null;
    });

    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${pokemonName.toLowerCase()}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          pokemonData = data;
        });
      } else {
        setState(() {
          errorMessage = 'Pokémon no encontrado';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al buscar Pokémon';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildPokemonInfo() {
    if (isLoading) {
      return CircularProgressIndicator();
    } else if (errorMessage != null) {
      return Text(
        errorMessage!,
        style: TextStyle(color: Colors.red, fontSize: 18),
      );
    } else if (pokemonData != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            pokemonData!['sprites']['front_default'],
            height: 150,
          ),
          SizedBox(height: 20),
          Text(
            'Nombre: ${pokemonData!['name'].toString().toUpperCase()}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('Peso: ${pokemonData!['weight']}'),
          Text('Altura: ${pokemonData!['height']}'),
        ],
      );
    } else {
      return Text('Escribe un nombre y busca un Pokémon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nombre del Pokémon',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final name = _controller.text.trim();
                if (name.isNotEmpty) {
                  fetchPokemon(name);
                }
              },
              child: Text('Buscar'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: buildPokemonInfo(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
