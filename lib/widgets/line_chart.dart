import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/value_range_model.dart';
import 'dart:math';

//hay errores aqui a la hora de pintar los datos
//no tengo ni la mas minima idea de lo q esta pasando aqui pero
// ya llega hasta aqui lo q no pinta nada
Color colorPorcentaje(double porcentaje) {
  if (porcentaje <= 40.0) {
    return const Color.fromARGB(255, 59, 2, 61);
  } else if (porcentaje <= 60.0) {
    return const Color.fromARGB(255, 194, 8, 8);
  } else if (porcentaje <= 80.0) {
    return const Color.fromARGB(255, 165, 66, 1);
  } else {
    return const Color.fromARGB(255, 72, 190, 3);
  }
}

Widget lineChartAX(
    ValueRangeModel valores, TestDataModel datos, double porcentajeExito) {
  return LineChart(
    LineChartData(
        backgroundColor: colorPorcentaje(porcentajeExito),
        minY: 0,
        maxY: 100,
        minX: 0,
        maxX: 30000,
        lineBarsData: linesAX(valores, datos)),
    curve: Curves.linear,
    duration: const Duration(seconds: 5),
  );
}

List<LineChartBarData> linesAX(ValueRangeModel valores, TestDataModel datos) {
  List<LineChartBarData> line = List.empty(growable: true);
  int minLength = min(valores.rangoCurva.length, datos.curva.length);
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].axi + valores.rangoCurva[i].axri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: const Color.fromARGB(255, 0, 0, 0),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].axi - valores.rangoCurva[i].axri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength, (i) => FlSpot(i.toDouble(), datos.curva[i].ax))));
  return line;
}

Widget lineChartAY(
    ValueRangeModel valores, TestDataModel datos, double porcentajeExito) {
  return LineChart(
    LineChartData(
        minY: 0,
        maxY: 100,
        minX: 0,
        maxX: 3000,
        lineBarsData: linesAY(valores, datos)),
    curve: Curves.linear,
    duration: const Duration(seconds: 5),
  );
}

List<LineChartBarData> linesAY(ValueRangeModel valores, TestDataModel datos) {
  List<LineChartBarData> line = List.empty(growable: true);
  int minLength = min(valores.rangoCurva.length, datos.curva.length);
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].ayi + valores.rangoCurva[i].ayri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: const Color.fromARGB(255, 0, 0, 0),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].ayi - valores.rangoCurva[i].ayri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength, (i) => FlSpot(i.toDouble(), datos.curva[i].ay))));
  return line;
}

Widget lineChartAZ(
    ValueRangeModel valores, TestDataModel datos, double porcentajeExito) {
  return LineChart(
    LineChartData(
        minY: 0,
        maxY: 100,
        minX: 0,
        maxX: 3000,
        lineBarsData: linesAZ(valores, datos)),
    curve: Curves.linear,
    duration: const Duration(seconds: 5),
  );
}

List<LineChartBarData> linesAZ(ValueRangeModel valores, TestDataModel datos) {
  List<LineChartBarData> line = List.empty(growable: true);
  int minLength = min(valores.rangoCurva.length, datos.curva.length);
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].azi + valores.rangoCurva[i].azri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: const Color.fromARGB(255, 0, 0, 0),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].azi - valores.rangoCurva[i].azri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength, (i) => FlSpot(i.toDouble(), datos.curva[i].az))));
  return line;
}

Widget lineChartGX(
    ValueRangeModel valores, TestDataModel datos, double porcentajeExito) {
  return LineChart(
    LineChartData(
        minY: 0,
        maxY: 100,
        minX: 0,
        maxX: 30000,
        lineBarsData: linesGX(valores, datos)),
    curve: Curves.linear,
    duration: const Duration(seconds: 5),
  );
}

List<LineChartBarData> linesGX(ValueRangeModel valores, TestDataModel datos) {
  List<LineChartBarData> line = List.empty(growable: true);
  int minLength = min(valores.rangoCurva.length, datos.curva.length);
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].gxi + valores.rangoCurva[i].gxri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: const Color.fromARGB(255, 0, 0, 0),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].gxi - valores.rangoCurva[i].gxri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength, (i) => FlSpot(i.toDouble(), datos.curva[i].gx))));
  return line;
}

Widget lineChartGY(
    ValueRangeModel valores, TestDataModel datos, double porcentajeExito) {
  return LineChart(
    LineChartData(
        minY: 0,
        maxY: 100,
        minX: 0,
        maxX: 3000,
        lineBarsData: linesGY(valores, datos)),
    curve: Curves.linear,
    duration: const Duration(seconds: 5),
  );
}

List<LineChartBarData> linesGY(ValueRangeModel valores, TestDataModel datos) {
  List<LineChartBarData> line = List.empty(growable: true);
  int minLength = min(valores.rangoCurva.length, datos.curva.length);
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].gyi + valores.rangoCurva[i].gyri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: const Color.fromARGB(255, 0, 0, 0),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].gyi - valores.rangoCurva[i].gyri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength, (i) => FlSpot(i.toDouble(), datos.curva[i].gy))));
  return line;
}

Widget lineChartGZ(
    ValueRangeModel valores, TestDataModel datos, double porcentajeExito) {
  return LineChart(
    LineChartData(
        minY: 0,
        maxY: 100,
        minX: 0,
        maxX: 3000,
        lineBarsData: linesGZ(valores, datos)),
    curve: Curves.linear,
    duration: const Duration(seconds: 5),
  );
}

List<LineChartBarData> linesGZ(ValueRangeModel valores, TestDataModel datos) {
  List<LineChartBarData> line = List.empty(growable: true);
  int minLength = min(valores.rangoCurva.length, datos.curva.length);
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].gzi + valores.rangoCurva[i].gzri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: const Color.fromARGB(255, 0, 0, 0),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength,
          (i) => FlSpot(i.toDouble(),
              valores.rangoCurva[i].gzi - valores.rangoCurva[i].gzri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          minLength, (i) => FlSpot(i.toDouble(), datos.curva[i].gz))));
  return line;
}
