// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $tbl_categoryTable extends tbl_category
    with TableInfo<$tbl_categoryTable, tbl_categoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $tbl_categoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<String> month = GeneratedColumn<String>(
      'month', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, month, amount, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tbl_category';
  @override
  VerificationContext validateIntegrity(Insertable<tbl_categoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  tbl_categoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return tbl_categoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}month'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
    );
  }

  @override
  $tbl_categoryTable createAlias(String alias) {
    return $tbl_categoryTable(attachedDatabase, alias);
  }
}

class tbl_categoryData extends DataClass
    implements Insertable<tbl_categoryData> {
  final int id;
  final String month;
  final int amount;
  final DateTime date;
  const tbl_categoryData(
      {required this.id,
      required this.month,
      required this.amount,
      required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['month'] = Variable<String>(month);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  tbl_categoryCompanion toCompanion(bool nullToAbsent) {
    return tbl_categoryCompanion(
      id: Value(id),
      month: Value(month),
      amount: Value(amount),
      date: Value(date),
    );
  }

  factory tbl_categoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return tbl_categoryData(
      id: serializer.fromJson<int>(json['id']),
      month: serializer.fromJson<String>(json['month']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'month': serializer.toJson<String>(month),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  tbl_categoryData copyWith(
          {int? id, String? month, int? amount, DateTime? date}) =>
      tbl_categoryData(
        id: id ?? this.id,
        month: month ?? this.month,
        amount: amount ?? this.amount,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('tbl_categoryData(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, month, amount, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is tbl_categoryData &&
          other.id == this.id &&
          other.month == this.month &&
          other.amount == this.amount &&
          other.date == this.date);
}

class tbl_categoryCompanion extends UpdateCompanion<tbl_categoryData> {
  final Value<int> id;
  final Value<String> month;
  final Value<int> amount;
  final Value<DateTime> date;
  const tbl_categoryCompanion({
    this.id = const Value.absent(),
    this.month = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
  });
  tbl_categoryCompanion.insert({
    this.id = const Value.absent(),
    required String month,
    required int amount,
    required DateTime date,
  })  : month = Value(month),
        amount = Value(amount),
        date = Value(date);
  static Insertable<tbl_categoryData> custom({
    Expression<int>? id,
    Expression<String>? month,
    Expression<int>? amount,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (month != null) 'month': month,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
    });
  }

  tbl_categoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? month,
      Value<int>? amount,
      Value<DateTime>? date}) {
    return tbl_categoryCompanion(
      id: id ?? this.id,
      month: month ?? this.month,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (month.present) {
      map['month'] = Variable<String>(month.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('tbl_categoryCompanion(')
          ..write('id: $id, ')
          ..write('month: $month, ')
          ..write('amount: $amount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $tbl_categoryTable tblCategory = $tbl_categoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tblCategory];
}
