import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hour/local/entity/category_entity.dart';

import '../../../local/database_manager.dart';

class CategoryCreateViewmodel with ChangeNotifier {
  Future<bool> createCategory({
    required String month,
    required int amount,
    required DateTime date,
  }) async {
    final database = await DatabaseManager.getDatabase();
    await database.categoryDao.insertCategoryEntity(
        CategoryEntity(
            month: month,
            amount: amount,
            date: date
        )
    );

    print(await database.categoryDao.findAllEntities());

    return true;
  }
}