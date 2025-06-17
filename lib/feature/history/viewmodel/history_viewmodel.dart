import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hour/local/database_manager.dart';
import 'package:hour/local/entity/history_entity.dart';

import '../../home/item/home_item.dart';

class HistoryViewmodel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool isEditing = false;
  HistoryEntity? selectedHistory;

  List<HistoryEntity> _historyEntities = List.empty();
  List<HistoryEntity> get historyEntities => _historyEntities;

  StreamSubscription<List<HistoryEntity>>? _historyStreamSubscription;

  void clearEditingState() {
    isEditing = false;
    selectedHistory = null;
    notifyListeners();
  }

  void setEditingHistory(HistoryEntity history) {
    isEditing = true;
    selectedHistory = history;
    notifyListeners();
  }

  void getCategoryEntities() async {
    final database = await DatabaseManager.getDatabase();
    _historyStreamSubscription =
        database.historyDao.findAllEntitiesWithStream().listen((data) {
          _historyEntities = data;
          notifyListeners();
        });
  }

  void removeEntity(int id) async {
    final database = await DatabaseManager.getDatabase();
    await database.historyDao.deleteHistoryEntityById(id);
    notifyListeners();
  }

  Future<void> addCategory({
    required String title,
    required int price,
    required DateTime date,
    required HistoryType type,
    required int categoryId,
  }) async {
    final database = await DatabaseManager.getDatabase();

    final newHistory = HistoryEntity(
      title: title,
      price: price,
      date: date,
      type: type,
      categoryId: categoryId,
    );

    await database.historyDao.insertHistoryEntity(newHistory);
    notifyListeners();
  }

  Future<void> updateCategory({
    required int id,
    required String title,
    required int price,
    required DateTime date,
    required HistoryType type,
    required int categoryId,
  }) async {
    final database = await DatabaseManager.getDatabase();

    final updatedHistory = HistoryEntity(
      id: id,
      title: title,
      price: price,
      date: date,
      type: type,
      categoryId: categoryId,
    );

    await database.historyDao.updateHistoryEntity(updatedHistory);
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