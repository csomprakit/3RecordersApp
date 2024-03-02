// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorEmotionDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EmotionDatabaseBuilder databaseBuilder(String name) =>
      _$EmotionDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EmotionDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$EmotionDatabaseBuilder(null);
}

class _$EmotionDatabaseBuilder {
  _$EmotionDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$EmotionDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$EmotionDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<EmotionDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$EmotionDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$EmotionDatabase extends EmotionDatabase {
  _$EmotionDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EmotionEventDao? _emotionEventDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `EmotionEventEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `emotion` TEXT NOT NULL, `occurredOn` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EmotionEventDao get emotionEventDao {
    return _emotionEventDaoInstance ??=
        _$EmotionEventDao(database, changeListener);
  }
}

class _$EmotionEventDao extends EmotionEventDao {
  _$EmotionEventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _emotionEventEntityInsertionAdapter = InsertionAdapter(
            database,
            'EmotionEventEntity',
            (EmotionEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'emotion': item.emotion,
                  'occurredOn': item.occurredOn
                }),
        _emotionEventEntityUpdateAdapter = UpdateAdapter(
            database,
            'EmotionEventEntity',
            ['id'],
            (EmotionEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'emotion': item.emotion,
                  'occurredOn': item.occurredOn
                }),
        _emotionEventEntityDeletionAdapter = DeletionAdapter(
            database,
            'EmotionEventEntity',
            ['id'],
            (EmotionEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'emotion': item.emotion,
                  'occurredOn': item.occurredOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EmotionEventEntity>
      _emotionEventEntityInsertionAdapter;

  final UpdateAdapter<EmotionEventEntity> _emotionEventEntityUpdateAdapter;

  final DeletionAdapter<EmotionEventEntity> _emotionEventEntityDeletionAdapter;

  @override
  Future<List<EmotionEventEntity>> getAllEmotionEvents() async {
    return _queryAdapter.queryList('SELECT * FROM EmotionEventEntity',
        mapper: (Map<String, Object?> row) => EmotionEventEntity(
            id: row['id'] as int,
            emotion: row['emotion'] as String,
            occurredOn: row['occurredOn'] as int));
  }

  @override
  Future<EmotionEventEntity?> getEmotionEventById(int id) async {
    return _queryAdapter.query('SELECT * FROM EmotionEventEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => EmotionEventEntity(
            id: row['id'] as int,
            emotion: row['emotion'] as String,
            occurredOn: row['occurredOn'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertEmotionEvent(EmotionEventEntity emotionEvent) async {
    await _emotionEventEntityInsertionAdapter.insert(
        emotionEvent, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEmotionEvent(EmotionEventEntity emotionEvent) async {
    await _emotionEventEntityUpdateAdapter.update(
        emotionEvent, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEmotionEvent(EmotionEventEntity emotionEvent) async {
    await _emotionEventEntityDeletionAdapter.delete(emotionEvent);
  }
}
