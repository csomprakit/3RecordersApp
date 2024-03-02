// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDietDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DietDatabaseBuilder databaseBuilder(String name) =>
      _$DietDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DietDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$DietDatabaseBuilder(null);
}

class _$DietDatabaseBuilder {
  _$DietDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DietDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DietDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DietDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DietDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DietDatabase extends DietDatabase {
  _$DietDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DietEventDao? _dietEventDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `DietEventEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `food` TEXT NOT NULL, `servings` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DietEventDao get dietEventDao {
    return _dietEventDaoInstance ??= _$DietEventDao(database, changeListener);
  }
}

class _$DietEventDao extends DietEventDao {
  _$DietEventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _dietEventEntityInsertionAdapter = InsertionAdapter(
            database,
            'DietEventEntity',
            (DietEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'food': item.food,
                  'servings': item.servings
                }),
        _dietEventEntityUpdateAdapter = UpdateAdapter(
            database,
            'DietEventEntity',
            ['id'],
            (DietEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'food': item.food,
                  'servings': item.servings
                }),
        _dietEventEntityDeletionAdapter = DeletionAdapter(
            database,
            'DietEventEntity',
            ['id'],
            (DietEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'food': item.food,
                  'servings': item.servings
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DietEventEntity> _dietEventEntityInsertionAdapter;

  final UpdateAdapter<DietEventEntity> _dietEventEntityUpdateAdapter;

  final DeletionAdapter<DietEventEntity> _dietEventEntityDeletionAdapter;

  @override
  Future<List<DietEventEntity>> getAllDietEvents() async {
    return _queryAdapter.queryList('SELECT * FROM DietEventEntity',
        mapper: (Map<String, Object?> row) => DietEventEntity(
            id: row['id'] as int,
            food: row['food'] as String,
            servings: row['servings'] as int));
  }

  @override
  Future<DietEventEntity?> getDietEventById(int id) async {
    return _queryAdapter.query('SELECT * FROM DietEventEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DietEventEntity(
            id: row['id'] as int,
            food: row['food'] as String,
            servings: row['servings'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertDietEvent(DietEventEntity dietEvent) async {
    await _dietEventEntityInsertionAdapter.insert(
        dietEvent, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDietEvent(DietEventEntity dietEvent) async {
    await _dietEventEntityUpdateAdapter.update(
        dietEvent, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDietEvent(DietEventEntity dietEvent) async {
    await _dietEventEntityDeletionAdapter.delete(dietEvent);
  }
}
