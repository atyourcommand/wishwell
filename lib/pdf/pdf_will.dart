import 'dart:developer';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:wishwell/provider/user_provider.dart';

Future<Uint8List> makeWillPdf(WillProvider willProvider) async {
  final pdf = Document();
  pdf.addPage(
    Page(
      build: (context) {
        log("willProvider.userItem ${willProvider.userItem}");
        return Column(
          children: [
            Padding(
              child: Text(
                "BEQUESTS",
                style: Theme.of(context).header2,
              ),
              padding: const EdgeInsets.all(20),
            ),
            Text(
                "I will give the persons named below, if he or she survives me, the Property described below:"),
            Container(height: 20),
            ...willProvider.userItem.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Table(
                  border: TableBorder.all(color: PdfColors.black),
                  children: [
                    TableRow(
                      children: [
                        Expanded(
                          child: PaddedText('${e.firstName}'
                              ' '
                              '${e.lastName}\n'
                              'Friend\n'
                              '${e.lastName}'
                              ', '
                              '${e.executorAddress1}'
                              ', '
                              '${e.city}'
                              ', '
                              '${e.country}.'),
                          flex: 4,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Expanded(
                          child: PaddedText('Asset Name 1'),
                          flex: 1,
                        ),
                        Expanded(
                          child: PaddedText('Type'),
                          flex: 1,
                        ),
                        Expanded(
                          child: PaddedText('% Share'),
                          flex: 1,
                        ),
                        Expanded(
                          child: PaddedText('\$ Est Value'),
                          flex: 1,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Expanded(
                          child: PaddedText('Asset Name 2'),
                          flex: 1,
                        ),
                        Expanded(
                          child: PaddedText('Type'),
                          flex: 1,
                        ),
                        Expanded(
                          child: PaddedText('% Share'),
                          flex: 1,
                        ),
                        Expanded(
                          child: PaddedText('\$ Est Value'),
                          flex: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
