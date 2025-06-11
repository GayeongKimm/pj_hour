import 'package:floor/floor.dart';
import 'package:hour/feature/home/item/home_item.dart';

@Entity(tableName: "history")
class HistoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final HistoryType type;
  final int categoryId;
  final int price;
  final DateTime date;

  HistoryEntity({
    this.id,
    required this.title,
    required this.type,
    required this.categoryId,
    required this.price,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          type == other.type &&
          categoryId == other.categoryId &&
          price == other.price &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      type.hashCode ^
      categoryId.hashCode ^
      price.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'HistoryEntity(id: $id, title: $title, type: $type, categoryId: $categoryId, price: $price, date: $date)';
  }
}
