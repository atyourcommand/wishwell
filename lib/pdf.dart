import 'dart:typed_data';

//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:wishwell/document_model.dart';
//import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
//import 'dart:io';

import 'package:flutter/services.dart';

final docs = <Doc>[
  Doc(
      client: 'David Thomas',
      address: '123 Fake St\r\nBermuda Triangle',
      items: [
        LineItem(
          'Technical Engagement',
          120,
        ),
        LineItem('Deployment Assistance', 200),
        LineItem('Develop Software Solution', 3020.45),
        LineItem('Produce Documentation', 840.50),
      ],
      name: 'Create and deploy software package'),
  Doc(
    client: 'Michael Ambiguous',
    address: '82 Unsure St\r\nBaggle Palace',
    items: [
      LineItem('Professional Advice', 100),
      LineItem('Lunch Bill', 43.55),
      LineItem('Remote Assistance', 50),
    ],
    name: 'Provide remote support after lunch',
  ),
  Doc(
    client: 'Marty McDanceFace',
    address: '55 Dancing Parade\r\nDance Place',
    items: [
      LineItem('Program the robots', 400.50),
      LineItem('Find tasteful dance moves for the robots', 80.55),
      LineItem('General quality assurance', 80),
    ],
    name: 'Create software to teach robots how to dance',
  )
];

Future<Uint8List> makePdf(Doc doc) async {
  final pdf = Document();
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Attention to: ${docs[0].client}"),
                    Text(docs[0].address),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Text(
                    'LOGO GOES HERE',
                    style: Theme.of(context).header4,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'INVOICE FOR PAYMENT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...docs[0].items.map(
                      (e) => TableRow(
                        children: [
                          Expanded(
                            child: PaddedText(e.description),
                            flex: 2,
                          ),
                          Expanded(
                            child: PaddedText("\$${e.cost}"),
                            flex: 1,
                          )
                        ],
                      ),
                    ),
                TableRow(
                  children: [
                    PaddedText('TAX', align: TextAlign.right),
                    PaddedText(
                        '\$${(docs[0].totalCost() * 0.1).toStringAsFixed(2)}'),
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText('TOTAL', align: TextAlign.right),
                    PaddedText(
                        '\$${(docs[0].totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
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
                    PaddedText(
                        '\$${(doc.totalCost() * 1.1).toStringAsFixed(2)}')
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
