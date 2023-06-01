import 'dart:developer';
import 'dart:typed_data';
//import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:wishwell/provider/user_provider.dart';

// Future varEmptyMessage(String sd) async {
//   if (sd.isEmpty) {
//     return 'this is empty';
//   } else {
//     return sd;
//   }
// }

Future<Uint8List> makeWillPdf(WillProvider willProvider) async {
  final pdf = Document();
  pdf.addPage(
    Page(
      build: (context) {
        log("willProvider.userItem ${willProvider.userItem}");
        return Column(
          children: [
            ...willProvider.userItem.map(
              (e) => Column(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                          child: Text(
                        "LAST WILL AND TESTAMENT",
                        style: Theme.of(context).header2,
                      )),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 20),
                      child: Text(
                        'This Will and Testament was prepared for and by ${e.firstName} ${e.lastName}',
                        style: Theme.of(context).header5.copyWith(
                              fontStyle: FontStyle.normal,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(height: 20),
                  ],
                ),
              ]),
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
/*

Beneficiary 1 (Seperate table)

(Name)
(Relationship)
(Address 1)
(Address 2)
(Country)

Asset 1 (Name of asset) (Type) (Estimated value) (%Share of total)
Asset 2 (Name of asset) (Type) (Estimated value) (%Share of total)
Asset 3 (Name of asset) (Type) (Estimated value) (%Share of total)


-----------

Beneficiary 2 (Seperate table)

(Name)
(Relationship)
(Address 1)
(Address 2)
(Country)


Asset 3 (Name of asset) (Type) (Estimated value) (%Share of total)


-----------

Beneficiary 3 (Seperate table)

(Name)
(Relationship)
(Address 1)
(Address 2)
(Country)

Asset 2 (Name of asset) (Type) (Estimated value) (%Share of total)
Asset 5 (Name of asset) (Type) (Estimated value) (%Share of total)
 */