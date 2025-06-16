import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hour/local/entity/category_entity.dart';

import '../../../local/database_manager.dart';

class CategoryViewmodel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool isEditing = false;
  CategoryEntity? selectedCategory;

  List<CategoryEntity> _categoryEntities = List.empty();
  List<CategoryEntity> get categoryEntities => _categoryEntities;

  StreamSubscription<List<CategoryEntity>>? _categoryStreamSubscription;

  void clearEditingState() {
    isEditing = false;
    selectedCategory = null;
    notifyListeners();
  }

  void setEditingCategory(CategoryEntity category) {
    isEditing = true;
    selectedCategory = category;
    notifyListeners();
  }

  void getCategoryEntities() async {
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

  Future<void> addCategory({
    required String title,
    required int amount,
    required DateTime date,
    required String icon
  }) async {
    final database = await DatabaseManager.getDatabase();

    final newCategory = CategoryEntity(
        title: title,
        amount: amount,
        date: date,
        icon: icon
    );

    await database.categoryDao.insertCategoryEntity(newCategory);
    notifyListeners();
  }

  Future<void> updateCategory({
    required int id,
    required String title,
    required int amount,
    required String icon

  }) async {
    final database = await DatabaseManager.getDatabase();

    final updatedCategory = CategoryEntity(
      id: id,
      title: title,
      amount: amount,
      icon: icon,
      date: DateTime.now(),
    );

    await database.categoryDao.updateCategoryEntity(updatedCategory);
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