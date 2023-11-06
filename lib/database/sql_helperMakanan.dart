// ignore_for_file: file_names

import 'package:sqflite/sqflite.dart' as sql;

class SQLMakanan {
  static Future<void> createMakanan(sql.Database database) async {
    await database.execute("""
      CREATE TABLE makanan(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        namaMakanan TEXT,
        hargaMakanan TEXT,
        namaFoto TEXT
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('makanan.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createMakanan(database);
    });
  }

  static Future<int> addmakanan(
      String namaMakanan, String hargaMakanan, String gambarMakanan) async {
    final db = await SQLMakanan.db();
    final data = {
      'namaMakanan': namaMakanan,
      'hargaMakanan': hargaMakanan,
      'namaFoto': gambarMakanan,
    };
    return await db.insert('makanan', data);
  }

  static Future<List<Map<String, dynamic>>> getmakanan() async {
    final db = await SQLMakanan.db();
    return db.query('makanan');
  }

  static Future<int> deletemakanan(int id) async {
    final db = await SQLMakanan.db();

    return await db.delete('makanan', where: "id = $id");
  }

  static Future<List<Map<String, dynamic>>> getMakananByKeyword(
      String keyword) async {
    final db = await SQLMakanan.db();
    return db.query('makanan',
        where: 'namaMakanan LIKE ? OR hargaMakanan LIKE ?',
        whereArgs: ['%$keyword%', '%$keyword%']);
  }

  static Future<int> editmakanan(int id, String namaMakanan,
      String hargaMakanan, String gambarMakanan) async {
    final db = await SQLMakanan.db();
    final data = {
      'namaMakanan': namaMakanan,
      'hargaMakanan': hargaMakanan,
      'namaFoto': gambarMakanan,
    };

    return await db.update('makanan', data, where: "id = $id");
  }
}
