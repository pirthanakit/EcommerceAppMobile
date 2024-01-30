import 'dart:io';

import 'package:APPE/models/useraccount.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class UseraccountDB {
  //บริการเกียวกับฐานข้อมูล

  late String dbName; //เก็บชื่อฐานข้อมูล

  // ถ้ายังไม่ถูกสร้าง => สร้าง
  // ถูกสร้างไว้แล้ว => เปิด
  UseraccountDB({required this.dbName});

  Future <Database> openDatabase() async {
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    // สร้าง database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Useraccount statement) async {
    //ฐานข้อมูล => Store
    // transaction.db => expense
    var db = await this.openDatabase();
    var user = intMapStoreFactory.store("useraccount");

    // json
    var keyID = user.add(db, {
      "firstName": statement.firstName,
      "lastname": statement.lastName,
      "username": statement.username,
      "email": statement.email,
      "phoneNumber": statement.phoneNumber,
      "password": statement.password,
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมูล

  // ใหม่ => เก่า false มาก => น้อย
  // เก่า => ใหม่ true น้อย => มาก
  // Future<List<Useraccount>> loadAllData() async {
  //   var db = await this.openDatabase();
  //   var user = intMapStoreFactory.store("useraccount");
  //   var snapshot = await user.find(db,
  //       finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
  //   List transactionList = List<Useraccount>();
  //   //ดึงมาทีละแถว
  //   for (var record in snapshot) {
  //     transactionList.add(Useraccount(
  //       firstName: record["firstName"],
  //       lastName: record["amount"],
  //       username: record["title"],
  //       email: record["amount"],
  //       phoneNumber: record["title"],
  //       password: record["amount"],
  //     ));
  //   }
  //   return transactionList;
  // }
}
