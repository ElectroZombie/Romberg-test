import 'dart:io';

import 'package:flutter/material.dart';
import 'package:romberg_test/db/initialize_db.dart';
import 'package:romberg_test/frames/inf.dart';
import 'package:romberg_test/frames/manage_user.dart';
import 'package:romberg_test/frames/info.dart';
import 'package:romberg_test/frames/main_frame.dart';
import 'package:romberg_test/frames/test.dart';
import 'package:romberg_test/frames/user.dart';
import 'package:romberg_test/frames/user_data.dart';
import 'package:romberg_test/frames/user_results.dart';
import 'package:romberg_test/frames/romberg_test.dart';
import 'package:romberg_test/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  if (Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  if (isFirstTime) {
    await initializeDB();
    await prefs.setBool('isFirstTime', false);
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Romberg",
      initialRoute: "/",
      routes: {
        "/": (context) => const MainFrame(),
        "/user": (context) => const User(int),
        "/manage_user": (context) => ManageUser(),
        "/romberg_test": (context) => const RombergTest(UserModel),
        "/user_data": (context) => const UserData(UserModel),
        "/user_results": (context) => UserResults(List<int>),
        "/info": (context) => Info(),
        "/inf": (context) => Inf(int),
        '/test': (context) => Test()
      },
    );
  }
}


//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