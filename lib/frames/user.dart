import 'package:flutter/material.dart';
import 'package:romberg_test/db/db.dart';
import 'package:romberg_test/models/user_model.dart';
import 'package:romberg_test/widgets/gradient.dart';

class User extends StatefulWidget {
  const User(int, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateUser(UserModel? user) {
    Navigator.pushReplacementNamed(context, '/manage_user', arguments: user);
  }

  void deleteUser() {
    DB.deleteUser();
    Navigator.pushReplacementNamed(context, '/');
  }

  void createUser() {
    Navigator.pushReplacementNamed(context, '/manage_user',
        arguments: UserModel.genericUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Datos de usuario"),
          shadowColor: Colors.lightGreenAccent,
          backgroundColor: Colors.greenAccent,
        ),
        body: Stack(
          children: [
            gradient(),
            FutureBuilder(
              future: DB.getUser(1),
              initialData: null,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Center(
                      child: ListView(
                    children: [
                      ListTile(
                        title: Text("Nombre de usuario"),
                        subtitle: Text((snapshot.data! as UserModel).name!),
                      ),
                      ListTile(
                        title: Text("Edad de usuario"),
                        subtitle:
                            Text((snapshot.data! as UserModel).age!.toString()),
                      ),
                      ListTile(
                        title: Text("Peso de usuario"),
                        subtitle: Text(
                            (snapshot.data! as UserModel).weight!.toString()),
                      ),
                      ListTile(
                        title: Text("Tamanno de usuario"),
                        subtitle: Text(
                            (snapshot.data! as UserModel).height!.toString()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () => updateUser(((snapshot.data!
                                  as UserModel) as UserModel?)),
                              icon: Icon(Icons.update)),
                          IconButton(
                              onPressed: () => deleteUser(),
                              icon: Icon(Icons.delete_forever))
                        ],
                      ),
                    ],
                  ));
                } else {
                  return Column(
                    children: [
                      Text("No hay datos"),
                      TextButton(
                          onPressed: () => createUser(),
                          child: Text("Crear usuario"))
                    ],
                  );
                }
              },
            ),
          ],
        ));
  }
}
