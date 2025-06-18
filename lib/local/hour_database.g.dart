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

  HistoryDao? _historyDaoInstance;

  MonthDao? _monthDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `amount` INTEGER NOT NULL, `date` TEXT NOT NULL, `icon` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `history` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `type` TEXT NOT NULL, `categoryId` INTEGER NOT NULL, `price` INTEGER NOT NULL, `date` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `month` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `amount` INTEGER NOT NULL, `date` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }

  @override
  MonthDao get monthDao {
    return _monthDaoInstance ??= _$MonthDao(database, changeListener);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'category',
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date),
                  'icon': item.icon
                },
            changeListener),
        _categoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'category',
            ['id'],
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date),
                  'icon': item.icon
                },
            changeListener),
        _categoryEntityDeletionAdapter = DeletionAdapter(
            database,
            'category',
            ['id'],
            (CategoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date),
                  'icon': item.icon
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CategoryEntity> _categoryEntityInsertionAdapter;

  final UpdateAdapter<CategoryEntity> _categoryEntityUpdateAdapter;

  final DeletionAdapter<CategoryEntity> _categoryEntityDeletionAdapter;

  @override
  Future<CategoryEntity?> findOutEntityById(int id) async {
    return _queryAdapter.query('SELECT * FROM category WHERE id = ?1',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String),
            icon: row['icon'] as String),
        arguments: [id]);
  }

  @override
  Future<List<CategoryEntity>> findAllEntities() async {
    return _queryAdapter.queryList('SELECT * FROM category',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String),
            icon: row['icon'] as String));
  }

  @override
  Stream<List<CategoryEntity>> findAllEntitiesWithStream() {
    return _queryAdapter.queryListStream('SELECT * FROM category',
        mapper: (Map<String, Object?> row) => CategoryEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String),
            icon: row['icon'] as String),
        queryableName: 'category',
        isView: false);
  }

  @override
  Future<void> deleteCategoryEntityById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM category WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllEntities() async {
    await _queryAdapter.queryNoReturn('DELETE FROM note');
  }

  @override
  Future<void> insertCategoryEntity(CategoryEntity categoryEntity) async {
    await _categoryEntityInsertionAdapter.insert(
        categoryEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCategoryEntity(CategoryEntity categoryEntity) async {
    await _categoryEntityUpdateAdapter.update(
        categoryEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCategoryEntity(CategoryEntity categoryEntity) async {
    await _categoryEntityDeletionAdapter.delete(categoryEntity);
  }
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _historyEntityInsertionAdapter = InsertionAdapter(
            database,
            'history',
            (HistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'type': _historyTypeConverter.encode(item.type),
                  'categoryId': item.categoryId,
                  'price': item.price,
                  'date': _dateTimeConverter.encode(item.date)
                },
            changeListener),
        _historyEntityUpdateAdapter = UpdateAdapter(
            database,
            'history',
            ['id'],
            (HistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'type': _historyTypeConverter.encode(item.type),
                  'categoryId': item.categoryId,
                  'price': item.price,
                  'date': _dateTimeConverter.encode(item.date)
                },
            changeListener),
        _historyEntityDeletionAdapter = DeletionAdapter(
            database,
            'history',
            ['id'],
            (HistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'type': _historyTypeConverter.encode(item.type),
                  'categoryId': item.categoryId,
                  'price': item.price,
                  'date': _dateTimeConverter.encode(item.date)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HistoryEntity> _historyEntityInsertionAdapter;

  final UpdateAdapter<HistoryEntity> _historyEntityUpdateAdapter;

  final DeletionAdapter<HistoryEntity> _historyEntityDeletionAdapter;

  @override
  Future<HistoryEntity?> findHistoryEntityById(int id) async {
    return _queryAdapter.query('SELECT * FROM history WHERE id = ?1',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            type: _historyTypeConverter.decode(row['type'] as String),
            categoryId: row['categoryId'] as int,
            price: row['price'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)),
        arguments: [id]);
  }

  @override
  Future<List<HistoryEntity>> findAllEntities() async {
    return _queryAdapter.queryList('SELECT * FROM history',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            type: _historyTypeConverter.decode(row['type'] as String),
            categoryId: row['categoryId'] as int,
            price: row['price'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)));
  }

  @override
  Stream<List<HistoryEntity>> findAllEntitiesWithStream() {
    return _queryAdapter.queryListStream('SELECT * FROM history',
        mapper: (Map<String, Object?> row) => HistoryEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            type: _historyTypeConverter.decode(row['type'] as String),
            categoryId: row['categoryId'] as int,
            price: row['price'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)),
        queryableName: 'history',
        isView: false);
  }

  @override
  Future<void> deleteHistoryEntityById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM history WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllEntities() async {
    await _queryAdapter.queryNoReturn('DELETE FROM note');
  }

  @override
  Future<void> insertHistoryEntity(HistoryEntity historyEntity) async {
    await _historyEntityInsertionAdapter.insert(
        historyEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateHistoryEntity(HistoryEntity historyEntity) async {
    await _historyEntityUpdateAdapter.update(
        historyEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteHistoryEntity(HistoryEntity historyEntity) async {
    await _historyEntityDeletionAdapter.delete(historyEntity);
  }
}

class _$MonthDao extends MonthDao {
  _$MonthDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _monthEntityInsertionAdapter = InsertionAdapter(
            database,
            'month',
            (MonthEntity item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date)
                },
            changeListener),
        _monthEntityUpdateAdapter = UpdateAdapter(
            database,
            'month',
            ['id'],
            (MonthEntity item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date)
                },
            changeListener),
        _monthEntityDeletionAdapter = DeletionAdapter(
            database,
            'month',
            ['id'],
            (MonthEntity item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'date': _dateTimeConverter.encode(item.date)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MonthEntity> _monthEntityInsertionAdapter;

  final UpdateAdapter<MonthEntity> _monthEntityUpdateAdapter;

  final DeletionAdapter<MonthEntity> _monthEntityDeletionAdapter;

  @override
  Future<MonthEntity?> findOutEntityById(int id) async {
    return _queryAdapter.query('SELECT * FROM month WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MonthEntity(
            id: row['id'] as int?,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)),
        arguments: [id]);
  }

  @override
  Future<List<MonthEntity>> findAllEntities() async {
    return _queryAdapter.queryList('SELECT * FROM month',
        mapper: (Map<String, Object?> row) => MonthEntity(
            id: row['id'] as int?,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)));
  }

  @override
  Stream<List<MonthEntity>> findAllEntitiesWithStream() {
    return _queryAdapter.queryListStream('SELECT * FROM month',
        mapper: (Map<String, Object?> row) => MonthEntity(
            id: row['id'] as int?,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)),
        queryableName: 'month',
        isView: false);
  }

  @override
  Future<void> deleteMonthEntityById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM month WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<MonthEntity?> findByDate(DateTime date) async {
    return _queryAdapter.query('SELECT * FROM month WHERE date = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => MonthEntity(
            id: row['id'] as int?,
            amount: row['amount'] as int,
            date: _dateTimeConverter.decode(row['date'] as String)),
        arguments: [_dateTimeConverter.encode(date)]);
  }

  @override
  Future<void> deleteAllEntities() async {
    await _queryAdapter.queryNoReturn('DELETE FROM note');
  }

  @override
  Future<void> insertMonthEntity(MonthEntity monthEntity) async {
    await _monthEntityInsertionAdapter.insert(
        monthEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMonthEntity(MonthEntity monthEntity) async {
    await _monthEntityUpdateAdapter.update(
        monthEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMonthEntity(MonthEntity monthEntity) async {
    await _monthEntityDeletionAdapter.delete(monthEntity);
  }
}

// ignore_for_file: unused_element
final _timeOfDayConverter = TimeOfDayConverter();
final _dateTimeConverter = DateTimeConverter();
final _historyTypeConverter = HistoryTypeConverter();
