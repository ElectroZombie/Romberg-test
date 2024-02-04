import 'package:flutter/material.dart';
import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/models/user_model.dart';

Widget manageUserForm(
    TextEditingController nameUser,
    TextEditingController weightUser,
    TextEditingController heightUser,
    TextEditingController ageUser,
    BuildContext context,
    bool act) {
  return ListView(
    children: [
      ListTile(
        title: Text("Nombre del usuario"),
        subtitle: TextFormField(
          controller: nameUser,
          decoration: InputDecoration(labelText: "Nombre de usuario"),
          keyboardType: TextInputType.name,
          maxLength: 20,
          validator: validateNameUser,
        ),
      ),
      ListTile(
        title: Text("Peso del usuario"),
        subtitle: TextFormField(
          controller: weightUser,
          decoration: InputDecoration(labelText: "Peso de usuario"),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          maxLength: 5,
          validator: validateWeightUser,
        ),
      ),
      ListTile(
        title: Text("Tamaño del usuario"),
        subtitle: TextFormField(
          controller: heightUser,
          decoration: InputDecoration(labelText: "Tamaño de usuario"),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          maxLength: 5,
          validator: validateHeightUser,
        ),
      ),
      ListTile(
        title: Text("Edad del usuario"),
        subtitle: TextFormField(
          controller: ageUser,
          decoration: InputDecoration(labelText: "Edad de usuario"),
          keyboardType: TextInputType.number,
          maxLength: 3,
          validator: validateAgeUser,
        ),
      ),
      IconButton.filled(
          onPressed: () =>
              save(nameUser, weightUser, heightUser, ageUser, context, act),
          icon: Icon(Icons.add_circle_outline),
          tooltip: "Guardar Usuario"),
    ],
  );
}

String? validateNameUser(String? value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(pattern);
  if (value!.isEmpty) {
    return "Es necesario introducir un nombre";
  } else if (!regExp.hasMatch(value)) {
    return "El nombre solo puede contener letras de la 'a' a la 'z'";
  } else {
    return "";
  }
}

String? validateWeightUser(String? value) {
  if (value!.isEmpty) {
    return "Es necesario introducir un valor para el peso";
  }
  return "";
}

String? validateHeightUser(String? value) {
  if (value!.isEmpty) {
    return "Es necesario introducir un valor para el peso";
  }
  return "";
}

String? validateAgeUser(String? value) {
  if (value!.isEmpty) {
    return "Es necesario introducir un valor para el peso";
  }
  return "";
}

void save(
    TextEditingController nameUser,
    TextEditingController weightUser,
    TextEditingController heightUser,
    TextEditingController ageUser,
    context,
    bool act) {
  UserModel user = UserModel(
      id: 1,
      name: nameUser.text,
      height: double.parse(heightUser.text),
      weight: double.parse(weightUser.text),
      age: int.parse(ageUser.text));
  if (act) {
    DB.updateUser(user);
  } else {
    DB.insertNewUser(user);
  }
  Navigator.pushReplacementNamed(context, '/user');
}
