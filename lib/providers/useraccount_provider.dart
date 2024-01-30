import 'package:flutter/foundation.dart';

import '../database/useraccount_db.dart';
import '../models/useraccount.dart';

class UseraccountProvider with ChangeNotifier{
    // ตัวอย่างข้อมูล
      List<Useraccount> transactions = [];

      // ดึงข้อมูล
      List<Useraccount> getTransaction(){
        return transactions;
      }
      // void initData() async{
      //     var db=UseraccountDB(dbName: "useraccount.db");
      //     //ดึงข้อมูลมาแสดงผล
      //     transactions=await db.loadAllData();
      //     notifyListeners();
      // }
      
      void addTransaction(Useraccount statement) async{
          var db=UseraccountDB(dbName: "useraccount.db");
          //บันทึกข้อมูล
          await db.InsertData(statement);
          //ดึงข้อมูลมาแสดงผล
          // transactions=await db.loadAllData();
          transactions.insert(0,statement);
          //แจ้งเตือน Consumer
          notifyListeners();
      }
}