import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

void exportToPDF(
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
    List xValues,
    List yValues,
    List zValues,
    List gxValues,
    List gyValues,
    List gzValues) async {
      var status = await Permission.storage.status;
if (status.isDenied) {
  // Solicita permiso de almacenamiento.
  Map<Permission, PermissionStatus> statuses = await [Permission.storage].request();
  print(statuses[Permission.storage]);
}

  final pdf = pw.Document();

  // Agrega el título
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Datos del giroscopio y acelerómetro'),
        );
      },
    ),
  );

  // Agrega los datos del giroscopio y acelerómetro
  pdf.addPage(
    pw.MultiPage(
      build: (pw.Context context) {
        final List<pw.Widget> content = [];

        for (int i = 0; i < gxValues.length; i++) {
          content.add(
            pw.Text(
              ' Giroscopio:${gxValues[i]}, ${gyValues[i]}, ${gzValues[i]}\nAcelerómetro: ${xValues[i]}, ${yValues[i]}, ${zValues[i]}',
            ),
          );
        }

        return content;
      },
    ),
  );

  // Agrega los valores mínimos y máximos
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                'Giroscopio:',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Mínimo: $gxMinValue, $gyMinValue, $gzMinValue',
              ),
              pw.Text(
                'Máximo: $gxMaxValue, $gyMaxValue, $gzMaxValue',
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Acelerómetro:',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Mínimo: $xMinValue, $yMinValue, $zMinValue',
              ),
              pw.Text(
                'Máximo: $xMaxValue, $yMaxValue, $zMaxValue',
              ),
            ],
          ),
        );
      },
    ),
  );

  // Obtiene la ruta de la carpeta de descargas

  const path = '/storage/emulated/0/Download/datos.pdf';

  // Guarda el archivo PDF
  if(status.isGranted){
  final file = File(path);
  await file.writeAsBytes(await pdf.save());
  }

  print('Archivo PDF guardado en: $path');
}
