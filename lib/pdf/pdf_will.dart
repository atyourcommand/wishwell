//import 'dart:ui';

import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:wishwell/provider/user_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

const baseDarkColor = PdfColors.black;
const baseAccentColor = PdfColors.teal;
const baseGreyColor = PdfColors.grey600;

Future<Uint8List> makeWillPdf(
    PdfPageFormat pageFormat, WillProvider willProvider) async {
  final pdf = pw.Document(title: 'My Will', author: 'JB');

  pdf.addPage(
    pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          // await PdfGoogleFonts.robotoRegular(),
          // await PdfGoogleFonts.robotoBold(),
          // await PdfGoogleFonts.robotoItalic(),
          Font.ttf(await rootBundle.load("fonts/arial.ttf")),
          Font.ttf(await rootBundle.load("fonts/arial.ttf")),
          Font.ttf(await rootBundle.load("fonts/arial.ttf")),
          //Font.helvetica(),
          //Font.helveticaBold(),
          //Font.helveticaOblique()),
        ),
        header: (context) {
          const text = 'LAST WILL AND TESTAMENT';
          return pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 40),
            child: pw.Center(
                child: pw.Text(
              text,
              style: Theme.of(context).header2,
            )),
          );
        },
        build: (context) => [
              //log("willProvider.userItem ${willProvider.userItem}");
              ...willProvider.userItem.map(
                (e) => pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'I, ${e.firstName} ${e.lastName}, born ${DateFormat.yMMMMd().format(DateTime.parse(e.dob))}, a legal adult with an address at ${e.city} ${e.country}, being of competent and sound mind, do hereby declare this to be my last will and testament (hereinafter, "Last Will & Testament") and do hereby revoke any and all wills and codicils heretofore made jointly or severally by me. I further declare that this Last Will & Testament reflects my personal wishes without any undue influence whatsoever.',
                      style: Theme.of(context).paragraphStyle,
                    ),
                    pw.Container(height: 20),
                    pw.Text(
                      'EXECUTOR APPOINTMENT:\n\nI hereby nominate and appoint ${e.executorFirstName} ${e.executorLastName} an individual with an address at ${e.executorAddress1} ${e.executorAddress2} ${e.executorCity} ${e.executorCountry}, as Executor/Personal Representative of this Last Will & Testament. Should the aforementioned individual be unavailable, unable or unwilling to serve as Executor/Personal Representative when needed, then I nominate and appoint ${e.executor2FirstName} ${e.executor2LastName}, an individual with an address at ${e.executor2Address1} ${e.executor2Address2} ${e.executor2City} ${e.executor2Country}, as the alternate Executor/Personal Representative of this Last Will & Testament. Immediately following my death, the Executor/Personal Representative will be authorized to exercise all provisions of this Last Will & Testament and to use the assets from my estate to make necessary arrangements, without any unnecessary delay, for the payment of personal debts, obligations and funeral expenses.',
                      style: Theme.of(context).paragraphStyle,
                    ),
                    pw.Container(height: 20),
                    pw.Text(
                      'GUARDIAN APPOINTMENT:\n\nIn the event I am the sole parent or legal guardian of my non-adult children at the time of my death, then I hereby nominate and appoint ${e.guardianFirstName} ${e.guardianLastName}, an individual with an address at ${e.guardianAddress1} ${e.guardianAddress2} ${e.guardianCity} ${e.guardianCountry}, as legal guardian of my children. Should the aforementioned individual be unavailable, unable or unwilling to serve as legal guardian when needed, then I nominate and appoint ${e.guardian2FirstName} ${e.guardian2LastName}, an individual with an address at ${e.guardian2Address1} ${e.guardian2Address2} ${e.guardian2City} ${e.guardian2Country}, as the alternate legal guardian of my children.',
                      style: Theme.of(context).paragraphStyle,
                    ),
                    pw.Container(height: 20),
                    pw.Text(
                      'SIMULTANEOUS DEATH CLAUSE:\n\nIf my spouse and I shall die under such circumstances that the order of our deaths cannot be readily ascertained, my spouse shall be deemed to have predeceased me. No person, other than my spouse, shall be deemed to have survived me if such person dies within ${e.days} days after my death. This article modifies all provisions of this will accordingly.',
                      style: Theme.of(context).paragraphStyle,
                    ),
                    pw.Container(height: 20),
                    pw.Text(
                      'BURIAL OR CREATION WISHES:\n\n${e.burialWish.isEmpty ? '<MISSING VALUES>' : e.burialWish} ',
                      style: Theme.of(context).paragraphStyle,
                    ),
                    pw.Container(height: 50),
                    pw.Text(
                      'SIGNATURE:\n\n\nI, <TESTATOR>, the within named Testator, have to this my last Will contained on this and the preceding pages, set my hand at the City of __________, in the Commonwealth of Australia, this date:______________. I declare that this instrument is my last Will, that I am of the legal age in this jurisdiction to make a Will, that I am under no constraint or undue influence, and that I sign this Will freely and voluntarily.\n\n\n_____________________',
                      style: Theme.of(context).paragraphStyle,
                    ),
                    pw.Container(height: 20),
                    pw.Text(
                      'WITNESSES:\n\n\nThis instrument was signed on the above written date by asdf, and in our presence the Testator declared this instrument to be their last Will. At the Testator\'s request and in the presence of the Testator, we subscribe our names as witnesses hereto.\n\n\nEach of us observed the signing of this Will by asdf and by each other subscribing we witness and affirm that each signature is the true signature of the person whose name was signed. Each of us is now the age of majority, a competent witness and resides at the address set forth after their name.\n\n\nTo the best of our knowledge, the Testator is of the age of majority or otherwise legally empowered to make a Will, is mentally competent and under no constraint or undue influence.\n\n\n We declare under penalty of perjury under the laws of the Commonwealth of Australia that the foregoing is true and correct this date:_____________, at place:__________, state:_________.\n\n\nSigned by asdf in our presence and then by us in their presence.',
                      style: Theme.of(context).paragraphStyle,
                    ),
                    pw.Container(height: 50),
                    signatory('Witness 1 Signature:', 'Witness 2 Signature:',
                        'Name:', 'Address:', 'Date:', 120),
                  ],
                ),
              )
            ],
        footer: (context) {
          final text_1 = 'Page ${context.pageNumber} of ${context.pagesCount}';
          const text_2 = 'Prepared by JB';
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text_1,
                  style: Theme.of(context).defaultTextStyle,
                  textAlign: TextAlign.left,
                ),
                Text(
                  text_2,
                  style: Theme.of(context).defaultTextStyle,
                  textAlign: TextAlign.right,
                ),
              ]);
        }),
  );
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
pw.Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    pw.Padding(
      padding: const pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        textAlign: align,
      ),
    );

pw.Widget signatory(
  final String text1a,
  final String text1b,
  final String text2,
  final String text3,
  final String text4,
  final double containerWidth, {
  final TextAlign align = TextAlign.right,
}) =>
    pw.Container(
        //color: baseAccentColor,
        child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 0, right: 0),
            child: Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                      //width: 250,
                      padding: const pw.EdgeInsets.only(bottom: 10),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  text1a,
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              )
                            ]),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  text2,
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              )
                            ]),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  text3,
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              )
                            ]),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  '',
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              )
                            ]),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  text4,
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              ),
                            ])
                      ])),
                  pw.Container(
                      //width: 250,
                      padding: const pw.EdgeInsets.only(bottom: 10),
                      child: Column(children: [
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  text1b,
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              )
                            ]),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  text2,
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              )
                            ]),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  text3,
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              )
                            ]),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  '',
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              )
                            ]),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: containerWidth,
                                child: pw.Text(
                                  text4,
                                  textAlign: align,
                                ),
                              ),
                              pw.Container(
                                width: containerWidth,
                                child: Text('________________'),
                              ),
                            ])
                      ])),
                ])));
