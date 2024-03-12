import 'dart:async';
import 'package:flutter/material.dart';
import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/frames/user_results.dart';
import 'package:romberg_test/models/curve_point_model.dart';
import 'package:romberg_test/models/curve_point_range_model.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/test_done_model.dart';
import 'package:romberg_test/models/value_range_model.dart';
import 'package:romberg_test/widgets/gradient.dart';
import 'package:sensors/sensors.dart';

import 'package:romberg_test/utils/pdf_actions.dart';
import 'package:just_audio/just_audio.dart';

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
  double _timerSeconds = 10;
  List<double> xValues = List.empty(growable: true);
  List<double> yValues = List.empty(growable: true);
  List<double> zValues = List.empty(growable: true);
  List<double> gxValues = List.empty(growable: true);
  List<double> gyValues = List.empty(growable: true);
  List<double> gzValues = List.empty(growable: true);

  void guardarDatos() async {
    int x = await DB.getLastIdTestDone();
    await DB.insertDataTestDone(
        TestDataModel(idTestDone: x, curva: transformDataToCurvePoints()));
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

  Future<void> calibrar() async {
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
      _timerSeconds = 10;
      xValues.clear();
      yValues.clear();
      zValues.clear();
      gxValues.clear();
      gyValues.clear();
      gzValues.clear();
      mensaje =
          "Calibrando los datos. Mantenga la posicion de Romberg con los ojos abiertos";
    });

    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      setState(() {
        _timerSeconds -= 0.01; // Restamos 0.01 segundos (10 milisegundos)
        if (_timerSeconds <= 0) {
          timer.cancel();
          _isRecording = false;
          _guardarValores();
          tiempoEspera();
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
  }

  _guardarValores() async {
    await guardarRangoValores();
  }

  Future<void> guardarRangoValores() async {
    ValueRangeModel rangoValores = ValueRangeModel(
        idValueRange: (await DB.getLastIdValueRange()) + 1,
        //Aqui pongo el id nuevo como el ultimo que se encuentre en la base de datos, y le sumo 1
        idTest: 1,
        minimumAge: 1,
        maximumAge: 1,
        minimumWeight: 1,
        maximunWeight: 1,
        minimumHeight: 1,
        maximumHeight: 1);

    for (var i = 1; i < gxValues.length; i++) {
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
        azri: (zMaxValue! - zMinValue!) / 2.0,
      ));
    }
    await DB.insertNewDataRange(rangoValores);
  }

  reproducirAudio() async {
    //Hay que probar las dependiencias de audio:
    //just_audio
    //audioplayers
    //soundpool
    //para ver cual funciona, si es que funciona alguna
  }

  Future<void> tiempoEspera() async {
    await reproducirAudio();
    setState(() {
      _isRecording = true;

      _timerSeconds = 10;
      mensaje = "Quedan $_timerSeconds para que empiece el test. Preparado...";
    });
    int temp = 10;
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        temp--;
        _timerSeconds--;
        if (temp <= 0) {
          timer.cancel();

          _realizarTestF();
        } else {}
      });
    });
  }

  _realizarTestF() async {
    await realizarTest();
  }

  Future<void> realizarTest() async {
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
      _timerSeconds = 30;
      xValues.clear();
      yValues.clear();
      zValues.clear();
      gxValues.clear();
      gyValues.clear();
      gzValues.clear();
      mensaje = "Mantenga la posicion de Romberg";
    });

    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      setState(() {
        _timerSeconds -= 0.01;
        if (_timerSeconds <= 0) {
          timer.cancel();
          _isRecording = false;

          _guardarDatosTest();
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
  }

  _guardarDatosTest() async {
    await guardarDatosTest();
  }

  Future<void> guardarDatosTest() async {
    TestDoneModel testDone = TestDoneModel(
        idTestDone: (await DB.getLastIdTestDone()) + 1,
        idTest: 1,
        idUser: 1,
        valorUser: 100,
        date: DateTime.now().toString());

    await DB.insertNewTestDone(testDone);

    TestDataModel testData = TestDataModel(idTestDone: testDone.idTestDone);
    
    for (var i = 1; i < gxValues.length; i++) {
      testData.insertCurvePoint(i, gxValues[i], gyValues[i], gzValues[i],
          xValues[i], yValues[i], zValues[i]);
    }
    await DB.insertDataTestDone(testData);

    //exportPDF();
    //Lo habilito para verificar con estos datos los que salgan en las graficas

    navigate();
  }

  void navigate() async {
    int idtestDone = await DB.getLastIdTestDone();
    int idRange = await DB.getLastIdValueRange();
    List<int> ids = [1, idRange, idtestDone];
    ir(ids);
  }

  void ir(List<int> ids) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => UserResults(listaIds: ids),
      ),
    );
  }

  void startRecording() async {
    await calibrar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(199, 84, 209, 136),
          title: const Text('Romberg Test'),
          leading: const BackButtonIcon(),
        ),
        //drawer: drawer(context),
        body: Stack(
          children: [
            gradient(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isRecording)
                    Column(
                      children: [
                        Text(
                          'Tiempo restante: ${_timerSeconds.toStringAsFixed(2)} segundos',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          mensaje,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => startRecording(),
                    child: const Text('Comenzar Test'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
