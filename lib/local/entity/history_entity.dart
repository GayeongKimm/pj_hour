import 'package:floor/floor.dart';
import 'package:hour/feature/home/item/home_item.dart';

@Entity(tableName: "history")
class HistoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String content;
  final HistoryType type;
  final int categoryId;
  final int price;
  final DateTime date;

  HistoryEntity({
    this.id,
    required this.title,
    required this.content,
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
          content == other.content &&
          type == other.type &&
          categoryId == other.categoryId &&
          price == other.price &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      type.hashCode ^
      categoryId.hashCode ^
      price.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'HistoryEntity(id: $id, title: $title, content: $content, type: $type, categoryId: $categoryId, price: $price, date: $date)';
  }
}
