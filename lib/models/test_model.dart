class TestModel {
  int id;
  String name;
  int time;

  TestModel({required this.id, required this.name, required this.time});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'time': time};
  }
}
