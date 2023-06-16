import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
//import 'package:wishwell/pdf/resume.dart';
import 'package:wishwell/provider/asset_provider.dart';
import 'package:wishwell/provider/client_provider.dart';
import 'pdf_client.dart';

class PdfPreviewClientPage extends StatelessWidget {
  final ClientProvider pdf;
  final AssetsProvider assets;
  const PdfPreviewClientPage(
      {Key? key, required this.pdf, required this.assets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("pgdffff==> $pdf");
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) =>
            makeClientPdf(pageFormat, clientProvider, assetsProvider),
        // build: (context) => generateResume(),
      ),
    );
  }
}
