import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hour/local/database_manager.dart';
import 'package:hour/local/entity/history_entity.dart';

import '../../home/item/home_item.dart';

class HistoryViewmodel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<HistoryEntity> _historyEntities = List.empty();
  List<HistoryEntity> get historyEntities => _historyEntities;

  StreamSubscription<List<HistoryEntity>>? _historyStreamSubscription;

  void _getHistoryEntities() async {
    final database = await DatabaseManager.getDatabase();
    _historyStreamSubscription = database.historyDao.findAllEntitiesWithStream().listen((data) {
      _historyEntities = data;
      notifyListeners();
    });
  }

  Future<void> addCategory({
    required String title,
    required HistoryType type,
    required int categoryId,
    required int price,
    required DateTime date,
  }) async {
    final database = await DatabaseManager.getDatabase();

    final newCategory = HistoryEntity(
        title: title,
        type: type,
        categoryId: categoryId,
        price: price,
        date: date,
    );

    await database.historyDao.insertHistoryEntity(newCategory);
    notifyListeners();
  }

  void removeEntity(int id) async {
    final database = await DatabaseManager.getDatabase();
    await database.historyDao.deleteHistoryEntityById(id);
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  @override
  void dispose() {
    _historyStreamSubscription?.cancel();
    super.dispose();
  }
}