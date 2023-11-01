/*

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../home/mock_data.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'customer.db');

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE customer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phoneNumber TEXT,
        finalAmount REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE customer_amount (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerId INTEGER,
        amount REAL,
        isCredit INTEGER,
        date TEXT,
        time TEXT,
        message TEXT
      )
    ''');
  }

  Future<List<Customer>> getCustomerList() async {
    final db = await database;
    final customers = await db?.query('customer');
    final List<Customer> customerList = List.generate(customers!.length, (i) {
      return Customer.fromMap(customers[i]);
    });
    print("Database ${customers.length}");
    print("Database customer list ${customerList.length}");
    */
/*for (final customer in customerList) {
      final amounts = await db?.rawQuery(
          'SELECT * FROM customer_amount WHERE customerId = ?', [customer.id]);
      print("Database amount $amounts");
      customer.customerAmount = List.generate(amounts!.length, (i) {
        return CustomerAmount.fromMap(amounts[i]);
      });
    }*//*

    print("Database customer list end ${customerList.length}");
    return customerList;
  }

  Future<List<CustomerAmount>> getCustomerAmountHistory(int? customerId) async {
    final db = await database;
    final amountHistory = await db?.rawQuery(
        'SELECT * FROM customer_amount WHERE customerId = ?', [customerId]);
    final List<CustomerAmount> customerAmountHistoryList = List.generate(amountHistory!.length, (index) {
      return CustomerAmount.fromMap(amountHistory[index]);
    });
    return customerAmountHistoryList;
  }

  Future<void> addAmountHistory(CustomerAmount customerAmount) async {
    final db = await database;
    final customerId = await db?.insert('customer_amount', customerAmount.toMap());
  }

  Future<void> addCustomer(Customer customer) async {
    final db = await database;
    final customerId = await db?.insert('customer', customer.toMap());
   */
/* for (final amount in customer.customerAmount) {
      amount.customerId = customerId!;
      await db?.insert('customer_amount', amount.toMap());
    }*//*

  }

  Future<void> updateCustomer(Customer customer) async {
    final db = await database;
    await db?.update(
      'customer',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
    */
/*for (final amount in customer.customerAmount) {
      if (amount.id == null) {
        amount.customerId = customer.id!;
        await db?.insert('customer_amount', amount.toMap());
      } else {
        await db?.update(
          'customer_amount',
          amount.toMap(),
          where: 'id = ?',
          whereArgs: [amount.id],
        );
      }
    }*//*

  }
}*/
