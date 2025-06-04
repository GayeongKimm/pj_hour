import 'package:drift/drift.dart';

class tbl_history extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  IntColumn get category => integer()();
  IntColumn get price => integer()();
  DateTimeColumn get date => dateTime()();
}