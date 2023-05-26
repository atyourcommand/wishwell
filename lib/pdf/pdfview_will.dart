import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:wishwell/pdf/pdf_will.dart';
import 'package:wishwell/provider/user_provider.dart';

class PdfPreviewWillPage extends StatelessWidget {
  final WillProvider pdf;
  const PdfPreviewWillPage({Key? key, required this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("pgdffff==> $pdf");
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makeWillPdf(pdf),
      ),
    );
  }
}
