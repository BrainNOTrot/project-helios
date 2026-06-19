class Mission {
  int? id;
  String title;
  double progress;

  Mission({
    this.id,
    required this.title,
    this.progress = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'progress': progress,
    };
  }

  factory Mission.fromMap(Map<String, dynamic> map) {
    return Mission(
      id: map['id'],
      title: map['title'],
      progress: map['progress'],
    );
  }
}