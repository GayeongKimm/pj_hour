import 'package:floor/floor.dart';

@Entity(tableName: "category")
class CategoryEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String month;

  final int amount;

  final DateTime date;

  CategoryEntity({
    this.id,
    required this.month,
    required this.amount,
    required this.date
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              month == other.month &&
              amount == other.amount &&
              date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      month.hashCode ^
      amount.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'CategoryEntity(id: $id, month: $month, amount: $amount, date: $date)';
  }
}
