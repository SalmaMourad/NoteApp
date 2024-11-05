class Note {
  final String id;
  String title;
  String description;
  String? folder; // New field to specify folder name, nullable

  Note({
    required this.id,
    required this.title,
    required this.description,
    this.folder,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'folder': folder,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      folder: json['folder'],
    );
  }
}
