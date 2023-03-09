class UserData{
  String? name;
  int? age;

  UserData({required this.name, required this.age});

  UserData.fromMap(Map<String, dynamic> map) {
    name = map[name];
    age = map[age];
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'age': age,
  };
}