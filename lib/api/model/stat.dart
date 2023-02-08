class Stat {
  static const hp = 0;
  static const attack = 1;
  static const defence = 2;
  static const speed = 5;

  final int baseStat;

  Stat({
    required this.baseStat,
  });

  static Stat fromMap(Map<String, dynamic> map) {
    return Stat(baseStat: map['base_stat']);
  }

  @override
  String toString() {
    return '{baseStat: $baseStat}';
  }
}
