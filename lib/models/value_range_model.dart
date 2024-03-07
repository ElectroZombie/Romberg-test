import 'package:romberg_test/models/curve_point_range_model.dart';

class ValueRangeModel {
  int idValueRange;
  int idTest;
  int minimumAge;
  int maximumAge;
  double minimumWeight;
  double maximunWeight;
  double minimumHeight;
  double maximumHeight;

  List<CurvePointRangeModel> rangoCurva = List.empty(growable: true);

  ValueRangeModel(
      {rangoCurva,
      required this.idValueRange,
      required this.idTest,
      required this.minimumAge,
      required this.maximumAge,
      required this.minimumWeight,
      required this.maximunWeight,
      required this.minimumHeight,
      required this.maximumHeight});

  void insertRangePoint(CurvePointRangeModel P) {
    rangoCurva.add(P);
  }

  Map<String, dynamic> toMap() {
    return {
      'id_value_range': idValueRange,
      'id_test': idTest,
      'height_m': minimumHeight,
      'heightM': maximumHeight,
      'weight_m': minimumWeight,
      'weightM': maximunWeight,
      'age_m': minimumAge,
      'ageM': maximumAge,
    };
  }
}
