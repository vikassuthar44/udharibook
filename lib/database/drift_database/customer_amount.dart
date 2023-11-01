
import 'package:drift/drift.dart';

class CustomerAmountTable extends Table {

  IntColumn get id => integer().autoIncrement()();

  IntColumn get customerId => integer().nullable()();

  RealColumn get amount => real().nullable()();

  IntColumn get isCredit => integer().nullable()();

  TextColumn get date => text().nullable()();

  TextColumn get time => text().nullable()();

  TextColumn get message => text().nullable()();
}
