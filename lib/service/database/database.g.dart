// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorSultanDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$SultanDatabaseBuilder databaseBuilder(String name) =>
      _$SultanDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$SultanDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$SultanDatabaseBuilder(null);
}

class _$SultanDatabaseBuilder {
  _$SultanDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$SultanDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$SultanDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<SultanDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$SultanDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$SultanDatabase extends SultanDatabase {
  _$SultanDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SultanDao _sultanDaoInstance;

  SultanCartDao _sultanCartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Sultan` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `price` INTEGER, `englishName` TEXT, `url` TEXT, `type` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SultanCart` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `email` TEXT, `quantity` INTEGER, `image` TEXT, `price` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SultanDao get sultanDao {
    return _sultanDaoInstance ??= _$SultanDao(database, changeListener);
  }

  @override
  SultanCartDao get sultanCartDao {
    return _sultanCartDaoInstance ??= _$SultanCartDao(database, changeListener);
  }
}

class _$SultanDao extends SultanDao {
  _$SultanDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _sultanInsertionAdapter = InsertionAdapter(
            database,
            'Sultan',
            (Sultan item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price,
                  'englishName': item.englishName,
                  'url': item.url,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sultan> _sultanInsertionAdapter;

  @override
  Future<List<Sultan>> getCachedMenu() async {
    return _queryAdapter.queryList('Select * FROM Sultan',
        mapper: (Map<String, dynamic> row) => Sultan(
            row['name'] as String,
            row['price'] as int,
            row['englishName'] as String,
            row['url'] as String,
            row['type'] as String,
            id: row['id'] as int));
  }

  @override
  Future<Sultan> getSultanPizzaInfo(String name) async {
    return _queryAdapter.query('Select * From Sultan Where name=?',
        arguments: <dynamic>[name],
        mapper: (Map<String, dynamic> row) => Sultan(
            row['name'] as String,
            row['price'] as int,
            row['englishName'] as String,
            row['url'] as String,
            row['type'] as String,
            id: row['id'] as int));
  }

  @override
  Future<void> insertCachedMenu(List<Sultan> allMenu) async {
    await _sultanInsertionAdapter.insertList(allMenu, OnConflictStrategy.abort);
  }
}

class _$SultanCartDao extends SultanCartDao {
  _$SultanCartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _sultanCartInsertionAdapter = InsertionAdapter(
            database,
            'SultanCart',
            (SultanCart item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'quantity': item.quantity,
                  'image': item.image,
                  'price': item.price
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SultanCart> _sultanCartInsertionAdapter;

  @override
  Future<void> deleteFromCart(String email) async {
    await _queryAdapter.queryNoReturn('Delete from SultanCart where email =?',
        arguments: <dynamic>[email]);
  }

  @override
  Future<List<SultanCart>> selectAllItems(String email) async {
    return _queryAdapter.queryList('Select * from SultanCart where email =?',
        arguments: <dynamic>[email],
        mapper: (Map<String, dynamic> row) => SultanCart(
            id: row['id'] as int,
            name: row['name'] as String,
            email: row['email'] as String,
            quantity: row['quantity'] as int,
            image: row['image'] as String,
            price: row['price'] as int));
  }

  @override
  Future<void> deleteOneItem(String name, String email) async {
    await _queryAdapter.queryNoReturn(
        'Delete from SultanCart where name =? and email =?',
        arguments: <dynamic>[name, email]);
  }

  @override
  Future<void> insertItemToCart(SultanCart sultanItem) async {
    await _sultanCartInsertionAdapter.insert(
        sultanItem, OnConflictStrategy.abort);
  }
}
