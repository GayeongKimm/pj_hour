import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hour/local/entity/category_entity.dart';

import '../../../local/database_manager.dart';

class CategoryViewmodel with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CategoryEntity> _categoryEntities = List.empty();
  List<CategoryEntity> get categoryEntities => _categoryEntities;

  StreamSubscription<List<CategoryEntity>>? _categoryStreamSubscription;

  void _getCategoryEntities() async {
    final database = await DatabaseManager.getDatabase();
    _categoryStreamSubscription
    = database.categoryDao.findAllEntitiesWithStream().listen((data) {
      _categoryEntities = data;
      notifyListeners();
    });
  }

  void removeEntity(int id) async {
    final database = await DatabaseManager.getDatabase();
    await database.categoryDao.deleteCategoryEntityById(id);
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  @override
  void dispose() {
    _categoryStreamSubscription?.cancel();
    super.dispose();
  }
}