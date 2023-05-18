import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
//import 'package:wishwell/document_model.dart';
import 'package:wishwell/provider/client_provider.dart';
//import 'makepdf.dart';
import 'pdf_client.dart';

class PdfPreviewClientPage extends StatelessWidget {
  final ClientProvider pdf;
  const PdfPreviewClientPage({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("pgdffff==> $pdf");
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makeClientPdf(pdf),
      ),
    );
  }
}
