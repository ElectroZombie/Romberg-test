import 'package:flutter/material.dart';
import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/test_done_model.dart';
import 'package:romberg_test/models/value_range_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:romberg_test/widgets/line_chart.dart';

class UserResults extends StatelessWidget {
  const UserResults(listaIds, {Key? key}) : super(key: key);

  getDataRange(id) async {
    return await DB.getDataRange(id);
  }

  getdatos(id) async {
    return await DB.getDataTestDone(id);
  }

  cleanAndContinue(idValueRange, idTestDone, context) async {
    await DB.deleteDataRange(idValueRange);
    await DB.deleteTestDone(idTestDone);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    List<int> lista = ModalRoute.of(context)!.settings.arguments as List<int>;
    int idUser = lista[0];
    int idValueRange = lista[1];
    int idTestDone = lista[2];

    String resultadoTest = "negativo";
    double? porcentaje = 100.0;
    double? valorPersonal = 0.0;

    ValueRangeModel valores = getDataRange(idValueRange);
    TestDataModel datos = getdatos(idTestDone);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Resultados del test"),
        ),
        body: Column(
          children: [
            Text("Tiempo efectivo del test"),
            Text(datos.curva.length as String),
            Text("El resultado del test es $resultadoTest"),
            Text("Porcentaje de exito del test: ${porcentaje as String}"),
            Text("Valoracion personal del usuario: "),
            Slider(
              value: 0,
              onChanged: (value) {
                valorPersonal = value;
              },
              divisions: 3,
              allowedInteraction: SliderInteraction.tapAndSlide,
              min: 0.0,
              max: 100.0,
            ),
            Row(
              children: [lineChartAX(valores, datos)],
            ),
            Row(
              children: [],
            ),
            Row(
              children: [],
            ),
            ElevatedButton(
                onPressed: () =>
                    cleanAndContinue(idValueRange, idTestDone, context),
                child: Text("Continuar"))
          ],
        ));
  }
}
