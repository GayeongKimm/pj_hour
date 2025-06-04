import 'package:drift/drift.dart';

class tbl_category extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get month => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();
}