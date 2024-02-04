import 'package:flutter/material.dart';
import 'package:romberg_test/widgets/gradient.dart';

class MainFrame extends StatefulWidget {
  const MainFrame({Key? key}) : super(key: key);

  @override
  MainFrameState createState() => MainFrameState();
}

void goToPage(context, String dir) {
  Navigator.pushNamed(context, dir);
}

class MainFrameState extends State<MainFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test de Romberg"),
        shadowColor: Colors.lightGreenAccent,
        backgroundColor: Colors.greenAccent,
      ),
      //  drawer: drawer(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Informacion sobre el test de Romberg",
        child: const Icon(Icons.info),
        onPressed: () => goToPage(context, '/info'),
      ),
      body: Stack(
        children: [
          gradient(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Iniciar test de Romberg",
                  style: TextStyle(
                      fontSize: 24,
                      backgroundColor: Color.fromARGB(111, 255, 255, 255)),
                ),
                IconButton(
                    onPressed: () => goToPage(context, '/romberg_test'),
                    icon: Icon(Icons.not_started))
              ],
            ),
          )
        ],
      ),
    );
  }
}
