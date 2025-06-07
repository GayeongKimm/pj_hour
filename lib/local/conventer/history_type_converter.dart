import 'package:floor/floor.dart';

import '../../feature/home/item/home_item.dart';

class HistoryTypeConverter extends TypeConverter<HistoryType, String> {

  @override
  HistoryType decode(String databaseValue) {
    return HistoryType.values.firstWhere(
          (e) => e.toString().split('.').last == databaseValue,
      orElse: () => HistoryType.CONSUMPTION,
    );
  }

  @override
  String encode(HistoryType value) {
    return value.toString().split('.').last;
  }
}