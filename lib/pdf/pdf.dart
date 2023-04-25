import 'package:flutter/material.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/document_model.dart';
import 'package:wishwell/pdf/detail_page.dart';

class PdfView extends StatefulWidget {
  PdfView({super.key});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
// final Client client ;
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

  Client? client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      // body: ListView(
      //   children: [
      //     ...client.map(
      //       (e) => ListTile(
      //         title: Text(e.name),
      //         subtitle: Text(e.name),
      //         trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
      //         onTap: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (builder) => DetailPage(doc: e),
      //             ),
      //           );
      //         },
      //       ),
      //     )
      //   ],
      // ),
      // body: ListView.builder(
      //   itemBuilder: (context, index) => ListTile(
      //     title: Text(client?.firstName.toString() ?? ""),
      //     subtitle: Text(client?.firstName.toString() ?? ""),
      //     trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
      //     onTap: () {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (builder) => DetailPage(doc: client),
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
