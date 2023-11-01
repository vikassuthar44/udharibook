import '../home/mock_data.dart';

class Util {
  static double finalAmountHistoryCalculate(List<CustomerAmount> customerAmount) {
    double finalAmount = 0.0;
    for (int i = 0; i < customerAmount.length; i++) {
      if (customerAmount[i].isCredit) {
        finalAmount += customerAmount[i].amount;
      } else {
        finalAmount -= customerAmount[i].amount;
      }
    }
    return finalAmount;
  }

  static double finalCustomerAmountCalculate(List<Customer> customerAmount) {
    double finalAmount = 0.0;
    for (int i = 0; i < customerAmount.length; i++) {
      if (customerAmount[i].finalAmount > 0) {
        finalAmount += customerAmount[i].finalAmount;
      } else {
        finalAmount -= customerAmount[i].finalAmount;
      }
    }
    return finalAmount;
  }

  static double finalAmountCalculateGet(List<Customer> customerAmount) {
    double finalAmount = 0.0;
    for (int i = 0; i < customerAmount.length; i++) {
      if (customerAmount[i].finalAmount > 0) {
        finalAmount += customerAmount[i].finalAmount;
      }
    }
    return finalAmount;
  }

  static double finalAmountCalculateGive(List<Customer> customerAmount) {
    double finalAmount = 0.0;
    for (int i = 0; i < customerAmount.length; i++) {
      if (customerAmount[i].finalAmount < 0) {
        finalAmount -= customerAmount[i].finalAmount;
      }
    }
    return finalAmount;
  }
}
