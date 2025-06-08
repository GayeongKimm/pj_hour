import 'package:floor/floor.dart';
import 'package:hour/feature/home/item/home_item.dart';
import 'package:hour/local/entity/category_entity.dart';

@Entity(
  tableName: "history",
  foreignKeys: [
    ForeignKey(
      childColumns: ['categoryId'],
      parentColumns: ['id'],
      entity: CategoryEntity,
    ),
  ],
)
class HistoryEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final String content;
  final HistoryType type;
  final int categoryId;
  final int price;
  final DateTime date;

  HistoryEntity(
      this.id,
      this.title,
      this.content,
      this.type,
      this.categoryId,
      this.price,
      this.date,
      );

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
    return 'CategoryEntity(id: $id, title: $title, content: $content, type: $type, category: $categoryId, price: $price)';
  }
}
