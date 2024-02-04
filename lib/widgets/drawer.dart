import 'package:flutter/material.dart';

import 'gradient.dart';

Drawer drawer(context) {
  return Drawer(
      child: Stack(
    children: [
      gradient(),
      ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            child: Text("Test de Romberg",
                style: TextStyle(
                    color: Color.fromARGB(255, 49, 48, 47), fontSize: 24),
                textAlign: TextAlign.center),
          ),
          ListTile(
            hoverColor: const Color.fromARGB(255, 189, 148, 60),
            leading: const Icon(Icons.person),
            title: const Text("Usuario"),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/user", ModalRoute.withName("/"));
            },
          ),
          const ListTile(
            hoverColor: Color.fromARGB(255, 189, 148, 60),
            leading: Icon(Icons.arrow_circle_left_outlined),
            title: Text("tests"),
            //tilde
          ),
          ListTile(
              hoverColor: const Color.fromARGB(255, 189, 148, 60),
              leading: const Icon(Icons.text_snippet),
              title: const Text("Romberg Test"),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/romberg_test", ModalRoute.withName("/"));
              }),
          const SizedBox(height: 150),
          const ListTile(
            leading: Icon(Icons.adb),
            title: Text("Versión: 1.3.6"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Flutter SDK: 3.13.0"),
                Text("Dart SDK: 3.1.0"),
                Text("Android SDK: 31.0.0"),
                Text("Java Version: 17.0.8"),
                SizedBox(
                    height: 40,
                    width: 40,
                    child:
                        Image(image: AssetImage("assets/logos/guayaba.jpg"))),
                Text("Autores:"),
                Text("Joan Manuel Molina Gómez"),
                Text("Eric Michel Villavicencio Reyes"),
              ],
            ),
          )
        ],
      ),
    ],
  ));
}
