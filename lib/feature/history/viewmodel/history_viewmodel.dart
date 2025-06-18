import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hour/local/database_manager.dart';
import 'package:hour/local/entity/history_entity.dart';
import 'package:provider/provider.dart';

import '../../category/viewmodel/category_viewmodel.dart';
import '../../home/item/home_item.dart';

class HistoryViewmodel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isEditing = false;
  HistoryEntity? selectedHistory;

  List<HistoryEntity> _historyEntities = [];
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

  void getHistoryEntities() async {
    final database = await DatabaseManager.getDatabase();
    _historyStreamSubscription =
        database.historyDao.findAllEntitiesWithStream().listen((data) {
          _historyEntities = data;
          notifyListeners();
        });
  }

  Future<void> removeHistory(int id, BuildContext context) async {
    final database = await DatabaseManager.getDatabase();

    final history = await database.historyDao.findHistoryEntityById(id);
    if (history == null) return;

    await database.historyDao.deleteHistoryEntityById(id);

    final categoryViewModel = context.read<CategoryViewmodel>();

    if (history.type == HistoryType.CONSUMPTION) {
      categoryViewModel.decreaseCategoryPrice(
          history.categoryId,
          history.price
      );
    } else {
      categoryViewModel.increaseCategoryPrice(
          history.categoryId,
          history.price
      );
    }

    notifyListeners();
  }

  Future<void> addHistory({
    required BuildContext context,
    required String title,
    required HistoryType type,
    required int categoryId,
    required int price,
    required DateTime date,
  }) async {
    final database = await DatabaseManager.getDatabase();

    final newHistory = HistoryEntity(
      title: title,
      type: type,
      categoryId: categoryId,
      price: price,
      date: date,
    );
    await database.historyDao.insertHistoryEntity(newHistory);
    final categoryViewModel = context.read<CategoryViewmodel>();

    if (type == HistoryType.CONSUMPTION) {
      categoryViewModel.increaseCategoryPrice(categoryId, price);
    }
    else{
      categoryViewModel.decreaseCategoryPrice(categoryId, price);
    }

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