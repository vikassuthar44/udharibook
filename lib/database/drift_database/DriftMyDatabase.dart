import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:udhari_book/database/drift_database/customer.dart';
import 'package:udhari_book/home/mock_data.dart';

import 'customer_amount.dart';

part 'DriftMyDatabase.g.dart';

@DriftDatabase(tables: [CustomerTable, CustomerAmountTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

/*Future<void> addCustomer(CustomerTableCompanion entry) {
    return into(customerTable).insert(entry);
  }

  Future<void> addCustomerAmount(CustomerAmountTableCompanion entry) {
    return into(customerAmountTable).insert(entry);
  }*/
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'udharibook.db'));
    return NativeDatabase(file);
  });
}

@DriftAccessor(tables: [CustomerTable, CustomerAmountTable])
class CustomerDao extends DatabaseAccessor<MyDatabase> with _$CustomerDaoMixin {
  CustomerDao(MyDatabase db) : super(db);

  //add customer
  Future<void> addCustomer(Customer customer) {
    CustomerTableCompanion entry = CustomerTableCompanion(
        name: Value(customer.name),
        phoneNumber: Value(customer.phoneNumber),
        finalAmount: Value(customer.finalAmount));
    return into(customerTable).insert(entry);
  }

  Future<void> updateCustomer(int? customerId, double finalAmount) {
    /*CustomerTableCompanion entry = CustomerTableCompanion(
        name: Value(customer.name),
        phoneNumber: Value(customer.phoneNumber),
        finalAmount: Value(customer.finalAmount));*/
    return (update(customerTable)..where((tbl) => tbl.id.equals(customerId!))).write(CustomerTableCompanion(
      finalAmount: Value(finalAmount)
    ));
  }

  //insert customer amount
  Future<void> addCustomerAmount(CustomerAmount customerAmount) {
    CustomerAmountTableCompanion entry = CustomerAmountTableCompanion(
      customerId: Value(customerAmount.customerId),
      amount: Value(customerAmount.amount),
      isCredit: Value(customerAmount.isCredit == true ? 1 : 0),
      date: Value(customerAmount.date),
      time: Value(customerAmount.time),
      message: Value(customerAmount.message),
    );
    return into(customerAmountTable).insert(entry);
  }

  //get All customer's
  Future<List<Customer>> getAllCustomer() async {
    print("DriftDatabase getAllCustomer");
    Future<List<CustomerTableData>> customerTableDatas =
        select(customerTable).get();
    print("DriftDatabase customerTableDatas $customerTableDatas");
    List<CustomerTableData> datas = await customerTableDatas;
    print("DriftDatabase datas $datas");
    List<Customer> customers = List.generate(datas.length, (index) {
      print("DriftDatabase inside index $index data ${datas[index]}");
      Map<String, dynamic> customerMap = {
        'id': datas[index].id,
        'name': datas[index].name,
        'phoneNumber': datas[index].phoneNumber,
        'finalAmount': datas[index].finalAmount
      };
      return Customer.fromMap(customerMap);
    });
    print("DriftDatabase $customers");
    return customers;
  }

  //get customer amount history
  Future<List<CustomerAmount>> getCustomerAmountHistory(int? customerId) async {
    print("DriftDatabase getAllCustomer");
    Future<List<CustomerAmountTableData>> customerAmountTableDatas = (select(customerAmountTable)..where((tbl) => tbl.customerId.equals(customerId!))).get();
    print("DriftDatabase customerTableDatas $customerAmountTableDatas");
    List<CustomerAmountTableData> datas = await customerAmountTableDatas;
    print("DriftDatabase datas $datas");
    List<CustomerAmount> customerAmountHistories = List.generate(datas.length, (index) {
      print("DriftDatabase inside index $index data ${datas[index]}");
      Map<String, dynamic> customerAmountMap = {
        'id': datas[index].id,
        'customerId': datas[index].customerId,
        'amount': datas[index].amount,
        'isCredit': datas[index].isCredit,
        'date': datas[index].date,
        'time': datas[index].time,
        'message': datas[index].message,
      };
      return CustomerAmount.fromMap(customerAmountMap);
    });
    print("DriftDatabase $customerAmountHistories");
    return customerAmountHistories;
  }
}
