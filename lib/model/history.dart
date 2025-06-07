// import 'package:drift/drift.dart';
// import 'package:hour/local/conventer/history_type_converter.dart';
// import 'package:hour/model/category.dart';
//
// class tbl_history extends Table{
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get title => text()();
//   TextColumn get content => text()();
//   TextColumn get type => text().map(const HistoryTypeConverter())();
//   IntColumn get category => integer().references(tbl_category, #id)();
//   IntColumn get price => integer()();
//   DateTimeColumn get date => dateTime()();
// }