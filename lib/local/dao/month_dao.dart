import 'package:floor/floor.dart';

import '../entity/month_entity.dart';

@dao
abstract class MonthDao {
  @Query('SELECT * FROM $_tableName WHERE id = :id')
  Future<MonthEntity?> findOutEntityById(int id);

  @Query('SELECT * FROM $_tableName')
  Future<List<MonthEntity>> findAllEntities();

  @Query('SELECT * FROM $_tableName')
  Stream<List<MonthEntity>> findAllEntitiesWithStream();

  @Query('DELETE FROM $_tableName WHERE id = :id')
  Future<void> deleteMonthEntityById(int id);

  @Query('SELECT * FROM month WHERE date = :date LIMIT 1')
  Future<MonthEntity?> findByDate(DateTime date);

  @insert
  Future<void> insertMonthEntity(MonthEntity monthEntity);

  @update
  Future<void> updateMonthEntity(MonthEntity monthEntity);

  @delete
  Future<void> deleteMonthEntity(MonthEntity monthEntity);

  @Query("DELETE FROM note")
  Future<void> deleteAllEntities();

  static const String _tableName = "month";
}
