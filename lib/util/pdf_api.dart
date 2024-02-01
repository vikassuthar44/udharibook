import 'dart:io';


import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:easy_khata/home/mock_data.dart';

class PdfApi {
  static final pdf = Document();

  static Future<File> generateCenteredText(
      List<CustomerAmount> amountHistory, Customer customer) async {
    // making a pdf document to store a text and it is provided by pdf pakage
    final pdf = Document();

    // Text is added here in center
    pdf.addPage(Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
              child: Text("-:SHREE GANESHAY NAMAH:-",
                  style: const TextStyle(fontSize: 20))),
          SizedBox(height: 15),
          Center(
              child: Text("Account Statement For ${customer.name}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          Center(
              child: Text("From : 01/10/2023 To : 31/10/2023",
                  style: const TextStyle(fontSize: 16))),
          SizedBox(height: 10),
          Table(
              border: TableBorder.all(),
              columnWidths: {
                0: const FlexColumnWidth(1),
                1: const FlexColumnWidth(3),
                2: const FlexColumnWidth(8),
                3: const FlexColumnWidth(3),
                4: const FlexColumnWidth(3),
                5: const FlexColumnWidth(3),
                6: const FlexColumnWidth(2),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  Text("No.", textAlign: TextAlign.center),
                  Text("Date", textAlign: TextAlign.center),
                  Text("Message", textAlign: TextAlign.center),
                  Text("Credit", textAlign: TextAlign.center),
                  Text("Debit", textAlign: TextAlign.center),
                  Text("Balance", textAlign: TextAlign.center),
                  Text("CrDr", textAlign: TextAlign.center),
                ]),
                for (int i = 0; i < amountHistory.length; i++)
                  TableRow(children: [
                    Text((i+1).toString(), textAlign: TextAlign.center),
                    Text(amountHistory[i].date, textAlign: TextAlign.center),
                    Text(amountHistory[i].message, textAlign: TextAlign.center),
                    Text(amountHistory[i].isCredit == true ? "${amountHistory[i].amount}" : "-", textAlign: TextAlign.center),
                    Text(amountHistory[i].isCredit == true ? "-" : "${amountHistory[i].amount}", textAlign: TextAlign.center),
                    Text("Balance", textAlign: TextAlign.center),
                    Text(amountHistory[i].isCredit == true ? "Cr" : "Dr", textAlign: TextAlign.center),
                  ])
              ])
        ],
      ),
    ));

    // passing the pdf and name of the docoment to make a direcotory in  the internal storage
    return saveDocument(
        name: '${customer.name.replaceAll(" ", "")}.${DateTime.now().microsecondsSinceEpoch}.pdf',
        pdf: pdf);
  }

  // it will make a named dircotory in the internal storage and then return to its call
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    // pdf save to the variable called bytes
    final bytes = await pdf.save();

    // here a beautiful pakage  path provider helps us and take dircotory and name of the file  and made a proper file in internal storage
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    // reterning the file to the top most method which is generate centered text.
    return file;
  }

}
