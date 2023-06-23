// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';
// import 'package:wishwell/pdf/pdf1.dart';
// //import 'package:wishwell/pdf/resume.dart';
// import 'package:wishwell/provider/asset_provider.dart';
// import 'package:wishwell/provider/client_provider.dart';
// import 'makepdf.dart';
// import 'pdf_client.dart';

// class PdfPreviewClientPage extends StatelessWidget {
//   final ClientProvider pdf;
//   final AssetsProvider assets;
//   final PdfPageFormat pageFormat;
//   const PdfPreviewClientPage(
//       {Key? key,
//       required this.pageFormat,
//       required this.pdf,
//       required this.assets})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     log("pgdffff==> $pdf");
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF Preview'),
//       ),
//       body: PdfPreview(
//         build: (context) => makePdf1(pageFormat,),
//         // build: (context) => generateResume(),
//       ),
//     );
//   }
// }