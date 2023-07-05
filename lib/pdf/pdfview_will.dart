import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:wishwell/pdf/pdf_will.dart';
import 'package:wishwell/provider/user_provider.dart';
import 'package:pdf/pdf.dart';

class PdfPreviewWillPage extends StatelessWidget {
  final String metaTitle;
  final WillProvider pdf;
  final PdfPageFormat pageFormat;
  const PdfPreviewWillPage({
    Key? key,
    required this.metaTitle,
    required this.pageFormat,
    required this.pdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("pgdffff==> $pdf");
    return Scaffold(
      appBar: AppBar(
        title: Text(metaTitle),
      ),
      body: PdfPreview(
        build: (context) => makeWillPdf(pageFormat, pdf),
      ),
    );
  }
}
