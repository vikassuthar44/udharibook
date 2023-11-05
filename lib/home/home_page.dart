import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udhari_book/customer/customer_screen.dart';
import 'package:udhari_book/home/mock_data.dart';
import 'package:udhari_book/util/Util.dart';
import 'package:udhari_book/util/theme.dart';

import '../database/drift_database/DatabaseDriftHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //late List<Customer> customerDatas;
  final customerName = TextEditingController();
  final customerPhoneNumber = TextEditingController();

  late Future<List<Customer>> customers;
  late double finalCustomerAmount;
  double finalAmountGet = 0.0;
  double finalAmountGive = 0.0;

  @override
  void initState() {
    //customerDatas = [];//CustomerMockData.getCustomerMockData();
    print("Customer Datas");
    getCustomers();
    //print(customerDatas);
    super.initState();
  }

  FutureOr onGoBack(dynamic value) {
    //refreshData();
    setState(() {
      getCustomers();
    });
  }

  void getCustomers() async {
    customers = DatabaseDriftHelper.customerDao!
        .getAllCustomer(); //DBHelper().getCustomerList();
    finalAmountGetGive(await customers);
    //customerAmount();
  }

  void finalAmountGetGive(List<Customer> customer) async {
    setState(() {
      finalAmountGet = Util.finalAmountCalculateGet(customer);
      finalAmountGive = Util.finalAmountCalculateGive(customer);
    });

    /*final value = Util.finalAmountCalculateGet(customer);
    final microsecond = 4000000/value;
    for(int i = 0; i < value; i++) {
      await Future.delayed(Duration(microseconds: 0001), () {
        setState(() {
          finalAmountGet++;
        });
      });
    }*/
  }

  /*void customerAmount() async {
    (await customers).reversed;
    finalCustomerAmount = Util.finalCustomerAmountCalculate(await customers);
  }*/

  void _addCustomer() {
    setState(() {
      DatabaseDriftHelper.customerDao?.addCustomer(Customer(
          name: customerName.value.text,
          phoneNumber: customerPhoneNumber.value.text,
          finalAmount: 0.0));
      getCustomers();
    });
  }

  Future<void> _dialogBuilder(BuildContext context, Size size) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Customer'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Customer Name"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                maxLength: 25,
                controller: customerName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a Customer Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Customer's Phone Number"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                maxLength: 11,
                controller: customerPhoneNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a Customer Phone Number',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
                    decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                        onPressed: () {
                          if (customerName.value.text.isNotEmpty &&
                              customerPhoneNumber.value.text.isNotEmpty) {
                            _addCustomer();
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Please Fill Details..."),
                            ));
                          }
                        },
                        child: const Text("Add Customer"))),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const DrawerButton(),
        backgroundColor: AppTheme.lightTheme.primaryColor,
        title: Text(widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.white)),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /*Container(
                color: Colors.grey.shade500,
                padding: const EdgeInsets.all(20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Customer's",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                  ],
                ),
              ),*/
          Stack(children: [
            Container(
              height: screenSize.height * 0.05,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text("You Will Get",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text("₹ $finalAmountGet",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.green)),
                      ],
                    ),
                    const VerticalDivider(color: Colors.red),
                    Column(
                      children: [
                        const Text("You Will Give",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text("₹ $finalAmountGive",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.red)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
          //const Divider(),
          Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05, vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Name",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text("Amount",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Customer>>(
                future: customers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final customers = snapshot.data!;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: customers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.grey.shade100,
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerScreen(
                                                    customer:
                                                        customers[index])),
                                      ).then(onGoBack);
                                    },
                                    child: Container(
                                      color: Colors.grey.shade100,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: screenSize.width * 0.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: ListTile(
                                                title:
                                                    Text(customers[index].name),
                                                subtitle: Text(customers[index]
                                                    .phoneNumber),
                                              ),
                                            ),
                                            customers[index].finalAmount > 0
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "₹ ${customers[index].finalAmount}",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      const Text(
                                                        "You Will Get",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ],
                                                  )
                                                : customers[index]
                                                            .finalAmount ==
                                                        0.0
                                                    ? const Text(
                                                        "₹ 0.0",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    : Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "₹ ${customers[index].finalAmount}",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          const Text(
                                                            "You Will Give",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ],
                                                      )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ),
                            );
                          });
                    } else {
                      print("Database no customer found");
                      return Stack(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: screenSize.height * .2),
                                SvgPicture.asset(
                                  'assets/not_found.svg',
                                  semanticsLabel: "Not Found",
                                  height: screenSize.height * .2,
                                  width: screenSize.width * .2,
                                ),
                                const Text("No customer available."),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  } else {
                    print("Database loading");
                    return const Stack(
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                }),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: SizedBox(
          width: 170,
          child: FloatingActionButton(
            isExtended: true,
            onPressed: () {
              customerName.clear();
              customerPhoneNumber.clear();
              _dialogBuilder(context, screenSize);
            },
            tooltip: 'Add Customer',
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add_rounded),
                Text(
                  " Add Customer",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
