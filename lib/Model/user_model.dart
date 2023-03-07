class Users{
  String? name;
  int? age;

  Users({required this.name, required this.age});

  Users.fromMap(Map<String, dynamic> map) {
    name = map[name];
    age = map[age];
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'age': age,
  };
}