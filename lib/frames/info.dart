import 'package:flutter/material.dart';
import 'package:romberg_test/widgets/gradient.dart';

class Info extends StatelessWidget {
  Info({Key? key}) : super(key: key);

  final List<int> opciones = List.generate(5, (i) => (i + 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(199, 84, 209, 136),
      ),
      body: Stack(children: [
        gradient(),
        Center(
            child: SizedBox(
                height: (MediaQuery.of(context).size.height * 80) / 100,
                width: (MediaQuery.of(context).size.width * 60) / 100,
                child: ListView(children: [
                  ListTile(
                    onTap: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[0])
                    },
                    hoverColor: Color.fromRGBO(81, 128, 77, 0.612),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(100, 100))),
                    title: const Text("Que es el test de romberg",
                        style: TextStyle(fontSize: 24)),
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    onTap: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[1])
                    },
                    hoverColor: Color.fromRGBO(81, 128, 77, 0.612),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(100, 100))),
                    title: const Text("Que es la Ataxia",
                        style: TextStyle(fontSize: 24)),
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    onTap: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[2])
                    },
                    hoverColor: Color.fromRGBO(81, 128, 77, 0.612),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(100, 100))),
                    title: const Text("Que es el trastorno de equilibrio",
                        style: TextStyle(fontSize: 24)),
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    onTap: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[3])
                    },
                    hoverColor: Color.fromRGBO(81, 128, 77, 0.612),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(100, 100))),
                    title: const Text(
                        "Que son los test de control del trastorno del equilibrio",
                        style: TextStyle(fontSize: 24)),
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    onTap: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[4])
                    },
                    hoverColor: Color.fromRGBO(81, 128, 77, 0.612),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(100, 100))),
                    title: const Text(
                        "Como y para que se usa el test de Romberg",
                        style: TextStyle(fontSize: 24)),
                  )
                ])))
      ]),
    );
  }
}
