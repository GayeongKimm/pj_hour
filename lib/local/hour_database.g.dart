// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hour_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $HourDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $HourDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $HourDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<HourDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorHourDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $HourDatabaseBuilderContract databaseBuilder(String name) =>
      _$HourDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $HourDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$HourDatabaseBuilder(null);
}

class _$HourDatabaseBuilder implements $HourDatabaseBuilderContract {
  _$HourDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $HourDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $HourDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<HourDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$HourDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$HourDatabase extends HourDatabase {
  _$HourDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CategoryDao? _categoryDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `month` TEXT NOT NULL, `amount` INTEGER NOT NULL, `date` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  ) : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<CategoryEntity?> findOutEntityById(int id) async {
    return _queryAdapter.query('SELECT * FROM category WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            month: row['month'] as String,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)),
        arguments: [id]);
  }

  @override
  Future<List<CategoryEntity>> findAllEntities() async {
    return _queryAdapter.queryList('SELECT * FROM category',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            month: row['month'] as String,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)));
  }

  @override
  Stream<List<CategoryEntity>> findAllEntitiesWithStream() {
    return _queryAdapter.queryListStream('SELECT * FROM category',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            month: row['month'] as String,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)),
        queryableName: 'category',
        isView: false);
  }

  @override
  Future<void> deleteAllOutEntities() async {
    await _queryAdapter.queryNoReturn('DELETE FROM note');
  }
}

// ignore_for_file: unused_element
final _timeOfDayConverter = TimeOfDayConverter();
final _dateTimeConverter = DateTimeConverter();
final _historyTypeConverter = HistoryTypeConverter();
