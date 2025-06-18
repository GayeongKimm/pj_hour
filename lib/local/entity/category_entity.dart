import 'package:floor/floor.dart';

@Entity(tableName: "category")
class CategoryEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String title;
  final int amount;
  final DateTime date;
  final String icon;

  CategoryEntity({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CategoryEntity(id: $id, title: $title, amount: $amount, date: $date, icon: $icon)';
  }
}