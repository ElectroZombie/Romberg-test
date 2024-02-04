import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/models/test_model.dart';

initializeDB() async {
  DB.insertNewTest(TestModel(id: 1, name: "Test de Romberg", time: 30000));
}
