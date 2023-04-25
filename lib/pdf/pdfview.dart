import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:wishwell/document_model.dart';
import 'makepdf.dart';

class PdfPreviewPage extends StatelessWidget {
  final Doc invoice;
  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
      ),
    );
  }
}
