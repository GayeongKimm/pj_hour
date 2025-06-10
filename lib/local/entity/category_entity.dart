import 'package:floor/floor.dart';

@Entity(tableName: "category")
class CategoryEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;

  final int amount;

  final DateTime date;

  CategoryEntity({
    this.id,
    required this.title,
    required this.amount,
    required this.date
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              amount == other.amount &&
              date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      amount.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'CategoryEntity(id: $id, title: $title, amount: $amount, date: $date)';
  }
}
