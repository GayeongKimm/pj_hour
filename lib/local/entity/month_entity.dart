import 'package:floor/floor.dart';

@Entity(tableName: "month")
class MonthEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int amount;

  final DateTime date;

  MonthEntity({
    this.id,
    required this.amount,
    required this.date
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MonthEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              amount == other.amount &&
              date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      amount.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'MonthEntity(id: $id, amount: $amount, date: $date)';
  }

  factory MonthEntity.forMonth({
    int? id,
    required int amount,
    required DateTime date,
  }) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    return MonthEntity(
      id: id,
      amount: amount,
      date: firstDayOfMonth,
    );
  }
}
