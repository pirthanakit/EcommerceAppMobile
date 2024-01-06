import 'package:mongo_dart/mongo_dart.dart';

void addDataToMongoDB() async {
  final db = Db('mongodb+srv://thanakitpirth:6301@cluster0.yu3nwzh.mongodb.net/testlogin');
  await db.open();
  print('Connected to MongoDB!');

  final collection = db.collection('users'); // ชื่อคอลเล็กชันที่ต้องการจะใช้

  // ข้อมูลที่ต้องการเพิ่มลงใน MongoDB
  final dataToAdd = {
    'firstName': 'Thanakit',
    'lastName': 'Yuenyong',
    'username': 'Perth',
    'email': 'Perth@test.com',
    'phoneNo': '0639189343',
    'password': '1127',
    // ข้อมูลอื่น ๆ ที่ต้องการเพิ่ม
  };

  await collection.insert(dataToAdd);
  print('Data added to MongoDB!');

  await db.close();
  print('Disconnected from MongoDB!');
}
