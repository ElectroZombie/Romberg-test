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
  double? porcentaje = 0.0;

  ValueRangeModel? valores = ValueRangeModel(
      idValueRange: 1,
      idTest: 1,
      minimumAge: 1,
      maximumAge: 1,
      minimumWeight: 1,
      maximunWeight: 1,
      minimumHeight: 1,
      maximumHeight: 1);
  TestDataModel? datos = TestDataModel(idTestDone: 1);
  Tuple<List<double>, double>? tupla = Tuple(elem1: [], elem2: 0);
  String resultadoTest = "Negativo";

  Future<void> actualizarValores(int idRange, int idTest) async {
    var aux1 = await DB.getDataRange(idRange);
    var aux2 = await DB.getDataTestDone(idTest);
    setState(() {
      valores = aux1;
      datos = aux2;
    });
    await actualizarPorcentaje(valores!, datos!);
  }

  cleanAndContinue(
      int idValueRange, int idTestDone, BuildContext context) async {
    await DB.deleteDataRange(idValueRange);
    await DB.deleteTestDone(idTestDone);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  Future<void> actualizarPorcentaje(
      ValueRangeModel valores, TestDataModel datos) async {
    List<double> porcentajes = List.filled(6, 0.0);
    double porcentajeTotal;
    List<int> totalDesalineados = List.filled(6, 0);

    for (int i = 0; i < datos.curva.length; i++) {
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
    double desalineadosTotal = 0;
    for (int i = 0; i < 6; i++) {
      porcentajes[i] =
          100 - (totalDesalineados[i] / valores.rangoCurva.length) * 100;
      desalineadosTotal += totalDesalineados[i];
      print(desalineadosTotal);
    }
    porcentajeTotal =
        100 - (desalineadosTotal / (valores.rangoCurva.length * 6)) * 100;
        print(porcentajeTotal);

    setState(() {
      tupla = Tuple<List<double>, double>(
          elem1: porcentajes, elem2: porcentajeTotal);
      if (porcentajeTotal <= 60.0) {
        resultadoTest = "Positivo";
      }
    });
  }

  Future<void>? _future;

  @override
  void initState() {
    super.initState();
    _future = actualizarValores(widget.idRange!, widget.idTest!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ); // Muestra un indicador de carga mientras se espera.
        } else {
          double? valorPersonal = 0.0;

          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Resultados del test"),
                backgroundColor: const Color.fromARGB(199, 84, 209, 136),
              ),
              body: Stack(children: [
                gradient(),
                SingleChildScrollView(
                    child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text("Tiempo efectivo del test"),
                      const Text("30"),
                      Text("El resultado del test es $resultadoTest"),
                      Text("Porcentaje de exito del test: ${tupla!.elem2}"),
                     // const Text("Valoracion personal del usuario: "),
                      // Slider(
                      //   value: 0,
                      //   onChanged: (value) {
                      //     valorPersonal = value;
                      //   },
                      //   divisions: 3,
                      //   allowedInteraction: SliderInteraction.tapAndSlide,
                      //   min: 0.0,
                      //   max: 100.0,
                      // ),
                      /*  Row(children: [
                        lineChartAX(valores!, datos!, tupla!.elem1[3]),
                        lineChartGX(valores!, datos!, tupla!.elem1[0])
                                          ]),
                                          Row(children: [
                        lineChartAY(valores!, datos!, tupla!.elem1[4]),
                        lineChartGY(valores!, datos!, tupla!.elem1[1])
                                          ]),
                                          Row(children: [
                        lineChartAZ(valores!, datos!, tupla!.elem1[5]),
                        lineChartGZ(valores!, datos!, tupla!.elem1[2])
                                          ]),*/
                      //Por ahora vamos a ignorar los graficos. Para ver si el resto funciona bien
                      ElevatedButton(
                          onPressed: () => cleanAndContinue(
                              widget.idRange!, widget.idTest!, context),
                          child: const Text("Continuar"))
                    ]))
              ]));
        }
      },
    );
  }
}
