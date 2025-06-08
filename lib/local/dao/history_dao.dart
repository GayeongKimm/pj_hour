
import 'package:floor/floor.dart';
import 'package:hour/local/entity/history_entity.dart';

@dao
abstract class HistoryDao {
  @Query('SELECT * FROM $_tableName WHERE id = :id')
  Future<HistoryEntity?> findOutEntityById(int id);

  @Query('SELECT * FROM $_tableName')
  Future<List<HistoryEntity>> findAllEntities();

  @Query('SELECT * FROM $_tableName')
  Stream<List<HistoryEntity>> findAllEntitiesWithStream();

  @Query("DELETE FROM note")
  Future<void> deleteAllOutEntities();

  static const String _tableName = "history";
}
