class Note {
  final String id;
  String title;
  String description;

  Note({
    required this.id,
    required this.title,
    required this.description,
  });

  // Convert Note to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // Create Note from JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}

// class Note {
//   final String id;
//   String title;
//   String description;

//   Note({
//     required this.id,
//     required this.title,
//     required this.description,
//   });
// }
