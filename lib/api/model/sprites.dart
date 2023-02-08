class Sprites {
  final String front;
  final Other other;

  Sprites({required this.front, required this.other});

  static Sprites fromMap(Map<String, dynamic> map) {
    return Sprites(front: map['front_default'], other: Other.fromMap(map['other']));
  }
}

class Other {
  final DreamWorld dreamWorld;

  Other({required this.dreamWorld});

  static Other fromMap(Map<String, dynamic> map) {
    return Other(dreamWorld: DreamWorld.fromMap(map['dream_world']));
  }
}

class DreamWorld {
  final String front;

  DreamWorld({required this.front});

  static DreamWorld fromMap(Map<String, dynamic> map) {
    return DreamWorld(front: map['front_default']);
  }
}
