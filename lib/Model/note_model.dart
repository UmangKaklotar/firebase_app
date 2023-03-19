class Notes {
  String? title;
  String? des;

  Notes({required this.title, required this.des});

  Notes.fromMap(Map<String, dynamic> map) {
    title = map[title];
    des = map[des];
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'des': des,
  };
}