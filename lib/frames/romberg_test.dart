import 'dart:async';
import 'package:flutter/material.dart';
import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/models/curve_point_model.dart';
import 'package:romberg_test/models/curve_point_range_model.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/test_done_model.dart';
import 'package:romberg_test/models/test_model.dart';
import 'package:romberg_test/models/value_range_model.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:romberg_test/utils/pdf_actions.dart';

class RombergTest extends StatefulWidget {
  const RombergTest(userModel, {Key? key}) : super(key: key);

  @override
  RombergTestState createState() => RombergTestState();
}

class RombergTestState extends State<RombergTest> {
  late AccelerometerEvent _accelerometerValues;
  late GyroscopeEvent _gyroscopeValues = GyroscopeEvent(0, 0, 0);

  double? xMinValue;
  double? xMaxValue;
  double? yMinValue;
  double? yMaxValue;
  double? zMinValue;
  double? zMaxValue;
  double? gxMinValue;
  double? gxMaxValue;
  double? gyMinValue;
  double? gyMaxValue;
  double? gzMinValue;
  double? gzMaxValue;
  bool _isRecording = false;
  String mensaje = "Iniciar Test de Romberg";
  int _timerSeconds = 10;
  List<double> xValues = List.empty(growable: true);
  List<double> yValues = List.empty(growable: true);
  List<double> zValues = List.empty(growable: true);
  List<double> gxValues = List.empty(growable: true);
  List<double> gyValues = List.empty(growable: true);
  List<double> gzValues = List.empty(growable: true);

  void guardarDatos() async {
    await DB.insertDataTestDone(
        TestDataModel(idTestDone: 1, curva: transformDataToCurvePoints()));
  }

  void exportPDF() {
    exportToPDF(
        xMinValue,
        xMaxValue,
        yMinValue,
        yMaxValue,
        zMinValue,
        zMaxValue,
        gxMinValue,
        gxMaxValue,
        gyMinValue,
        gyMaxValue,
        gzMinValue,
        gzMaxValue,
        xValues,
        yValues,
        zValues,
        gxValues,
        gyValues,
        gzValues);
  }

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = event;
        if (_isRecording) {
          xMinValue = xMinValue != null
              ? xMinValue! < event.x
                  ? xMinValue!
                  : event.x
              : event.x;
          xMaxValue = xMaxValue != null
              ? xMaxValue! > event.x
                  ? xMaxValue!
                  : event.x
              : event.x;
          yMinValue = yMinValue != null
              ? yMinValue! < event.y
                  ? yMinValue!
                  : event.y
              : event.y;
          yMaxValue = yMaxValue != null
              ? yMaxValue! > event.y
                  ? yMaxValue!
                  : event.y
              : event.y;
          zMinValue = zMinValue != null
              ? zMinValue! < event.z
                  ? zMinValue!
                  : event.z
              : event.z;
          zMaxValue = zMaxValue != null
              ? zMaxValue! > event.z
                  ? zMaxValue!
                  : event.z
              : event.z;
          xValues.add(event.x);
          yValues.add(event.y);
          zValues.add(event.z);
        }
      });
    });

    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = event;
        if (_isRecording) {
          gxMinValue = gxMinValue != null
              ? gxMinValue! < event.x
                  ? gxMinValue!
                  : event.x
              : event.x;
          gxMaxValue = gxMaxValue != null
              ? gxMaxValue! > event.x
                  ? gxMaxValue!
                  : event.x
              : event.x;
          gyMinValue = gyMinValue != null
              ? gyMinValue! < event.y
                  ? gyMinValue!
                  : event.y
              : event.y;
          gyMaxValue = gyMaxValue != null
              ? gyMaxValue! > event.y
                  ? gyMaxValue!
                  : event.y
              : event.y;
          gzMinValue = gzMinValue != null
              ? gzMinValue! < event.z
                  ? gzMinValue!
                  : event.z
              : event.z;
          gzMaxValue = gzMaxValue != null
              ? gzMaxValue! > event.z
                  ? gzMaxValue!
                  : event.z
              : event.z;
          gxValues.add(event.x);
          gyValues.add(event.y);
          gzValues.add(event.z);
        }
      });
    });
    super.initState();
  }

  List<CurvePointModel> transformDataToCurvePoints() {
    List<CurvePointModel> curvePoints = [];

    for (int i = 0; i < _timerSeconds; i++) {
      int tiempo = i + 1;
      double gx = gxValues[i];
      double gy = gyValues[i];
      double gz = gzValues[i];
      double ax = xValues[i];
      double ay = yValues[i];
      double az = zValues[i];

      CurvePointModel curvePoint = CurvePointModel(
        tiempo: tiempo,
        gx: gx,
        gy: gy,
        gz: gz,
        ax: ax,
        ay: ay,
        az: az,
      );

      curvePoints.add(curvePoint);
    }

    return curvePoints;
  }

  void startRecording(int timer) {
    setState(() {
      _isRecording = true;
      xMinValue = null;
      xMaxValue = null;
      yMinValue = null;
      yMaxValue = null;
      zMinValue = null;
      zMaxValue = null;
      gxMinValue = 0.0;
      gxMaxValue = 0.0;
      gyMinValue = 0.0;
      gyMaxValue = 0.0;
      gzMinValue = 0.0;
      gzMaxValue = 0.0;
      _timerSeconds = timer * 1000;
      xValues.clear();
      yValues.clear();
      zValues.clear();
      gxValues.clear();
      gyValues.clear();
      gzValues.clear();
      mensaje =
          "Calibrando los datos. Mantenga la posicion de Romberg con los ojos abiertos";
    });

    Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        _timerSeconds--;
        if (_timerSeconds <= 0) {
          timer.cancel();
          _isRecording = false;
        } else if (_isRecording) {
          xValues.add(_accelerometerValues.x);
          yValues.add(_accelerometerValues.y);
          zValues.add(_accelerometerValues.z);
          gxValues.add(_gyroscopeValues.x);
          gyValues.add(_gyroscopeValues.y);
          gzValues.add(_gyroscopeValues.z);
        }
      });
    });

    ValueRangeModel rangoValores = ValueRangeModel(
        idValueRange: 1,
        idTest: 1,
        minimumAge: 1,
        maximumAge: 1,
        minimumWeight: 1,
        maximunWeight: 1,
        minimumHeight: 1,
        maximumHeight: 1);
    for (var i = 1; i <= timer * 1000; i++) {
      rangoValores.insertRangePoint(CurvePointRangeModel(
          i: i,
          gxi: gxValues[i],
          gxri: (gxMaxValue! - gxMinValue!) / 2.0,
          gyi: gyValues[i],
          gyri: (gyMaxValue! - gyMinValue!) / 2.0,
          gzi: gzValues[i],
          gzri: (gzMaxValue! - gzMinValue!) / 2.0,
          axi: xValues[i],
          axri: (xMaxValue! - xMinValue!) / 2.0,
          ayi: yValues[i],
          ayri: (yMaxValue! - yMinValue!) / 2.0,
          azi: zValues[i],
          azri: (zMaxValue! - zMinValue!) / 2.0));
    }

    DB.insertNewDataRange(rangoValores);

    setState(() {
      _timerSeconds = 10000;
      mensaje =
          "Quedan ${_timerSeconds / 1000} para que empiece el test. Preparado...";
    });
    int temp = 10;
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      setState(() {
        temp--;
        _timerSeconds -= 1000;
        if (temp <= 0) {
          timer.cancel();
        } else {}
      });
    });

    setState(() {
      _isRecording = true;
      xMinValue = null;
      xMaxValue = null;
      yMinValue = null;
      yMaxValue = null;
      zMinValue = null;
      zMaxValue = null;
      gxMinValue = 0.0;
      gxMaxValue = 0.0;
      gyMinValue = 0.0;
      gyMaxValue = 0.0;
      gzMinValue = 0.0;
      gzMaxValue = 0.0;
      _timerSeconds = 30000;
      xValues.clear();
      yValues.clear();
      zValues.clear();
      gxValues.clear();
      gyValues.clear();
      gzValues.clear();
      mensaje = "Mantenga la posicion de Romberg";
    });

    Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
      setState(() {
        _timerSeconds--;
        if (_timerSeconds <= 0) {
          timer.cancel();
          _isRecording = false;
        } else if (_isRecording) {
          xValues.add(_accelerometerValues.x);
          yValues.add(_accelerometerValues.y);
          zValues.add(_accelerometerValues.z);
          gxValues.add(_gyroscopeValues.x);
          gyValues.add(_gyroscopeValues.y);
          gzValues.add(_gyroscopeValues.z);
        }
      });
    });

    TestModel test = TestModel(id: 1, name: "Test1", time: 30);
    DB.insertNewTest(test);

    TestDoneModel testDone = TestDoneModel(
        idTestDone: 1,
        idTest: 1,
        idUser: 1,
        valorUser: 100,
        date: DateTime.now());

    DB.insertNewTestDone(testDone);

    TestDataModel testData = TestDataModel(idTestDone: 1);
    for (var i = 1; i < 30000; i++) {
      testData.insertCurvePoint(i, gxValues[i], gyValues[i], gzValues[i],
          xValues[i], yValues[i], zValues[i]);
    }
    DB.insertDataTestDone(testData);

    exportPDF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Romberg Test'),
        leading: BackButtonIcon(),
      ),
      //drawer: drawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRecording)
              Column(
                children: [
                  Text(
                    'Tiempo restante: ${_timerSeconds / 1000} segundos',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Text(
                    mensaje,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => startRecording(10),
              child: Text('Comenzar Test'),
            ),
          ],
        ),
      ),
    );
  }
}