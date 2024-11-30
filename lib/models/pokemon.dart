class Pokemon {
  final String name;
  final int number;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final List<Stat> stats;

  Pokemon({
    required this.name,
    required this.number,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.stats,
  });
}

class Stat {
  final StatDetail stat;
  final int baseStat;

  Stat({required this.stat, required this.baseStat});
}

class StatDetail {
  final String name;

  StatDetail({required this.name});
}
