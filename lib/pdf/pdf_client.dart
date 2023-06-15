import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
//import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:wishwell/pdf/resume.dart';
import 'package:wishwell/provider/asset_provider.dart';

//import 'package:wishwell/document_model.dart';
//import 'package:wishwell/client_model.dart';
import 'package:wishwell/provider/client_provider.dart';
import '../Assets/asset_screen.dart';
//import 'package:provider/provider.dart';

Future<Uint8List> makeClientPdf(
    ClientProvider clientProvider, AssetsProvider assetsProvider) async {
  final pdf = Document();
  final doc = Document(title: 'My Résumé', author: 'David PHAM-VAN');
  // final profileImage = MemoryImage(
  //   (await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List(),
  // );
  final pageTheme = await _myPageTheme(PdfPageFormat.a3);
  pdf.addPage(
    Page(
      build: (context) {
        // log("clientProvider.clientItem ${clientProvider.clientItem}");
        return Column(
          children: [
            Text(
              'BEQUESTS',
              textScaleFactor: 2,
              style: Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // Padding(
            //   child: Text(
            //     "BEQUESTS",
            //     style: Theme.of(context).header2,
            //   ),
            //   padding: const EdgeInsets.all(20),
            // ),
            Text(
              'I will give the persons named below, if he or she survives me, the Property described below:',
              textScaleFactor: 1.2,
              style: Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
            ),
            // Text(
            //     "I will give the persons named below, if he or she survives me, the Property described below:"),
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
                child: Table(
                  border: TableBorder.all(
                    color: PdfColors.black,
                  ),
                  children: [
                    TableRow(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
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
                            ),
                          ),
                          flex: 4,
                        ),
                      ],
                    ),
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
                              child: _UrlText(
                                "\$ ${e['value']}",
                                "",
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    )
                    // TableRow(
                    //   children: [
                    //     Expanded(
                    //       child: PaddedText('Asset Name 1'),
                    //       flex: 1,
                    //     ),
                    //     Expanded(
                    //       child: PaddedText('Type'),
                    //       flex: 1,
                    //     ),
                    //     Expanded(
                    //       child: PaddedText('% Share'),
                    //       flex: 1,
                    //     ),
                    //     Expanded(
                    //       child: PaddedText('\$ Est Value'),
                    //       flex: 1,
                    //     ),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     Expanded(
                    //       child: PaddedText('Asset Name 2'),
                    //       flex: 1,
                    //     ),
                    //     Expanded(
                    //       child: PaddedText('Type'),
                    //       flex: 1,
                    //     ),
                    //     Expanded(
                    //       child: PaddedText('% Share'),
                    //       flex: 1,
                    //     ),
                    //     Expanded(
                    //       child: PaddedText('\$ Est Value'),
                    //       flex: 1,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              );
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

class _Block extends StatelessWidget {
  _Block({
    required this.title,
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
                ]),
          ),
        ]);
  }
}

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
