// ignore_for_file: depend_on_referenced_packages

import 'dart:io' as io;
import 'package:romberg_test/models/curve_point_model.dart';
import 'package:romberg_test/models/curve_point_range_model.dart';
import 'package:romberg_test/models/test_data_model.dart';
import 'package:romberg_test/models/test_done_model.dart';
import 'package:romberg_test/models/test_model.dart';
import 'package:romberg_test/models/user_model.dart';
import 'package:romberg_test/models/value_range_model.dart';
import 'package:romberg_test/utils/tuple.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    if (io.Platform.isAndroid) {
      return openDatabase(
        join(await getDatabasesPath(), 'romberg.db'),
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE user (id_user INTEGER PRIMARY KEY, name_user TEXT, height_user DOUBLE, weight_user DOUBLE, age_user INTEGER)");
          await db.execute(
              "CREATE TABLE test (id_test INTEGER PRIMARY KEY, name_test TEXT, time_test DOUBLE)");
          await db.execute(
              "CREATE TABLE test_done (id_test_done INTEGER PRIMARY KEY, id_test INTEGER, id_user INTEGER, date DATE, personal_V INTEGER)");
          await db.execute(
              "CREATE TABLE data_test_done (id_test_done INTEGER, gX DOUBLE, gY DOUBLE, gZ DOUBLE, aX DOUBLE, aY DOUBLE, aZ DOUBLE, time INTEGER)");
          await db.execute(
              "CREATE TABLE value_range (id_value_range INTEGER PRIMARY KEY, id_test INTEGER, height_m DOUBLE, heightM DOUBLE, weight_m DOUBLE, weightM DOUBLE, age_m DOUBLE, ageM DOUBLE)");
          await db.execute(
            "CREATE TABLE value_range_data (id_value_range INTEGER, time_i INTEGER, gXi DOUBLE, gXR DOUBLE, gYi DOUBLE, gYR DOUBLE, gZi DOUBLE, gZR DOUBLE, aXi DOUBLE, aXR DOUBLE, aYi DOUBLE, aYR DOUBLE, aZi DOUBLE, aZR DOUBLE)",
          );
        },
        version: 1,
      );
    }

    var db = databaseFactoryFfi;
    String dbpath = join(await getDatabasesPath(), 'testdb.db');
    return db.openDatabase(dbpath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute(
                "CREATE TABLE user (id_user INTEGER PRIMARY KEY, name_user TEXT, height_user DOUBLE, weight_user DOUBLE, age_user INTEGER)");
            await db.execute(
                "CREATE TABLE test (id_test INTEGER PRIMARY KEY, name_test TEXT, time_test DOUBLE)");
            await db.execute(
                "CREATE TABLE test_done (id_test_done INTEGER PRIMARY KEY, id_test INTEGER, id_user INTEGER, date DATE, personal_V INTEGER)");
            await db.execute(
                "CREATE TABLE data_test_done (id_test_done INTEGER, gX DOUBLE, gY DOUBLE, gZ DOUBLE, aX DOUBLE, aY DOUBLE, aZ DOUBLE, time INTEGER)");
            await db.execute(
                "CREATE TABLE value_range (id_value_range INTEGER PRIMARY KEY, id_test INTEGER, height_m DOUBLE, height_M DOUBLE, weight_m DOUBLE, weight_M DOUBLE, age_m DOUBLE, age_M DOUBLE)");
            await db.execute(
              "CREATE TABLE value_range_data (id_value_range INTEGER, time_i INTEGER, gXi DOUBLE, gXR DOUBLE, gYi DOUBLE, gYR DOUBLE, gZi DOUBLE, gZR DOUBLE, aXi DOUBLE, aXR DOUBLE, aYi DOUBLE, aYR DOUBLE, aZi DOUBLE, aZR DOUBLE)",
            );
          },
        ));
  }

  static Future<void> insertNewUser(UserModel user) async {
    Database database = await _openDB();

    await database.insert("user", user.toMap());
    return;
  }

  static Future<void> deleteUser() async {
    Database db = await _openDB();
    await db.delete('user');
    return;
  }

  static Future<void> updateUser(UserModel user) async {
    Database db = await _openDB();
    await db.update('user', user.toMap(),
        where: "id_user = ?", whereArgs: [user.id]);
    return;
  }

  static Future<UserModel> getUser(int idUser) async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> Q =
        await database.query("user", where: "id_user = ?", whereArgs: [idUser]);

    return List.generate(
        Q.length,
        (i) => UserModel(
            id: Q[i]['id_user'],
            name: Q[i]['name_user'],
            height: Q[i]['height_user'],
            weight: Q[i]['weight_user'],
            age: Q[i]['age_user'])).first;
  }

  static Future<bool> verifyUser() async {
    Database D = await _openDB();
    final List<Map<String, dynamic>> Q = await D.query("user");
    if (Q.isEmpty) {
      return false;
    }
    return true;
  }

  static Future<void> insertNewTest(TestModel test) async {
    Database D = await _openDB();
    D.insert('test', test.toMap());
  }

  static Future<List<Tuple>> getAllTestNames() async {
    Database D = await _openDB();
    final List<Map<String, dynamic>> Q = await D.query('test');
    return List.generate(Q.length,
        (i) => Tuple(elem1: Q[i]['id_test'], elem2: Q[i]['name_test']));
  }

  static Future<TestModel> getTest(idTest) async {
    Database D = await _openDB();
    final List<Map<String, dynamic>> Q =
        await D.query('test', where: 'id_test = ?', whereArgs: idTest);

    return List.generate(
        Q.length,
        (i) => TestModel(
            id: Q[i]['id_test'],
            name: Q[i]['name_test'],
            time: Q[i]['time_test'])).first;
  }

  static Future<void> insertNewTestDone(TestDoneModel testDoneModel) async {
    Database D = await _openDB();
    D.insert('test_done', testDoneModel.toMap());
  }

  static Future<List<TestDoneModel>> getAllTestDoneByUser(idUser) async {
    Database D = await _openDB();
    final List<Map<String, dynamic>> Q =
        await D.query('test_done', where: 'id_user = ?', whereArgs: idUser);
    return List.generate(
        Q.length,
        (i) => TestDoneModel(
            idTestDone: Q[i]['id_test_done'],
            idTest: Q[i]['id_test'],
            idUser: idUser,
            valorUser: Q[i]['personal_v'],
            date: Q[i]['date']));
  }

  static Future<TestDoneModel> getTestDoneByID(idTestDone) async {
    Database D = await _openDB();
    final List<Map<String, dynamic>> Q = await D.query('test_done',
        where: 'id_test_done = ?', whereArgs: idTestDone);
    return List.generate(
        Q.length,
        (i) => TestDoneModel(
            idTestDone: Q[i]['id_test_done'],
            idTest: Q[i]['id_test'],
            idUser: Q[i]['id_user'],
            valorUser: Q[i]['personal_v'],
            date: Q[i]['date'])).first;
  }

  static Future<int> getLastIdTestDone() async {
    Database D = await _openDB();
    final List<Map<String, dynamic>> Q =
        await D.rawQuery('SELECT MAX (id_test_done) FROM test_done');
    return List.generate(Q.length, (i) => Q[i]['id_test_done']).first;
  }

  static Future<void> deleteTestDone(idTestDone) async {
    Database D = await _openDB();

    D.delete('data_test_done',
        where: 'id_test_done = ?', whereArgs: idTestDone);
    D.delete('test_done', where: 'id_test_done = ?', whereArgs: idTestDone);
  }

  static Future<void> insertDataTestDone(TestDataModel testDataModel) async {
    Database D = await _openDB();

    for (int i = 0; i < testDataModel.curva.length; i++) {
      D.rawInsert(
          "INSERT INTO data_test_done VALUES (${testDataModel.idTestDone}, ${testDataModel.curva[i].gx}, ${testDataModel.curva[i].gy}, ${testDataModel.curva[i].gz}, ${testDataModel.curva[i].ax}, ${testDataModel.curva[i].ay}, ${testDataModel.curva[i].az}, ${testDataModel.curva[i].tiempo})");
    }
  }

  static Future<TestDataModel> getDataTestDone(idTestDone) async {
    Database D = await _openDB();
    final List<Map<String, dynamic>> Q = await D.query('data_test_done',
        where: 'id_test_done = ?', whereArgs: idTestDone);
    List<CurvePointModel> curva = List.generate(
        Q.length,
        (i) => CurvePointModel(
            tiempo: Q[i]['time'],
            gx: Q[i]['gX'],
            gy: Q[i]['gY'],
            gz: Q[i]['gZ'],
            ax: Q[i]['aX'],
            ay: Q[i]['aY'],
            az: Q[i]['aZ']));

    TestDataModel testData = TestDataModel(idTestDone: idTestDone);
    for (int i = 0; i < curva.length; i++) {
      testData.insertCurvePoint(curva[i].tiempo, curva[i].gx, curva[i].gy,
          curva[i].gz, curva[i].ax, curva[i].ay, curva[i].az);
    }
    return testData;
  }

  static Future<int> getLastIdValueRange() async {
    Database D = await _openDB();
    final List<Map<String, dynamic>> Q =
        await D.rawQuery('SELECT MAX (id_value_range) FROM value_range');
    return List.generate(Q.length, (i) => Q[i]['MAX (id_value_range)']).first;
  }

  static Future<void> insertNewDataRange(ValueRangeModel valueRange) async {
    Database D = await _openDB();

    D.insert('value_range', valueRange.toMap());

    int id = await getLastIdValueRange();

    for (int i = 0; i < valueRange.rangoCurva.length; i++) {
      D.rawInsert(
          "INSERT INTO value_range_data VALUES ($id, $i, ${valueRange.rangoCurva[i].gxi}, ${valueRange.rangoCurva[i].gxri}, ${valueRange.rangoCurva[i].gyi}, ${valueRange.rangoCurva[i].gyri}, ${valueRange.rangoCurva[i].gzi}, ${valueRange.rangoCurva[i].gzri}, ${valueRange.rangoCurva[i].axi}, ${valueRange.rangoCurva[i].axri}, ${valueRange.rangoCurva[i].ayi}, ${valueRange.rangoCurva[i].ayri}, ${valueRange.rangoCurva[i].azi}, ${valueRange.rangoCurva[i].azri})");
    }
  }

  static Future<void> deleteDataRange(id) async {
    Database D = await _openDB();
    D.delete('value_range_data', where: 'value_range_id = ?', whereArgs: id);
    D.delete('value_range', where: 'value_range_id = ?', whereArgs: id);
  }

  static Future<ValueRangeModel> getDataRange(int id) async {
    Database db = await _openDB();

    ValueRangeModel valores = ValueRangeModel(
        idValueRange: 1,
        idTest: 1,
        minimumAge: 1,
        maximumAge: 1,
        minimumWeight: 1,
        maximunWeight: 1,
        minimumHeight: 1,
        maximumHeight: 1);
    final List<Map<String, dynamic>> Q = await db.query("value_range_data",
        where: 'id_value_range = ?', whereArgs: [id]);

    for (var i = 0; i < Q.length; i++) {
      valores.insertRangePoint(CurvePointRangeModel(
          i: i,
          gxi: Q[i]['gXi'],
          gxri: Q[i]['gXR'],
          gyi: Q[i]['gYi'],
          gyri: Q[i]['gYR'],
          gzi: Q[i]['gZi'],
          gzri: Q[i]['gZR'],
          axi: Q[i]['aXi'],
          axri: Q[i]['aXR'],
          ayi: Q[i]['aYi'],
          ayri: Q[i]['aYR'],
          azi: Q[i]['aZi'],
          azri: Q[i]['aZR']));
    }

    return valores;
  }
}
