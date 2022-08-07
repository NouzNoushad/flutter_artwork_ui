import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Db {
  Database? db;
  Future open() async {
    sqfliteFfiInit();
    var databasePath = await databaseFactoryFfi.getDatabasesPath();
    String path = join(databasePath, 'artwork.db');
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    print(path);

    db = await databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (Database db, int index) async {
              await db.execute('''
                  CREATE TABLE artworks(
                    id integer primary key autoIncrement,
                    username varchar(255) not null,
                    email varchar(255) not null,
                    password varchar(255) not null
                  );
                ''');
            }));
  }
}
