class Author {
  String? name;
  String? book;

  Author({required this.name, required this.book});

  Author.fromMap(Map<String, dynamic> map) {
    name = map[name];
    book = map[book];
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'book': book,
  };
}