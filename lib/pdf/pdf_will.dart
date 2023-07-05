//import 'dart:developer';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:wishwell/provider/user_provider.dart';

// Future varEmptyMessage(String sd) async {
//   if (sd.isEmpty) {
//     return 'this is empty';
//   } else {
//     return sd;
//   }
// }

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
          Font.helvetica(),
          Font.helveticaBold(),
          Font.helveticaOblique()),
      build: (context) => [
        //log("willProvider.userItem ${willProvider.userItem}");
        ...willProvider.userItem.map(
          (e) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Center(
                    child: Text(
                  "LAST WILL AND TESTAMENT",
                  style: Theme.of(context).header2,
                )),
              ),
              Container(height: 20),
              Text(
                  'I, ${e.firstName} ${e.lastName}, born ${e.dob}, a legal adult with an address at ${e.city} ${e.country}, being of competent and sound mind, do hereby declare this to be my last will and testament (hereinafter, "Last Will & Testament") and do hereby revoke any and all wills and codicils heretofore made jointly or severally by me. I further declare that this Last Will & Testament reflects my personal wishes without any undue influence whatsoever.'),
              Container(height: 20),
              Text(
                  'EXECUTOR APPOINTMENT.\nI hereby nominate and appoint ${e.executorFirstName} ${e.executorLastName} an individual with an address at ${e.executorAddress1} ${e.executorAddress2} ${e.executorCity} ${e.executorCountry}, as Executor/Personal Representative of this Last Will & Testament. Should the aforementioned individual be unavailable, unable or unwilling to serve as Executor/Personal Representative when needed, then I nominate and appoint ${e.executor2FirstName} ${e.executor2LastName}, an individual with an address at ${e.executor2Address1} ${e.executor2Address2} ${e.executor2City} ${e.executor2Country}, as the alternate Executor/Personal Representative of this Last Will & Testament. Immediately following my death, the Executor/Personal Representative will be authorized to exercise all provisions of this Last Will & Testament and to use the assets from my estate to make necessary arrangements, without any unnecessary delay, for the payment of personal debts, obligations and funeral expenses.'),
              Container(height: 20),
              Text(
                  'GUARDIAN APPOINTMENT.\nIn the event I am the sole parent or legal guardian of my non-adult children at the time of my death, then I hereby nominate and appoint ${e.guardianFirstName} ${e.guardianLastName}, an individual with an address at ${e.guardianAddress1} ${e.guardianAddress2} ${e.guardianCity} ${e.guardianCountry}, as legal guardian of my children. Should the aforementioned individual be unavailable, unable or unwilling to serve as legal guardian when needed, then I nominate and appoint ${e.guardian2FirstName} ${e.guardian2LastName}, an individual with an address at ${e.guardian2Address1} ${e.guardian2Address2} ${e.guardian2City} ${e.guardian2Country}, as the alternate legal guardian of my children.'),
              Container(height: 20),
              Text('BURIAL OR CREATION WISHES.\n${e.burialWish} '),
              Text(
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'),
              Text(
                  'dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgsdsfgsdfgsdsfgsdfgsdsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs '),
              Text(
                'This Will and Testament was prepared for and by ${e.firstName} ${e.lastName}',
                style: Theme.of(context).header5.copyWith(
                      fontStyle: FontStyle.normal,
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'),
              Text(
                  'dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgsdsfgsdfgsdsfgsdfgsdsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs '),
              Text(
                'This Will and Testament was prepared for and by ${e.firstName} ${e.lastName}',
                style: Theme.of(context).header5.copyWith(
                      fontStyle: FontStyle.normal,
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'),
              Text(
                  'dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgsdsfgsdfgsdsfgsdfgsdsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs dsfgsdfgs '),
              Text(
                'This Will and Testament was prepared for and by ${e.firstName} ${e.lastName}',
                style: Theme.of(context).header5.copyWith(
                      fontStyle: FontStyle.normal,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    ),
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
