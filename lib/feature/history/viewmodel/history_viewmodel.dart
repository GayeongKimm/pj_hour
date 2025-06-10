import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hour/local/entity/history_entity.dart';

import '../../../local/database_manager.dart';

class HistoryViewmodel with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<HistoryEntity> _historyEntities = List.empty();
  List<HistoryEntity> get historyEntities => _historyEntities;

  StreamSubscription<List<HistoryEntity>>? _historyStreamSubscription;

  void _getHistoryEntities() async {
    final database = await DatabaseManager.getDatabase();
    _historyStreamSubscription
    = database.historyDao.findAllEntitiesWithStream().listen((data) {
      _historyEntities = data;
      notifyListeners();
    });
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