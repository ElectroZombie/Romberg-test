// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/value_range_model.dart';
import 'package:romberg_test/utils/tuple.dart';
import 'package:romberg_test/widgets/gradient.dart';
import 'package:romberg_test/widgets/line_chart.dart';

class UserResults extends StatefulWidget {
  int? idRange;
  int? idTest;
  int? idUser;
  List<int>? listaIds;
  UserResults({Key? key, List<int>? listaIds}) : super(key: key) {
    idUser = listaIds?[0];
    idRange = listaIds?[1];
    idTest = listaIds?[2];
  }

  @override
  State<UserResults> createState() => _UserResultsState();
}

class _UserResultsState extends State<UserResults> {
  ValueRangeModel? valores;
  TestDataModel? datos;

  void actualizarValores(int idRange, int idTest) async {
    var aux1 = await DB.getDataRange(idRange);
    var aux2 = await DB.getDataTestDone(idTest);
    setState(() {
      valores = aux1;
      datos = aux2;
    });
  }

  cleanAndContinue(
      int idValueRange, int idTestDone, BuildContext context) async {
    await DB.deleteDataRange(idValueRange);
    await DB.deleteTestDone(idTestDone);
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  void initState() {
    actualizarValores(widget.idRange!, widget.idTest!);
    super.initState();
  }

  Tuple<List<double>, double> actualizarPorcentaje(
      ValueRangeModel valores, TestDataModel datos) {
    List<double> porcentajes = List.filled(6, 0.0);
    double porcentajeTotal;
    List<int> totalDesalineados = List.filled(6, 0);

    for (int i = 0; i < valores.rangoCurva.length; i++) {
      if (datos.curva[i].gx <
              (valores.rangoCurva[i].gxi - valores.rangoCurva[i].gxri) ||
          datos.curva[i].gx >
              (valores.rangoCurva[i].gxi + valores.rangoCurva[i].gxri)) {
        totalDesalineados[0]++;
      }
      if (datos.curva[i].gy <
              (valores.rangoCurva[i].gyi - valores.rangoCurva[i].gyri) ||
          datos.curva[i].gy >
              (valores.rangoCurva[i].gyi + valores.rangoCurva[i].gyri)) {
        totalDesalineados[1]++;
      }
      if (datos.curva[i].gz <
              (valores.rangoCurva[i].gzi - valores.rangoCurva[i].gzri) ||
          datos.curva[i].gz >
              (valores.rangoCurva[i].gzi + valores.rangoCurva[i].gzri)) {
        totalDesalineados[2]++;
      }
      if (datos.curva[i].ax <
              (valores.rangoCurva[i].axi - valores.rangoCurva[i].axri) ||
          datos.curva[i].ax >
              (valores.rangoCurva[i].axi + valores.rangoCurva[i].axri)) {
        totalDesalineados[3]++;
      }
      if (datos.curva[i].ay <
              (valores.rangoCurva[i].ayi - valores.rangoCurva[i].ayri) ||
          datos.curva[i].ay >
              (valores.rangoCurva[i].ayi + valores.rangoCurva[i].ayri)) {
        totalDesalineados[4]++;
      }
      if (datos.curva[i].az <
              (valores.rangoCurva[i].azi - valores.rangoCurva[i].azri) ||
          datos.curva[i].az >
              (valores.rangoCurva[i].azi + valores.rangoCurva[i].azri)) {
        totalDesalineados[5]++;
      }
    }
    int desalineadosTotal = 0;
    for (int i = 0; i < 6; i++) {
      porcentajes[i] = (totalDesalineados[i] / valores.rangoCurva.length) * 100;
      desalineadosTotal += totalDesalineados[i];
    }
    porcentajeTotal =
        (desalineadosTotal / (valores.rangoCurva.length * 6)) / 100;

    return Tuple<List<double>, double>(
        elem1: porcentajes, elem2: porcentajeTotal);
  }

  @override
  Widget build(BuildContext context) {
    String resultadoTest = "negativo";
    double? valorPersonal = 0.0;

    ValueRangeModel valoresCurrent = valores!;

    TestDataModel datosCurrent = datos!;

    Tuple<List<double>, double> tupla =
        actualizarPorcentaje(valoresCurrent, datosCurrent);
    double porcentaje = tupla.elem2;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Resultados del test"),
          backgroundColor: Color.fromARGB(199, 84, 209, 136),
        ),
        body: Stack(children: [
          gradient(),
          SingleChildScrollView(
              child: Column(children: [
            const Text("Tiempo efectivo del test"),
            Text(datosCurrent.curva.length as String),
            Text("El resultado del test es $resultadoTest"),
            Text("Porcentaje de exito del test: ${porcentaje as String}"),
            const Text("Valoracion personal del usuario: "),
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
            Row(children: [
              lineChartAX(valoresCurrent, datosCurrent, tupla.elem1[3]),
              lineChartGX(valoresCurrent, datosCurrent, tupla.elem1[0])
            ]),
            Row(children: [
              lineChartAY(valoresCurrent, datosCurrent, tupla.elem1[4]),
              lineChartGY(valoresCurrent, datosCurrent, tupla.elem1[1])
            ]),
            Row(children: [
              lineChartAZ(valoresCurrent, datosCurrent, tupla.elem1[5]),
              lineChartGZ(valoresCurrent, datosCurrent, tupla.elem1[2])
            ]),
            ElevatedButton(
                onPressed: () =>
                    cleanAndContinue(widget.idRange!, widget.idTest!, context),
                child: const Text("Continuar"))
          ]))
        ]));
  }
}
