class TodoInfo {
  final String name;
  final String description;
  final bool done;

  TodoInfo({required this.name, required this.description, required this.done});

  @override
  String toString() =>
      'TodoInfo(name: $name, description: $description, done: $done)';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'done': done,
    };
  }

  factory TodoInfo.fromJson(Map<String, dynamic> json) {
    return TodoInfo(
      name: json['name'] as String,
      description: json['description'] as String,
      done: json['done'] as bool,
    );
  }

  TodoInfo copyWith({
    String? name,
    String? description,
    bool? done,
  }) {
    return TodoInfo(
      name: name ?? this.name,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }
}
