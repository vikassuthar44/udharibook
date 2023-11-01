// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriftMyDatabase.dart';

// ignore_for_file: type=lint
class $CustomerTableTable extends CustomerTable
    with TableInfo<$CustomerTableTable, CustomerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _finalAmountMeta =
      const VerificationMeta('finalAmount');
  @override
  late final GeneratedColumn<double> finalAmount = GeneratedColumn<double>(
      'final_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, phoneNumber, finalAmount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_table';
  @override
  VerificationContext validateIntegrity(Insertable<CustomerTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('final_amount')) {
      context.handle(
          _finalAmountMeta,
          finalAmount.isAcceptableOrUnknown(
              data['final_amount']!, _finalAmountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      finalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}final_amount']),
    );
  }

  @override
  $CustomerTableTable createAlias(String alias) {
    return $CustomerTableTable(attachedDatabase, alias);
  }
}

class CustomerTableData extends DataClass
    implements Insertable<CustomerTableData> {
  final int id;
  final String? name;
  final String? phoneNumber;
  final double? finalAmount;
  const CustomerTableData(
      {required this.id, this.name, this.phoneNumber, this.finalAmount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || finalAmount != null) {
      map['final_amount'] = Variable<double>(finalAmount);
    }
    return map;
  }

  CustomerTableCompanion toCompanion(bool nullToAbsent) {
    return CustomerTableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      finalAmount: finalAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(finalAmount),
    );
  }

  factory CustomerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      finalAmount: serializer.fromJson<double?>(json['finalAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'finalAmount': serializer.toJson<double?>(finalAmount),
    };
  }

  CustomerTableData copyWith(
          {int? id,
          Value<String?> name = const Value.absent(),
          Value<String?> phoneNumber = const Value.absent(),
          Value<double?> finalAmount = const Value.absent()}) =>
      CustomerTableData(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        finalAmount: finalAmount.present ? finalAmount.value : this.finalAmount,
      );
  @override
  String toString() {
    return (StringBuffer('CustomerTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('finalAmount: $finalAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phoneNumber, finalAmount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.phoneNumber == this.phoneNumber &&
          other.finalAmount == this.finalAmount);
}

class CustomerTableCompanion extends UpdateCompanion<CustomerTableData> {
  final Value<int> id;
  final Value<String?> name;
  final Value<String?> phoneNumber;
  final Value<double?> finalAmount;
  const CustomerTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.finalAmount = const Value.absent(),
  });
  CustomerTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.finalAmount = const Value.absent(),
  });
  static Insertable<CustomerTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phoneNumber,
    Expression<double>? finalAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (finalAmount != null) 'final_amount': finalAmount,
    });
  }

  CustomerTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? name,
      Value<String?>? phoneNumber,
      Value<double?>? finalAmount}) {
    return CustomerTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      finalAmount: finalAmount ?? this.finalAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (finalAmount.present) {
      map['final_amount'] = Variable<double>(finalAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('finalAmount: $finalAmount')
          ..write(')'))
        .toString();
  }
}

class $CustomerAmountTableTable extends CustomerAmountTable
    with TableInfo<$CustomerAmountTableTable, CustomerAmountTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerAmountTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isCreditMeta =
      const VerificationMeta('isCredit');
  @override
  late final GeneratedColumn<int> isCredit = GeneratedColumn<int>(
      'is_credit', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
      'time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, customerId, amount, isCredit, date, time, message];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_amount_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CustomerAmountTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    if (data.containsKey('is_credit')) {
      context.handle(_isCreditMeta,
          isCredit.isAcceptableOrUnknown(data['is_credit']!, _isCreditMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerAmountTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerAmountTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount']),
      isCredit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_credit']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date']),
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time']),
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message']),
    );
  }

  @override
  $CustomerAmountTableTable createAlias(String alias) {
    return $CustomerAmountTableTable(attachedDatabase, alias);
  }
}

class CustomerAmountTableData extends DataClass
    implements Insertable<CustomerAmountTableData> {
  final int id;
  final int? customerId;
  final double? amount;
  final int? isCredit;
  final String? date;
  final String? time;
  final String? message;
  const CustomerAmountTableData(
      {required this.id,
      this.customerId,
      this.amount,
      this.isCredit,
      this.date,
      this.time,
      this.message});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || isCredit != null) {
      map['is_credit'] = Variable<int>(isCredit);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<String>(time);
    }
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    return map;
  }

  CustomerAmountTableCompanion toCompanion(bool nullToAbsent) {
    return CustomerAmountTableCompanion(
      id: Value(id),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      amount:
          amount == null && nullToAbsent ? const Value.absent() : Value(amount),
      isCredit: isCredit == null && nullToAbsent
          ? const Value.absent()
          : Value(isCredit),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
    );
  }

  factory CustomerAmountTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerAmountTableData(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      amount: serializer.fromJson<double?>(json['amount']),
      isCredit: serializer.fromJson<int?>(json['isCredit']),
      date: serializer.fromJson<String?>(json['date']),
      time: serializer.fromJson<String?>(json['time']),
      message: serializer.fromJson<String?>(json['message']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int?>(customerId),
      'amount': serializer.toJson<double?>(amount),
      'isCredit': serializer.toJson<int?>(isCredit),
      'date': serializer.toJson<String?>(date),
      'time': serializer.toJson<String?>(time),
      'message': serializer.toJson<String?>(message),
    };
  }

  CustomerAmountTableData copyWith(
          {int? id,
          Value<int?> customerId = const Value.absent(),
          Value<double?> amount = const Value.absent(),
          Value<int?> isCredit = const Value.absent(),
          Value<String?> date = const Value.absent(),
          Value<String?> time = const Value.absent(),
          Value<String?> message = const Value.absent()}) =>
      CustomerAmountTableData(
        id: id ?? this.id,
        customerId: customerId.present ? customerId.value : this.customerId,
        amount: amount.present ? amount.value : this.amount,
        isCredit: isCredit.present ? isCredit.value : this.isCredit,
        date: date.present ? date.value : this.date,
        time: time.present ? time.value : this.time,
        message: message.present ? message.value : this.message,
      );
  @override
  String toString() {
    return (StringBuffer('CustomerAmountTableData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('amount: $amount, ')
          ..write('isCredit: $isCredit, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('message: $message')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, customerId, amount, isCredit, date, time, message);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerAmountTableData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.amount == this.amount &&
          other.isCredit == this.isCredit &&
          other.date == this.date &&
          other.time == this.time &&
          other.message == this.message);
}

class CustomerAmountTableCompanion
    extends UpdateCompanion<CustomerAmountTableData> {
  final Value<int> id;
  final Value<int?> customerId;
  final Value<double?> amount;
  final Value<int?> isCredit;
  final Value<String?> date;
  final Value<String?> time;
  final Value<String?> message;
  const CustomerAmountTableCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.isCredit = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.message = const Value.absent(),
  });
  CustomerAmountTableCompanion.insert({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.isCredit = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.message = const Value.absent(),
  });
  static Insertable<CustomerAmountTableData> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<double>? amount,
    Expression<int>? isCredit,
    Expression<String>? date,
    Expression<String>? time,
    Expression<String>? message,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (amount != null) 'amount': amount,
      if (isCredit != null) 'is_credit': isCredit,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (message != null) 'message': message,
    });
  }

  CustomerAmountTableCompanion copyWith(
      {Value<int>? id,
      Value<int?>? customerId,
      Value<double?>? amount,
      Value<int?>? isCredit,
      Value<String?>? date,
      Value<String?>? time,
      Value<String?>? message}) {
    return CustomerAmountTableCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      amount: amount ?? this.amount,
      isCredit: isCredit ?? this.isCredit,
      date: date ?? this.date,
      time: time ?? this.time,
      message: message ?? this.message,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (isCredit.present) {
      map['is_credit'] = Variable<int>(isCredit.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerAmountTableCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('amount: $amount, ')
          ..write('isCredit: $isCredit, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('message: $message')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $CustomerTableTable customerTable = $CustomerTableTable(this);
  late final $CustomerAmountTableTable customerAmountTable =
      $CustomerAmountTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [customerTable, customerAmountTable];
}

mixin _$CustomerDaoMixin on DatabaseAccessor<MyDatabase> {
  $CustomerTableTable get customerTable => attachedDatabase.customerTable;
  $CustomerAmountTableTable get customerAmountTable =>
      attachedDatabase.customerAmountTable;
}
