import 'package:flutter/material.dart';
import 'package:romberg_test/widgets/gradient.dart';

class Inf extends StatelessWidget {
  const Inf(inte, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? opcion = ModalRoute.of(context)!.settings.arguments as int?;
    String texto = "";
    if (opcion == 1) {
      texto =
          "El test de Romberg se utiliza principalmente en neurología como una herramienta de evaluación clínica para detectar trastornos del equilibrio y de la postura, así como para identificar posibles problemas en el sistema sensorial y neurológico relacionados con el equilibrio. Algunas de las razones por las que se utiliza el test de Romberg incluyen: \n 1. Evaluación del sistema vestibular: El test de Romberg puede ayudar a detectar trastornos del sistema vestibular, que es responsable del equilibrio y coordinación del cuerpo. Si un paciente tiene dificultades para mantener la postura con los ojos cerrados, puede ser indicativo de problemas en el laberinto vestibular del oído interno. \n 2. Evaluación de la función propioceptiva: La propiocepción es la capacidad del cuerpo para percibir la posición y movimiento de las articulaciones. El test de Romberg también evalúa la función propioceptiva, ya que al cerrar los ojos se elimina la entrada visual, dejando al sistema propioceptivo como la principal fuente de información para mantener el equilibrio. \n 3. Detectar ataxia y neuropatías periféricas: El test de Romberg puede ayudar a identificar la presencia de ataxia, que se caracteriza por descoordinación de los movimientos musculares, así como neuropatías periféricas que afectan la sensibilidad y la función motora de las extremidades. \n 4. Seguimiento de lesiones neurológicas: En casos de lesiones neurológicas, como lesiones de la médula espinal o del cerebro, el test de Romberg puede ser utilizado para monitorizar la progresión de los síntomas y la respuesta al tratamiento. \n En resumen, el test de Romberg se utiliza como una herramienta diagnóstica para evaluar la integridad de los mecanismos implicados en el equilibrio y la postura, permitiendo a los profesionales de la salud detectar posibles alteraciones en el sistema sensorial y neurológico que puedan estar afectando la capacidad del paciente para mantenerse en equilibrio.";
    } else if (opcion == 2) {
      texto =
          "La ataxia es un término médico que se refiere a un trastorno de la coordinación muscular. Se manifiesta como una falta de control sobre los movimientos musculares, lo que puede resultar en movimientos torpes, descoordinados o inestables. \n La ataxia puede afectar varias partes del cuerpo y puede ser causada por una variedad de condiciones diferentes, incluyendo trastornos genéticos, lesiones cerebrales, efectos secundarios de ciertos medicamentos, consumo excesivo de alcohol, entre otros. \n Cuando una persona sufre de ataxia, puede experimentar dificultades para caminar, problemas de equilibrio, movimientos imprecisos de las manos, dificultades en el habla y dificultades para tragar. Estos síntomas pueden variar en severidad, dependiendo de la causa subyacente de la ataxia. \n Desde el punto de vista médico, la ataxia se clasifica en diferentes tipos, como la ataxia cerebelosa, la ataxia sensorial, la ataxia vestibular, entre otros, cada una de las cuales tiene sus propias características distintivas y causas subyacentes. \n El tratamiento de la ataxia depende de la causa subyacente, y puede incluir terapia física, terapia ocupacional, medicamentos para controlar los síntomas, o en algunos casos, cirugía para corregir anomalías específicas que estén causando el trastorno. \n Es importante tener en cuenta que la ataxia es un síntoma de una afección subyacente, por lo que es crucial buscar atención médica para entender la causa raíz y recibir el tratamiento adecuado.";
    } else if (opcion == 3) {
      texto =
          "El trastorno del equilibrio, también conocido como trastorno del equilibrio y la coordinación, es un término amplio que abarca una serie de condiciones que afectan la capacidad de una persona para mantenerse en equilibrio y coordinar sus movimientos. Este trastorno puede ser causado por una variedad de razones, que incluyen problemas del oído interno, trastornos neurológicos, lesiones, efectos secundarios de medicamentos, entre otros factores. \n Una de las causas más comunes de trastornos del equilibrio es la disfunción del sistema vestibular, el cual es responsable de regular el equilibrio del cuerpo. Cuando este sistema no funciona adecuadamente, una persona puede experimentar mareos, vértigo, sensación de inestabilidad, y dificultad para mantener el equilibrio. \n Además del sistema vestibular, el trastorno del equilibrio puede estar relacionado con problemas en el cerebelo, que es la parte del cerebro responsable de la coordinación motora. Lesiones en el cerebelo o trastornos que afectan su funcionamiento pueden provocar dificultades en el equilibrio y la coordinación.\n El tratamiento para el trastorno del equilibrio depende de la causa subyacente y puede implicar terapia física, medicamentos para controlar el mareo y el vértigo, así como en algunos casos, procedimientos quirúrgicos para corregir anomalías estructurales. Es importante buscar atención médica especializada si experimentas síntomas de trastorno del equilibrio, ya que un diagnóstico preciso es crucial para iniciar el tratamiento adecuado";
    } else if (opcion == 4) {
      texto =
          "Los test de trastorno de equilibrio son pruebas clínicas diseñadas para evaluar la función del sistema vestibular, el cual es responsable de mantener el equilibrio y la orientación espacial. Estos test pueden incluir una variedad de pruebas, como la prueba de Romberg, la prueba de Fukuda, pruebas de nistagmo, entre otras, que evalúan la capacidad del paciente para mantener el equilibrio, la coordinación motora y la percepción espacial. Estas pruebas son útiles para diagnosticar trastornos del equilibrio, como vértigo, mareos, desequilibrios posturales, entre otros, y pueden ser realizadas por profesionales de la salud especializados en otorrinolaringología o neurología. Los resultados de estos test ayudan a determinar el diagnóstico y el plan de tratamiento adecuado para cada paciente.";
    } else if (opcion == 5) {
      texto =
          "El test de Romberg se utiliza principalmente en neurología como una herramienta de evaluación clínica para detectar trastornos del equilibrio y de la postura, así como para identificar posibles problemas en el sistema sensorial y neurológico relacionados con el equilibrio. Algunas de las razones por las que se utiliza el test de Romberg incluyen:\n 1. Evaluación del sistema vestibular: El test de Romberg puede ayudar a detectar trastornos del sistema vestibular, que es responsable del equilibrio y coordinación del cuerpo. Si un paciente tiene dificultades para mantener la postura con los ojos cerrados, puede ser indicativo de problemas en el laberinto vestibular del oído interno.\n 2. Evaluación de la función propioceptiva: La propiocepción es la capacidad del cuerpo para percibir la posición y movimiento de las articulaciones. El test de Romberg también evalúa la función propioceptiva, ya que al cerrar los ojos se elimina la entrada visual, dejando al sistema propioceptivo como la principal fuente de información para mantener el equilibrio.\n 3. Detectar ataxia y neuropatías periféricas: El test de Romberg puede ayudar a identificar la presencia de ataxia, que se caracteriza por descoordinación de los movimientos musculares, así como neuropatías periféricas que afectan la sensibilidad y la función motora de las extremidades.\n 4. Seguimiento de lesiones neurológicas: En casos de lesiones neurológicas, como lesiones de la médula espinal o del cerebro, el test de Romberg puede ser utilizado para monitorizar la progresión de los síntomas y la respuesta al tratamiento.\n En resumen, el test de Romberg se utiliza como una herramienta diagnóstica para evaluar la integridad de los mecanismos implicados en el equilibrio y la postura, permitiendo a los profesionales de la salud detectar posibles alteraciones en el sistema sensorial y neurológico que puedan estar afectando la capacidad del paciente para mantenerse en equilibrio.";
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(199, 84, 209, 136),
        ),
        body: Stack(
          children: [
            gradient(),
            Center(
                child: SizedBox(
                    height: (MediaQuery.of(context).size.height * 80) / 100,
                    width: (MediaQuery.of(context).size.width * 90) / 100,
                    child: SingleChildScrollView(
                        child: Text(
                      texto,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 24.0, shadows: [
                        Shadow(blurRadius: 0.5, offset: Offset.fromDirection(1))
                      ]),
                    ))))
          ],
        ));
  }
}
