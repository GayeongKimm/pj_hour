import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hour/local/dao/history_dao.dart';
import 'package:hour/local/dao/month_dao.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'conventer/date_time_conveter.dart';
import 'conventer/history_type_converter.dart';
import 'conventer/time_of_day_converter.dart';
import 'dao/category_dao.dart';
import 'entity/category_entity.dart';
import 'entity/history_entity.dart';
import 'entity/month_entity.dart';

part "hour_database.g.dart";

@TypeConverters([TimeOfDayConverter, DateTimeConverter, HistoryTypeConverter])
@Database(version: 1, entities: [CategoryEntity, HistoryEntity, MonthEntity])
abstract class HourDatabase extends FloorDatabase {
  CategoryDao get categoryDao;
  HistoryDao get historyDao;
  MonthDao get monthDao;
}
