// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorWorkoutDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$WorkoutDatabaseBuilder databaseBuilder(String name) =>
      _$WorkoutDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$WorkoutDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$WorkoutDatabaseBuilder(null);
}

class _$WorkoutDatabaseBuilder {
  _$WorkoutDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$WorkoutDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$WorkoutDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<WorkoutDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$WorkoutDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$WorkoutDatabase extends WorkoutDatabase {
  _$WorkoutDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WorkoutEventDao? _workoutEventDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `WorkoutEventEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `occuredOn` INTEGER NOT NULL, `workoutType` TEXT NOT NULL, `sets` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WorkoutEventDao get workoutEventDao {
    return _workoutEventDaoInstance ??=
        _$WorkoutEventDao(database, changeListener);
  }
}

class _$WorkoutEventDao extends WorkoutEventDao {
  _$WorkoutEventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _workoutEventEntityInsertionAdapter = InsertionAdapter(
            database,
            'WorkoutEventEntity',
            (WorkoutEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'occuredOn': item.occuredOn,
                  'workoutType': item.workoutType,
                  'sets': item.sets
                }),
        _workoutEventEntityUpdateAdapter = UpdateAdapter(
            database,
            'WorkoutEventEntity',
            ['id'],
            (WorkoutEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'occuredOn': item.occuredOn,
                  'workoutType': item.workoutType,
                  'sets': item.sets
                }),
        _workoutEventEntityDeletionAdapter = DeletionAdapter(
            database,
            'WorkoutEventEntity',
            ['id'],
            (WorkoutEventEntity item) => <String, Object?>{
                  'id': item.id,
                  'occuredOn': item.occuredOn,
                  'workoutType': item.workoutType,
                  'sets': item.sets
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WorkoutEventEntity>
      _workoutEventEntityInsertionAdapter;

  final UpdateAdapter<WorkoutEventEntity> _workoutEventEntityUpdateAdapter;

  final DeletionAdapter<WorkoutEventEntity> _workoutEventEntityDeletionAdapter;

  @override
  Future<List<WorkoutEventEntity>> getAllWorkoutEvents() async {
    return _queryAdapter.queryList('SELECT * FROM WorkoutEventEntity',
        mapper: (Map<String, Object?> row) => WorkoutEventEntity(
            id: row['id'] as int,
            occuredOn: row['occuredOn'] as int,
            workoutType: row['workoutType'] as String,
            sets: row['sets'] as int));
  }

  @override
  Future<WorkoutEventEntity?> getWorkoutEventById(int id) async {
    return _queryAdapter.query('SELECT * FROM WorkoutEventEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => WorkoutEventEntity(
            id: row['id'] as int,
            occuredOn: row['occuredOn'] as int,
            workoutType: row['workoutType'] as String,
            sets: row['sets'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertWorkoutEvent(WorkoutEventEntity workoutEvent) async {
    await _workoutEventEntityInsertionAdapter.insert(
        workoutEvent, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateWorkoutEvent(WorkoutEventEntity workoutEvent) async {
    await _workoutEventEntityUpdateAdapter.update(
        workoutEvent, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteWorkoutEvent(WorkoutEventEntity workoutEvent) async {
    await _workoutEventEntityDeletionAdapter.delete(workoutEvent);
  }
}
