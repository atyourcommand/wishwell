import 'dart:developer';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
//import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:wishwell/provider/asset_provider.dart';

//import 'package:wishwell/document_model.dart';
//import 'package:wishwell/client_model.dart';
import 'package:wishwell/provider/client_provider.dart';
//import 'package:provider/provider.dart';

Future<Uint8List> makeClientPdf(
    ClientProvider clientProvider, AssetsProvider assetsProvider) async {
  final pdf = Document();

  pdf.addPage(
    Page(
      build: (context) {
        log("clientProvider.clientItem ${clientProvider.clientItem}");
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
                  border: TableBorder.all(color: PdfColors.black),
                  children: [
                    TableRow(
                      children: [
                        Expanded(
                          child: PaddedText(
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
                            child: PaddedText("\$ ${e['value']}"),
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
