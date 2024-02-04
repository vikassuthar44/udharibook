/*
import 'DriftMyDatabase.dart';

class DatabaseDriftHelper {
  static CustomerDao? customerDao;

  static Future<bool> registerDatabase() async {
    if(customerDao == null) {
      final db = MyDatabase();
      customerDao = CustomerDao(db);
    }
    return customerDao != null;
  }
}*/
