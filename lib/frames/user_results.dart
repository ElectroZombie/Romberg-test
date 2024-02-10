import 'package:flutter/material.dart';
import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/test_done_model.dart';
import 'package:romberg_test/models/value_range_model.dart';

class UserResults extends StatelessWidget {
  const UserResults(listaIds, {Key? key}) : super(key: key);

  getDataRange(id) async {
    return await DB.getDataRange(id);
  }

  getdatos(id) async {
    return await DB.getDataTestDone(id);
  }

  @override
  Widget build(BuildContext context) {
    List<int> lista = ModalRoute.of(context)!.settings.arguments as List<int>;
    int idUser = lista[0];
    int idValueRange = lista[1];
    int idTestDone = lista[2];

    ValueRangeModel valores = getDataRange(idValueRange);
    TestDataModel datos = getdatos(idTestDone);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Resultados del test"),
      ),
      body: ListView.builder(
        itemCount: datos.curva.length,
        itemBuilder: (BuildContext context, int i) {
          return Row(
            children: [
              Text(datos.curva[i].ax.toString()),
              Text(datos.curva[i].ay.toString()),
              Text(datos.curva[i].az.toString()),
              Text(datos.curva[i].gx.toString()),
              Text(datos.curva[i].gy.toString()),
              Text(datos.curva[i].gz.toString()),
              Text(datos.curva[i].tiempo.toString())
            ],
          );
        },
      ),
    );
  }
}
