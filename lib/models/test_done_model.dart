class TestDoneModel {
  int idTestDone;
  int idTest;
  int idUser;
  int valorUser;
  String date;

  TestDoneModel(
      {required this.idTestDone,
      required this.idTest,
      required this.idUser,
      required this.valorUser,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id_test_done': idTestDone,
      'id_test': idTest,
      'id_user': idUser,
      'date': date,
      'personal_V': valorUser,
    };
  }
}
