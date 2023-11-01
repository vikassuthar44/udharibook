import 'package:flutter/material.dart';
import 'package:udhari_book/database/DBHelper.dart';
import 'package:udhari_book/database/drift_database/DatabaseDriftHelper.dart';
import 'package:udhari_book/util/Util.dart';

import '../home/mock_data.dart';

@immutable
class CustomerScreen extends StatefulWidget {
  CustomerScreen({super.key, required this.customer});

  late Customer customer;

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final customerAmount = TextEditingController();
  final customerDescription = TextEditingController();

  late Future<List<CustomerAmount>> amountHistory;
  double finalAmount = 0.0;

  void _addAmountEntry(bool isCredit) async {
    setState(() {
      DatabaseDriftHelper.customerDao?.addCustomerAmount(CustomerAmount(
          customerId: widget.customer.id,
          amount: double.parse(customerAmount.value.text),
          isCredit: isCredit,
          date: "31 Oct 2023",
          message: customerDescription.value.text,
          time: "07:39 PM"));
      amountHistory = getAmountHistory();
      updateCustomer();
      finalAmountCalculate(amountHistory);
    });
    //widget.customer.customerAmount.reversed;
  }

  void updateCustomer() async {
    final sds = await amountHistory;
    setState(() {
      DatabaseDriftHelper.customerDao?.updateCustomer(
          widget.customer.id, Util.finalAmountHistoryCalculate(sds));
    });
  }

  Future<void> _addAmountEntryDialog(BuildContext context, bool isCredit) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Entry'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Amount"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: customerAmount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Amount',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Add Description"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: customerDescription,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Description',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextButton(
                      onPressed: () {
                        _addAmountEntry(isCredit);
                        Navigator.pop(context);
                      },
                      child: const Text("Save")))
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    amountHistory = getAmountHistory();
    finalAmountCalculate(amountHistory);
    super.initState();
  }

  Future<List<CustomerAmount>> getAmountHistory() async {
    return DatabaseDriftHelper.customerDao!.getCustomerAmountHistory(widget
        .customer
        .id); //DBHelper().getCustomerAmountHistory(widget.customer.id);
  }

  void finalAmountCalculate(Future<List<CustomerAmount>> customerAmount) async {
    List<CustomerAmount> dsww = await customerAmount;
    setState(() {
      finalAmount = Util.finalAmountHistoryCalculate(dsww);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Customer Details",
            style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                finalAmount > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "You Will Get",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "₹ $finalAmount",
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "You Will Give",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "₹ $finalAmount",
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
              ],
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.customer.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                              Text(widget.customer.phoneNumber)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.call)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_vert))
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: size.height * .01,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            )),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.picture_as_pdf),
                                  Text("Report")
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [Icon(Icons.call), Text("WhatsApp")],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [Icon(Icons.sms), Text("SMS")],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.shade500,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05, vertical: 20),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text("ENTRIES",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Debit",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text("Credit",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      FutureBuilder(
                          future: amountHistory,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                final amounthistory = snapshot.data;
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: amounthistory!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool isCredit =
                                          amounthistory[index].isCredit;
                                      return Container(
                                        color: Colors.grey.shade300,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05,
                                            vertical: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${amounthistory[index].date} : ${amounthistory[index].time}",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          amounthistory[index]
                                                              .message,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        (isCredit == true)
                                                            ? "-"
                                                            : "₹ ${amounthistory[index].amount}",
                                                        style: const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                          (isCredit == true)
                                                              ? "₹ ${amounthistory[index].amount}"
                                                              : "-",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                return const Center(
                                  child: Text("No amount history found"),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _addAmountEntryDialog(context, false);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: const Text("Debit",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _addAmountEntryDialog(context, true);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: const Text(
                          "Credit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
