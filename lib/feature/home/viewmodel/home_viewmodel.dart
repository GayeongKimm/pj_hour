// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:hour/model/history.dart';
//
// import '../../../local/category/category_database.dart';
//
// class HomeViewmodel with ChangeNotifier {
//   final AppDatabase db;
//   HomeViewmodel(this.db);
//
//   List<tbl_categoryData> _categories = [];
//   List<tbl_historyData> _tblHistories = [];
//
//   List<tbl_categoryData> get categories => _categories;
//   List<tbl_historyData> get tblHistories => _tblHistories;
//
//   // 카테고리 불러오기
//   Future<void> fetchCategories() async {
//     _categories = await db.select(db.tblCategory).get();
//     notifyListeners();
//   }
//
//   // 히스토리 불러오기
//   Future<void> fetchHistories() async {
//     _tblHistories = await db.select(db.tblHistory).get();
//     notifyListeners();
//   }
//
//   // ✅ 카테고리 ID → 이름
//   String getCategoryNameById(int categoryId) {
//     final category = _categories.firstWhere(
//           (c) => c.id == categoryId,
//       orElse: () => tbl_categoryData(id: categoryId, name: '기타'),
//     );
//     return category.name;
//   }
// }