import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class database {
  Future<Database> getdata() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Contact.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table datatable (ID integer primary key autoincrement , name text, company text , title text , number text)');
    });
    return database;
  }

  static Future<void> inserdata(String name1, String comp1, String title1,
      String phone1, Database database) async {
    String insert =
        "insert into datatable  (name,company,title,number)  values('$name1','$comp1','$title1','$phone1')";
    int cnt = await database.rawInsert(insert);
  }

  Future<List<Map>> viewdatabase(Database database) async {
    String view = "select * from datatable";
    List<Map> list = await database.rawQuery(view);
    return list;
  }

  static Future<void> delete(Database database, int i) async {
    String delete = "delete from datatable where ID = '$i'";
    int del = await database.rawDelete(delete);
    print("=================$delete");
  }

 static Future<void> updatedata(String name1, String comp1, String title1,
      String phone1, int id, Database database) async {
    String update =
        "update datatable set name = '$name1',company = '$comp1',title = '$title1', number = '$phone1' where ID = '$id'";
    int aa = await database.rawUpdate(update);
  }
}
