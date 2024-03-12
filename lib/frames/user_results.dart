// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/value_range_model.dart';
import 'package:romberg_test/utils/tuple.dart';
import 'package:romberg_test/widgets/line_chart.dart';

class UserResults extends StatefulWidget {
  int ?idRange; 
  int ?idTest;
  UserResults({Key? key,this.idRange,this.idTest,listaIds,}) : super(key: key);

  @override
  State<UserResults> createState() => _UserResultsState();
}

class _UserResultsState extends State<UserResults> {
  ValueRangeModel? valores;

  TestDataModel? datos;

  void actualizarValores(int idRange, int idTest) async {
   var aux1 =await DB.getDataRange(idRange);
   var aux2 =await DB.getDataTestDone(idTest);
   setState(() {
    valores = aux1;
    datos = aux2;
   });
    //Si esto no funciona, lo que hay que hacer es convertir el widget en stateful, y adaptarlo, y con eso debe pinchar,
    //porque lo que falta es que coja esos valores y los actualice
  }

  cleanAndContinue(idValueRange, idTestDone, context) async {
    await DB.deleteDataRange(idValueRange);
    await DB.deleteTestDone(idTestDone);
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
    int TotalDesalineados = 0;
    for (int i = 0; i < 6; i++) {
      porcentajes[i] = (totalDesalineados[i] / valores.rangoCurva.length) * 100;
      TotalDesalineados += totalDesalineados[i];
    }
    porcentajeTotal =
        (TotalDesalineados / (valores.rangoCurva.length * 6)) / 100;

    return Tuple<List<double>, double>(
        elem1: porcentajes, elem2: porcentajeTotal);
  }

  @override
  Widget build(BuildContext context) {
    //List<int> lista = ModalRoute.of(context)!.settings.arguments as List<int>;
    //int idUser = lista[0];
    // int idValueRange = lista[1];
    // int idTestDone = lista[2];
    // actualizarValores(idValueRange, idTestDone);
    String resultadoTest = "negativo";
    double? valorPersonal = 0.0;

  

    ValueRangeModel valores = this.valores!;

    TestDataModel datos = this.datos!;

    Tuple<List<double>, double> tupla = actualizarPorcentaje(valores, datos);
    double porcentaje = tupla.elem2;

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
              children: [
                lineChartAX(valores, datos, tupla.elem1[3]),
                lineChartGX(valores, datos, tupla.elem1[0])
              ],
            ),
            Row(
              children: [
                lineChartAY(valores, datos, tupla.elem1[4]),
                lineChartGY(valores, datos, tupla.elem1[1])
              ],
            ),
            Row(
              children: [
                lineChartAZ(valores, datos, tupla.elem1[5]),
                lineChartGZ(valores, datos, tupla.elem1[2])
              ],
            ),
            ElevatedButton(
                onPressed: () =>
                    cleanAndContinue(widget.idRange, widget.idTest, context),
                child: Text("Continuar"))
          ],
        ));
  }
}
