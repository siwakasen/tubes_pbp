import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
CREATE TABLE user(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  username TEXT,
  email TEXT,
  password TEXT,
  name TEXT,
  address TEXT,
  notelp TEXT,
  bornDate TEXT,
  gender TEXT,
  

)
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> adduser(
      String username,
      String email,
      String password,
      String name,
      String address,
      String notelp,
      String bornDate,
      String gender) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'address': address,
      'borndate': bornDate,
      'gender': gender
    };
    return await db.insert('user', data);
  }

  static Future<List<Map<String, dynamic>>> getuser() async {
    final db = await SQLHelper.db();
    return db.query('user');
  }

  static Future<int> edituser(
      int id,
      String username,
      String email,
      String password,
      String name,
      String address,
      String notelp,
      String bornDate,
      String gender) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'address': address,
      'borndate': bornDate,
      'gender': gender
    };

    return await db.update('user', data, where: "id = $id");
  }

  static Future<int> deleteuser(int id) async {
    final db = await SQLHelper.db();

    return await db.delete('user', where: "id = $id");
  }
}
