// import 'dart:io';
//
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:path_provider/path_provider.dart';
//
// part 'drift_database.g.dart';
//
// @DriftDatabase(tables: [
//   // Schedules,
// ])
// class LocalDatabase extends _$LocalDatabase {
//   LocalDatabase() : super(_openConnection());
//
//   @override
//   int get schemaVersion => 1;
// }
//
// LazyDatabase _openConnection() {
//   return LazyDatabase(
//     () async {
//       final dbFolder = await getApplicationDocumentsDirectory();
//       final file = File(p.join(dbFolder.path, 'db.sqlite'));
//       return NativeDatabase(file);
//     },
//   );
// }
