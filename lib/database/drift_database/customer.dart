import 'package:drift/drift.dart';

class CustomerTable extends Table {

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().nullable()();

  TextColumn get phoneNumber => text().nullable()();

  RealColumn get finalAmount => real().nullable()();
}
