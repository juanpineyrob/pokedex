import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

extension CapitalizeExtension on String {
  String capitalize() {
    if (this.isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon =
        ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(pokemon.name.capitalize(), style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: pokemon.name,
                child: Image.network(
                  pokemon.imageUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Text(
                pokemon.name.capitalize(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "#${pokemon.number}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              if (pokemon.types.isNotEmpty) ...[
                Text(
                  "Tipos:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pokemon.types
                      .map((type) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              type.capitalize(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 20),
              ],
              if (pokemon.abilities.isNotEmpty) ...[
                Text(
                  "Habilidades:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: pokemon.abilities
                      .map((ability) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              ability.capitalize(),
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 20),
              ],
              if (pokemon.stats.isNotEmpty) ...[
                Text(
                  "Estadísticas:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: pokemon.stats
                      .map((stat) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "${stat.stat.name.capitalize()}: ${stat.baseStat}",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Volver"),
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
