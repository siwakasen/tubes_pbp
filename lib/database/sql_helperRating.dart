import 'package:sqflite/sqflite.dart' as sql;

class SQLMakanan {
  static Future<void> createRating(sql.Database database) async {
    await database.execute("""
      CREATE TABLE rating(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        rateStar TEXT,
        textReview TEXT,
        namaFoto TEXT
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('rating.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createRating(database);
    });
  }

  static Future<int> addRating(
      String rateStar, String textReview, String namaFoto) async {
    final db = await SQLMakanan.db();
    final data = {
      'rateStar': rateStar,
      'textReview': textReview,
      'namaFoto': namaFoto,
    };
    return await db.insert('rating', data);
  }

  static Future<List<Map<String, dynamic>>> getRating() async {
    final db = await SQLMakanan.db();
    return db.query('rating');
  }

  static Future<int> editRating(
      int id, String rateStar, String textReview, String namaFoto) async {
    final db = await SQLMakanan.db();
    final data = {
      'rateStar': rateStar,
      'textReview': textReview,
      'namaFoto': namaFoto,
    };

    return await db.update('rating', data, where: "id = $id");
  }

  static Future<int> deleteRating(int id) async {
    final db = await SQLMakanan.db();

    return await db.delete('rating', where: "id = $id");
  }
}
