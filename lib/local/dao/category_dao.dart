import 'package:floor/floor.dart';
import 'package:hour/local/entity/category_entity.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM $_tableName WHERE id = :id')
  Future<CategoryEntity?> findOutEntityById(int id);

  @Query('SELECT * FROM $_tableName')
  Future<List<CategoryEntity>> findAllEntities();

  @Query('SELECT * FROM $_tableName')
  Stream<List<CategoryEntity>> findAllEntitiesWithStream();

  @Query('DELETE FROM $_tableName WHERE id = :id')
  Future<void> deleteCategoryEntityById(int id);

  @insert
  Future<void> insertCategoryEntity(CategoryEntity categoryEntity);

  @update
  Future<void> updateCategoryEntity(CategoryEntity categoryEntity);

  @delete
  Future<void> deleteCategoryEntity(CategoryEntity categoryEntity);

  @Query("DELETE FROM note")
  Future<void> deleteAllEntities();

  static const String _tableName = "category";
}
