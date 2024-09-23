import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDatabaseSetting() async{
  String path=join(await getDatabasesPath(),'fluttersetting.db ');

  print(path);
  return await openDatabase(
    path,
    version: 1,
    onCreate:(db,version) async{
      await db.execute('''
        CREATE TABLE tbsetting(
          id INTEGER PRIMARY KEY,
          api_key TEXT,
          referer_key TEXT,
          language TEXT,
          is_dark INTEGER,
          is_production INTEGER
        )
      ''');
    } );
}

// insert data
Future<void> insertData()async{
  Database db=await openDatabaseSetting();
    await db.insert('tbsetting', {'api_key':'1f78ef77601c4ca7a66f7392ac4f9d1d','referer_key':'123X','language':'km','is_dark':0,'is_production':0}
    );
}

// get data
Future<List<Map<String,dynamic>>> getData() async{
  Database db=await openDatabaseSetting();
  List<Map<String,dynamic>> data=await db.query('tbsetting');
  print(data);
  return data;
}

Future<void> dropTable() async {
  Database db = await openDatabaseSetting();
  await db.execute('DROP TABLE IF EXISTS tbsetting');
}

// update data
Future<void> updateData(int id) async{
  Database db=await openDatabaseSetting();

  await db.update('tbsetting', {'api_key':'1f78ef77601c4ca7a66f7392ac4f9d1d','referer_key':'123X','language':'en','is_dark':1,'is_production':1},where: 'id=?', whereArgs: [id]);
}
 