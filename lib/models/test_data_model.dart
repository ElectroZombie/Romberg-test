
import 'package:romberg_test/models/curve_point_model.dart';

class TestDataModel {
  int idTestDone;
  List<CurvePointModel> curva = List.empty(growable: true);

  TestDataModel({curva,required this.idTestDone});

  void insertCurvePoint(i, gx, gy, gz, ax, ay, az) {
    curva.add(
        CurvePointModel(tiempo: i, gx: gx, gy: gy, gz: gz, ax: ax, ay: ay, az: az));
  }
}
