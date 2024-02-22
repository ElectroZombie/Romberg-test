import 'package:flutter/material.dart';
import 'package:romberg_test/widgets/gradient.dart';

class Info extends StatelessWidget {
  Info({Key? key}) : super(key: key);

  final List<int> opciones = List.generate(5, (i) => (i + 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        gradient(),
        ListView(children: [
          ListTile(
            title: Text("Que es el test de romberg"),
            trailing: IconButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[0])
                    },
                icon: Icon(Icons.arrow_right_sharp)),
          ),
          ListTile(
            title: Text("Que es la Ataxia"),
            trailing: IconButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[1])
                    },
                icon: Icon(Icons.arrow_right_sharp)),
          ),
          ListTile(
            title: Text("Que es el trastorno de equilibrio"),
            trailing: IconButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[2])
                    },
                icon: Icon(Icons.arrow_right_sharp)),
          ),
          ListTile(
            title: Text(
                "Que son los test de control del trastorno del equilibrio"),
            trailing: IconButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[3])
                    },
                icon: Icon(Icons.arrow_right_sharp)),
          ),
          ListTile(
            title: Text("Como y para que se usa el test de Romberg"),
            trailing: IconButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/inf',
                          arguments: opciones[4])
                    },
                icon: Icon(Icons.arrow_right_sharp)),
          )
        ])
      ]),
    );
  }
}
