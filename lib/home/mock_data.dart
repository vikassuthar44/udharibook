class Customer {
  int? id = null;
  late String name;
  late String phoneNumber;
  late double finalAmount;

  //late List<CustomerAmount> customerAmount;

  Customer({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.finalAmount,
    //required this.customerAmount
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'finalAmount': finalAmount
    };
  }

  Customer.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phoneNumber = map['phoneNumber'];
    finalAmount = map['finalAmount'];
  }
}

class CustomerAmount {
  int? id = null;
  late int? customerId;
  late double amount;
  late bool isCredit;
  late String date;
  late String time;
  late String message;

  CustomerAmount(
      {required this.customerId,
      required this.amount,
      required this.isCredit,
      required this.date,
      required this.message,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'amount': amount,
      'isCredit': isCredit == true ? 1 : 0,
      'date': date,
      'time': time,
      'message': message
    };
  }

  CustomerAmount.fromMap(Map<String, dynamic> map) {
    print("Customer Database map$map");
    id = map['id'];
    customerId = map['customerId'];
    amount = map['amount'];
    isCredit = map['isCredit'] == 1;
    date = map['date'];
    time = map['time'];
    message = map['message'];
  }
}

class CustomerMockData {
  /*static List<Customer> getCustomerMockData() {
    */ /*List<Customer> customers = [
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: false, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: false, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: false, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: false, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: false, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: false, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: false, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
      Customer(name: "Vikas Suthar", phoneNumber: "+91-8239379028", finalAmount: -2000, customerAmount: [CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM"),CustomerAmount(amount: 100, isCredit: true, date: "20 Oct 2023", message: "Cash Diya", time: "12:00PM")]),
    ];*/ /*
    return customers;
  }*/
}
