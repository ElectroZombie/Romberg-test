class UserModel {
  int? id;
  String? name;
  double? height;
  double? weight;
  int? age;
  bool generic = false;

  UserModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.age,
  });

  static UserModel genericUser() {
    UserModel g =
        UserModel(id: null, name: null, height: null, weight: null, age: null);
    g.generic = true;
    return g;
  }

  Map<String, dynamic> toMap() {
    return {
      'id_user': id,
      'name_user': name,
      'height_user': height,
      'weight_user': weight,
      'age_user': age,
    };
  }
}
