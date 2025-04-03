class Task {
  String id;
  String title;
  String description;
  int dateTime;
  bool isDone;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          dateTime: json['dateTime'],
          isDone: json['isDone'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime,
      'isDone': isDone,
    };
  }
}
