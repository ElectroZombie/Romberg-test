class TestModel {
  int id;
  String name;
  int time;

  TestModel({required this.id, required this.name, required this.time});

  Map<String, dynamic> toMap() {
    return {'id_test': id, 'name_test': name, 'time_test': time};
  }
}
