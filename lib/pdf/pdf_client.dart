//import 'dart:developer';
//import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:wishwell/pdf/resume.dart';
import 'package:wishwell/provider/asset_provider.dart';
//import 'package:pdf/src/pdf/page_format.dart';
import 'dart:async';
//import 'package:path_provider/path_provider.dart';
//import 'dart:io';

//import 'package:wishwell/document_model.dart';
//import 'package:wishwell/client_model.dart';
import 'package:wishwell/provider/client_provider.dart';

// String appDocPath = "";
// getPaths() async {
//   Directory appDocDir = await getApplicationDocumentsDirectory();
//   appDocPath = appDocDir.path;
//   // ignore: avoid_print
//   print(appDocPath);
//   //output: /data/user/0/com.example.test/app_flutter
// }

Future<Uint8List> makeClientPdf(PdfPageFormat pageFormat,
    ClientProvider clientProvider, AssetsProvider assetsProvider) async {
  final pdf = pw.Document(title: 'My Will', author: 'JB');
  //final Uint8List fontData = File('wishwell/fonts/arial.ttf').readAsBytesSync();
  //final arial = pw.Font.ttf(fontData.buffer.asByteData());

  // final profileImage = MemoryImage(
  //   (await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List(),
  // );
  // ignore: unused_local_variable
  //_logo = await rootBundle.loadString('assets/logo.svg');
  // _bgShape = await rootBundle.loadString('assets/invoice.svg');
  //final pageTheme = await _myPageTheme(PdfPageFormat.a3);
  pdf.addPage(pw.MultiPage(
    pageTheme: _buildTheme(
        pageFormat,
        // await PdfGoogleFonts.robotoRegular(),
        // await PdfGoogleFonts.robotoBold(),
        // await PdfGoogleFonts.robotoItalic(),
        Font.helvetica(),
        Font.helveticaBold(),
        Font.helveticaOblique()),
    build: (context) => [
      // log("clientProvider.clientItem ${clientProvider.clientItem}");
      Text(
        'BEQUESTS',
        textScaleFactor: 1.2,
        style: Theme.of(context).defaultTextStyle.copyWith(
              fontWeight: FontWeight.normal,
            ),
      ),
      Container(height: 20),
      Text(
        'I will give the persons named below, if he or she survives me, the Property described below:',
        textScaleFactor: 1.0,
        style: Theme.of(context).defaultTextStyle.copyWith(
              fontWeight: FontWeight.normal,
              color: PdfColors.black,
            ),
      ),
      Container(height: 20),
      ...clientProvider.clientItem.map((e) {
        final clientAssets = [];
        for (var element in assetsProvider.clienAssets) {
          for (var share in element.shares) {
            if (share.clientName == e.firstName) {
              clientAssets.add({
                'assetName': element.assetsName,
                'type': element.assetsType,
                'share': share.shareValue,
                'value': element.value * share.shareValue / 100
              });
            }
          }
        }
        return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(0),
                  child: Text(
                      textAlign: TextAlign.left,
                      '${e.firstName}'
                      ' '
                      '${e.lastName}\n'
                      'Friend\n'
                      '${e.address1}'
                      ', '
                      '${e.address2}'
                      ', '
                      '${e.city}'
                      ', '
                      '${e.country}.',
                      style: const pw.TextStyle(fontSize: 14)),
                ),
                Container(height: 20),
                Table(
                  border: TableBorder.all(color: PdfColors.black, width: 1),
                  children: [
                    ...clientAssets.map(
                      (e) => TableRow(
                        children: [
                          Expanded(
                            child: PaddedText(e['assetName']),
                            flex: 1,
                          ),
                          Expanded(
                            child: PaddedText(e['type']),
                            flex: 1,
                          ),
                          Expanded(
                            child: PaddedText(e['share'].toString()),
                            flex: 1,
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(4),
                                child:
                                    PaddedText("\$ ${e['value'].toString()}")),
                            flex: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ));
      }),
      Container(height: 50),
      Padding(
        padding: const EdgeInsets.all(30),
        child: Text(
          'This Will and Testament was prepared for and by <userName>',
          style: Theme.of(context).header5.copyWith(
                fontStyle: FontStyle.normal,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  ));
  return pdf.save();
}

pw.PageTheme _buildTheme(
    PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
  return pw.PageTheme(
    pageFormat: pageFormat,
    theme: pw.ThemeData.withFont(
      base: base,
      bold: bold,
      italic: italic,
    ),
    buildBackground: (context) => pw.FullPage(
      ignoreMargins: true,
      //child: pw.SvgImage(svg: _bgShape!),
    ),
  );
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

// ignore: unused_element
Future<PageTheme> _myPageTheme(PdfPageFormat format) async {
  // final bgShape = await rootBundle.loadString('assets/sugar-skull-1782019.svg');

  format = format.applyMargin(
    left: 2.0 * PdfPageFormat.cm,
    top: 4.0 * PdfPageFormat.cm,
    right: 2.0 * PdfPageFormat.cm,
    bottom: 2.0 * PdfPageFormat.cm,
  );
  return PageTheme(
    pageFormat: format,
    theme: ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (Context context) {
      return FullPage(
        ignoreMargins: true,
        child: Stack(
          children: [
            // Positioned(
            //   child: SvgImage(svg: bgShape),
            //   left: 0,
            //   top: 0,
            // ),
            // Positioned(
            //   child: Transform.rotate(
            //       angle: pi, child: SvgImage(svg: bgShape)),
            //   right: 0,
            //   bottom: 0,
            // ),
          ],
        ),
      );
    },
  );
}

// ignore: unused_element
class _Block extends StatelessWidget {
  _Block({
    required this.title,
    // ignore: unused_element
    this.icon,
  });

  final String title;

  final IconData? icon;

  @override
  Widget build(Context context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 5.5, left: 2, right: 5),
              decoration: const BoxDecoration(
                color: green,
                shape: BoxShape.circle,
              ),
            ),
            Text(title,
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: FontWeight.bold)),
            Spacer(),
            if (icon != null) Icon(icon!, color: lightGreen, size: 18),
          ]),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: green, width: 2),
              ),
            ),
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Lorem(length: 20),
              ],
            ),
          ),
        ]);
  }
}

// ignore: unused_element
class _Category extends StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  Widget build(Context context) {
    return Container(
      decoration: const BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      margin: const EdgeInsets.only(bottom: 10, top: 20),
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}

// ignore: unused_element
class _Percent extends StatelessWidget {
  _Percent({
    required this.size,
    required this.value,
    required this.title,
  });

  final double size;

  final double value;

  final Widget title;

  static const fontSize = 1.2;

  PdfColor get color => green;

  static const backgroundColor = PdfColors.grey300;

  static const strokeWidth = 5.0;

  @override
  Widget build(Context context) {
    final widgets = <Widget>[
      Container(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Text(
                '${(value * 100).round().toInt()}%',
                textScaleFactor: fontSize,
              ),
            ),
            CircularProgressIndicator(
              value: value,
              backgroundColor: backgroundColor,
              color: color,
              strokeWidth: strokeWidth,
            ),
          ],
        ),
      )
    ];

    widgets.add(title);

    return Column(children: widgets);
  }
}

// ignore: unused_element
class _UrlText extends StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  Widget build(Context context) {
    return UrlLink(
      destination: url,
      child: Text(text,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}
