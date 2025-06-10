import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hour/local/entity/history_entity.dart';

import '../../../local/database_manager.dart';
import '../../home/item/home_item.dart';
import 'package:flutter/material.dart';

class HistoryCreateViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> createHistory({
    required String title,
    required String content,
    required HistoryType type,
    required int categoryId,
    required int price,
    required DateTime date,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final database = await DatabaseManager.getDatabase();
      final historyEntity = HistoryEntity(
        title: title,
        content: content,
        type: type,
        categoryId: categoryId,
        price: price,
        date: date,
      );

      await database.historyDao.insertHistoryEntity(historyEntity);
    } catch (e) {
      debugPrint('Error creating history: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}