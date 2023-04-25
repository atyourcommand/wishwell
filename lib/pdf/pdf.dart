// import 'package:flutter/material.dart';
// import 'package:wishwell/client_model.dart';
// import 'package:wishwell/document_model.dart';
// import 'package:wishwell/pdf/detail_page.dart';

// class PdfView extends StatefulWidget {
//  const PdfView({super.key});

//   @override
//   State<PdfView> createState() => _PdfViewState();
// }

// class _PdfViewState extends State<PdfView> {
// // final Client client ;
 

//   Client? client;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Invoices'),
//       ),
//       body: ListView(
//         children: [
//           ...docs.map(
//             (e) => ListTile(
//               title: Text(e.name),
//               subtitle: Text(e.name),
//               trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (builder) => DetailPage(doc: e),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       // body: ListView.builder(
//       //   itemBuilder: (context, index) => ListTile(
//       //     title: Text(client?.firstName.toString() ?? ""),
//       //     subtitle: Text(client?.firstName.toString() ?? ""),
//       //     trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
//       //     onTap: () {
//       //       Navigator.of(context).push(
//       //         MaterialPageRoute(
//       //           builder: (builder) => DetailPage(doc: client),
//       //         ),
//       //       );
//       //     },
//       //   ),
//       // ),
//     );
//   }
// }
