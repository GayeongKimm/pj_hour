import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hour/local/entity/history_entity.dart';

import '../../../local/database_manager.dart';
import '../../home/item/home_item.dart';

class HistoryCreateViewModel with ChangeNotifier {
  Future<bool> createHistory({
    required String title,
    required String content,
    required HistoryType type,
    required int categoryId,
    required int price,
    required DateTime date
  }) async {
    final database = await DatabaseManager.getDatabase();
    await database.historyDao.insertHistoryEntity(
        HistoryEntity(
            title: title,
            content: content,
            type: type,
            categoryId: categoryId,
            price: price,
            date: date
        )
    );

    print(await database.historyDao.findAllEntities());

    return true;
  }
}