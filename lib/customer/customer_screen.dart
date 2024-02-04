import 'dart:io';

import 'package:easy_khata/firebase/firebase_service.dart';
import 'package:easy_khata/profile/own_profile.dart';
import 'package:easy_khata/util/common_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_khata/database/drift_database/DatabaseDriftHelper.dart';
import 'package:easy_khata/util/Util.dart';
import 'package:easy_khata/util/pdf_api.dart';
import 'package:easy_khata/util/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../donwload_report/PdfScreen.dart';
import '../home/mock_data.dart';

@immutable
class CustomerScreen extends ConsumerStatefulWidget {
  CustomerScreen({super.key, required this.otherUser});

  late OtherUser otherUser;

  @override
  ConsumerState<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends ConsumerState<CustomerScreen> {
  final customerAmount = TextEditingController();
  final customerDescription = TextEditingController();
  String customerDate = Util.dateSelection(DateTime.now());

  /*"${DateTime.now().day} - ${DateTime.now().month} - ${DateTime.now().year}";*/
  String customerTime = Util.timeSelection(
      TimeOfDay.now()); //"${DateTime.now().hour}:${DateTime.now().minute}";

  //late Future<List<CustomerAmount>> amountHistory;
  double finalAmount = 0.0;

  void fetchUserDetails(String userId) {
    setState(() async {
      widget.otherUser = (await FirebaseService.getOtherUser(userId))!;
    });
  }

  Future<void> _addAmountEntryDialog(
      BuildContext context, bool isCredit, Size size) {
    bool isButtonLoading = false;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Add New Entry'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Amount"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLength: 10,
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
                  const Text("Add Date and Time"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectDate(context, setState);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.grey.shade500)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.date_range),
                              Text(" $customerDate")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectTime(context, setState);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.grey.shade500)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.timer_outlined),
                              Text(" $customerTime")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CustomButton(
                      isLoading: isButtonLoading,
                      buttonLabel: "Save",
                      isButtonEnable: true,
                      onTap: () {
                        setState(() {
                          isButtonLoading = true;
                        });
                        FirebaseService.addAmountHistory(
                            widget.otherUser.userId,
                            customerAmount.text,
                            customerDescription.text,
                            isCredit,
                            "qwdqwfdqwe",
                            widget.otherUser
                        ).then((value) {
                          fetchUserDetails(widget.otherUser.userId);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  )
                    /*child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                            onPressed: () {
                              //_addAmountEntry(isCredit);
                              FirebaseService.addAmountHistory(
                                  widget.otherUser.userId,
                                  customerAmount.text,
                                  customerDescription.text,
                                  isCredit,
                                  "qwdqwfdqwe",
                                widget.otherUser
                              ).then((value) {
                                fetchUserDetails(widget.otherUser.userId);
                                Navigator.pop(context);
                              });

                            },
                            child: const Text("Save"))),
                  )*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    //amountHistory = getAmountHistory();
    finalAmountCalculate(widget.otherUser.amountHistory);
    super.initState();
  }

  void finalAmountCalculate(List<AmountHistory>? amountHistory) async {
    setState(() {
      if (amountHistory != null) {
        finalAmount = Util.finalAmountHistoryCalculateNew(amountHistory);
      }
    });
  }

  void sendMessage() async {
    if (Platform.isAndroid) {
      //FOR Android
      String message =
          "Dear Sir/Madam, Your Payment of ₹ $finalAmount is pending at Vikas Suthar (+91 8239379028). Click here to view the details";
      final url =
          Uri.parse('sms:${widget.otherUser.phoneNumber}?body=$message');
      await launchUrl(url);
    } else if (Platform.isIOS) {
      //FOR IOS
      String message =
          "Dear Sir/Madam, Your Payment of ₹ $finalAmount is pending at Vikas Suthar (+91 8239379028). Click here to view the details";
      final url =
          Uri.parse('sms:${widget.otherUser.phoneNumber}?body=$message');
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("There are no app available to send SMS"),
      ));
    }
  }

  void normalCall() async {
    try {
      launchUrl(Uri.parse("tel://${widget.otherUser.phoneNumber}"));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("There are no app available to call"),
      ));
    }
  }

  void sendWhatsappMessage() async {
    String message =
        "Dear Sir/Madam, Your Payment of ₹ $finalAmount is pending at Vikas Suthar (+91 8239379028). Click here to view the details";
    var whatsappUrl = "whatsapp://send?phone=${widget.otherUser.phoneNumber}" +
        "&text=$message";
    try {
      launchUrl(Uri.parse(whatsappUrl));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("There are no app available to send SMS"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: theme.colorScheme.primary,
        title: const Text("Customer Details",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
        actions: [
          PopupMenuButton<int>(
            offset: const Offset(0, 50),
            color: Colors.grey.shade500,
            elevation: 2,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    Text("Delete Customer")
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              /*if (value == 1) {
                setState(() {
                  DatabaseDriftHelper.customerDao
                      ?.deleteCustomer(widget.customer.id);
                  Navigator.pop(context);
                });
              }*/
            },
          )
        ],
      ),
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.width * 0.04),
                topRight: Radius.circular(size.width * 0.04))),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
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
                                  widget.otherUser.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                Text(widget.otherUser.phoneNumber)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      normalCall();
                                    },
                                    icon: const Icon(Icons.call)),
                                /* IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_vert))*/
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        (finalAmount > 0 || finalAmount < 0)
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02,
                                    vertical: size.height * 0.005),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: finalAmount > 0
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "You Will Give",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "₹ $finalAmount",
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ))
                            : const SizedBox(),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02, vertical: 2),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (finalAmount > 0 || finalAmount < 0) {
                                      /*List<CustomerAmount> data =
                                          (await amountHistory)
                                              .reversed
                                              .toList();
                                      File file =
                                          await PdfApi.generateCenteredText(
                                              data, widget.otherUser);

                                      print("File downloaded ${file.path}");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PDFScreen(path: file.path),
                                        ),
                                      );*/
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      (finalAmount > 0 || finalAmount < 0)
                                          ? const Icon(Icons.picture_as_pdf)
                                          : Icon(Icons.picture_as_pdf,
                                              color: Colors.grey.shade400),
                                      (finalAmount > 0 || finalAmount < 0)
                                          ? const Text("Report")
                                          : Text(
                                              "Report",
                                              style: TextStyle(
                                                  color: Colors.grey.shade400),
                                            ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (finalAmount > 0) {
                                      sendWhatsappMessage();
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      finalAmount > 0
                                          ? const Icon(Icons.call)
                                          : Icon(Icons.call,
                                              color: Colors.grey.shade400),
                                      finalAmount > 0
                                          ? const Text("WhatsApp")
                                          : Text(
                                              "WhatsApp",
                                              style: TextStyle(
                                                  color: Colors.grey.shade400),
                                            ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (finalAmount > 0) {
                                      sendMessage();
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      finalAmount > 0
                                          ? const Icon(Icons.sms)
                                          : Icon(Icons.sms,
                                              color: Colors.grey.shade400),
                                      finalAmount > 0
                                          ? const Text("SMS")
                                          : Text(
                                              "SMS",
                                              style: TextStyle(
                                                  color: Colors.grey.shade400),
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        color: theme.colorScheme.secondary.withAlpha(50),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05, vertical: 10),
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
                      customerAmountHistory(context),
                    ],
                  ),
                ],
              ),
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
                        customerAmount.clear();
                        customerDescription.clear();
                        _addAmountEntryDialog(context, false, size);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .1, vertical: 10),
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
                        child: const Text("₹ Debit",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        customerAmount.clear();
                        customerDescription.clear();
                        _addAmountEntryDialog(context, true, size);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .1, vertical: 10),
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
                          "₹ Credit",
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

  Widget customerAmountHistory(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("customer details ${widget.otherUser.amountHistory!.length.toString()}");
    return (widget.otherUser.amountHistory != null ||
            widget.otherUser.amountHistory != [])
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            reverse: true,
            itemCount: widget.otherUser.amountHistory?.length,
            itemBuilder: (BuildContext context, int index) {
              bool? isCredit = widget.otherUser.amountHistory?[index].isCredit;
              return Container(
                color: Theme.of(context).colorScheme.secondary.withAlpha(25),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.01),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget
                                      .otherUser.amountHistory![index].dateTime,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  widget.otherUser.amountHistory![index]
                                      .description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        )),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (isCredit == true)
                                    ? "-"
                                    : "₹ ${widget.otherUser.amountHistory![index].amount}",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                  (isCredit == true)
                                      ? "₹ ${widget.otherUser.amountHistory![index].amount}"
                                      : "-",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider()
                  ],
                ),
              );
            })
        : Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height * .2),
                    SvgPicture.asset(
                      'assets/not_found.svg',
                      semanticsLabel: "Not Found",
                      height: size.height * .2,
                      width: size.width * .2,
                    ),
                    const Text("No amount history found"),
                  ],
                ),
              ),
            ],
          );
  }

  Future<void> getReport() async {
    //final pdf = PdfApi.pdf;

    /* pdf.addPage(Page(
      build: (context) => Center(
        child: Text(text, style: const TextStyle(fontSize: 48)),
      ),
    ) as Page);*/

    /*final file = File('${widget.customer.name}.${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());*/
  }
}
