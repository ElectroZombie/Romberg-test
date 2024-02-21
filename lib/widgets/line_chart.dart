import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/value_range_model.dart';

Widget lineChartAX(ValueRangeModel valores, TestDataModel datos) {
  return LineChart(
    LineChartData(
        minY: 0,
        maxY: 100,
        minX: 0,
        maxX: 30000,
        lineBarsData: linesAX(valores, datos)),
    curve: Curves.linear,
    duration: Duration(seconds: 5),
  );
}

List<LineChartBarData> linesAX(ValueRangeModel valores, TestDataModel datos) {
  List<LineChartBarData> line = List.empty(growable: true);
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          30000,
          (i) => FlSpot(i as double,
              valores.rangoCurva[i].axi + valores.rangoCurva[i].axri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: const Color.fromARGB(255, 0, 0, 0),
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          30000,
          (i) => FlSpot(i as double,
              valores.rangoCurva[i].axi - valores.rangoCurva[i].axri))));
  line.add(LineChartBarData(
      isCurved: true,
      color: Colors.amber,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots:
          List.generate(30000, (i) => FlSpot(i as double, datos.curva[i].ax))));
  return line;
}
