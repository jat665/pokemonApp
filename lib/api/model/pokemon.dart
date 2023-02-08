class Pokemon {
  final String name;
  final String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  static Pokemon fromMap(Map<String, dynamic> map) {
    return Pokemon(name: map['name'], url: map['url']);
  }

  @override
  String toString() {
    return '{name: $name}';
  }
}
