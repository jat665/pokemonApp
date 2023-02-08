class Pokemon {
  final String name;

  Pokemon({
    required this.name,
  });

  static Pokemon fromMap(Map<String, dynamic> map) {
    return Pokemon(name: map['name']);
  }

  @override
  String toString() {
    return '{name: $name}';
  }
}
