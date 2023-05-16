import 'dart:developer';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

//import 'package:wishwell/document_model.dart';
//import 'package:wishwell/client_model.dart';
import 'package:wishwell/provider/client_provider.dart';
//import 'package:provider/provider.dart';

Future<Uint8List> makeClientPdf(ClientProvider clientProvider) async {
  final pdf = Document();
  pdf.addPage(
    Page(
      build: (context) {
        log("clientProvider.clientItem ${clientProvider.clientItem}");
        return Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       children: [
            //         Text("Attention to: ${doc.client}"),
            //         Text(doc.address),
            //       ],
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //     ),
            //     SizedBox(
            //       height: 150,
            //       width: 150,
            //       child: Text(
            //         'LOGO goes here',
            //         style: Theme.of(context).header4,
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            //   ],
            // ),
            Container(height: 50),

            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                // TableRow(
                //   children: [
                //     Padding(
                //       child: Text(
                //         'SOME CLIENTS INFO',
                //         style: Theme.of(context).header4,
                //         textAlign: TextAlign.center,
                //       ),
                //       padding: const EdgeInsets.all(20),
                //     ),
                //   ],
                // ),
                // CAN WE PUT SOME BASIC CLIENT INFO INTO THIS LOOP LIKE LAST NAME PLEASE
                ...clientProvider.clientItem.map(
                  (e) => TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(e.firstName),
                        flex: 2,
                      ),
                      Expanded(
                        child: PaddedText("\$${e.lastName}"),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                // TableRow(
                //   children: [
                //     PaddedText('TAX', align: TextAlign.right),
                //     // PaddedText(
                //     //     '\$${(doc.totalCost() * 0.1).toStringAsFixed(2)}'),
                //   ],
                // ),
                // TableRow(
                //   children: [
                //     PaddedText('TOTAL', align: TextAlign.right),
                //     PaddedText(
                //         '\$${(doc.totalCost() * 1.1).toStringAsFixed(2)}')
                //   ],
                // )
              ],
            ),
            Padding(
              child: Text(
                "THANK YOU FOR YOUR CUSTOM!",
                style: Theme.of(context).header2,
              ),
              padding: const EdgeInsets.all(20),
            ),
            Text(
                "Please forward the below slip to your accounts payable department."),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText('Account Number'),
                    PaddedText(
                      '1234 1234',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Account Name',
                    ),
                    PaddedText(
                      'ADAM FAMILY TRUST',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Total Amount to be Paid',
                    ),
                    // PaddedText(
                    //     '\$${(doc.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
                style: Theme.of(context).header3.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

// ignore: non_constant_identifier_names
Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
