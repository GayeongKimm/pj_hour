import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:hour/local/entity/month_entity.dart';
import '../../../local/database_manager.dart';

class MonthViewmodel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isEditing = false;
  MonthEntity? selectedMonth;
  MonthEntity? currentMonth;

  List<MonthEntity> _monthEntities = [];
  List<MonthEntity> get monthEntities => _monthEntities;

  StreamSubscription<List<MonthEntity>>? _monthStreamSubscription;

  Future<MonthEntity> findByDate(DateTime date) async {
    final database = await DatabaseManager.getDatabase();
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final existing = await database.monthDao.findByDate(firstDayOfMonth);

    if (existing != null) {
      setEditingMonth(existing);
      return existing;
    }

    final newMonth = MonthEntity(
      amount: 0,
      date: firstDayOfMonth,
    );

    await database.monthDao.insertMonthEntity(newMonth);
    setEditingMonth(newMonth);
    return newMonth;
  }

  void clearEditingState() {
    isEditing = false;
    selectedMonth = null;
    notifyListeners();
  }

  void setEditingMonth(MonthEntity month) {
    isEditing = true;
    selectedMonth = month;
    notifyListeners();
  }

  void getMonthEntities() async {
    final database = await DatabaseManager.getDatabase();
    _monthStreamSubscription?.cancel();
    _monthStreamSubscription =
        database.monthDao.findAllEntitiesWithStream().listen((data) {
          _monthEntities = data;
          notifyListeners();
        });
  }

  Future<void> addMonth({
    required int amount,
    required DateTime date,
  }) async {
    final database = await DatabaseManager.getDatabase();
    final newMonth = MonthEntity(amount: amount, date: date);
    await database.monthDao.insertMonthEntity(newMonth);
    notifyListeners();
  }

  Future<void> updateMonth({
    required int id,
    required int amount,
    required DateTime date,
  }) async {
    final database = await DatabaseManager.getDatabase();
    final updated = MonthEntity(id: id, amount: amount, date: date);
    await database.monthDao.updateMonthEntity(updated);
    notifyListeners();
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _monthStreamSubscription?.cancel();
    super.dispose();
  }
}