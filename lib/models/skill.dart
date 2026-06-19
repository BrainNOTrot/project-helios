class Skill {
  int? id;
  String name;
  int xp;

  Skill({
    this.id,
    required this.name,
    this.xp = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'xp': xp,
    };
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'],
      name: map['name'],
      xp: map['xp'],
    );
  }

  int get level => (xp ~/ 100) + 1;
}