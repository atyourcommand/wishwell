import 'package:flutter/material.dart';
import 'package:wishwell/pdf/pdfview.dart';
import '../document_model.dart';

class DetailPage extends StatelessWidget {
  final Doc doc;
  const DetailPage({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(invoice: doc),
            ),
          );
          // rootBundle.
        },
        child:const Icon(Icons.picture_as_pdf),
      ),
      appBar: AppBar(
        title: Text(doc.name),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Customer',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      doc.client,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: [
                  Text(
                    'Invoice Items',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  ...doc.items.map(
                    (e) => ListTile(
                      title: Text(e.description),
                      trailing: Text(
                        e.cost.toStringAsFixed(2),
                      ),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: Theme.of(context).textTheme.headline4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Total"),
                        Text(
                          doc.totalCost().toStringAsFixed(2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Thanks Ajay for your hard work here! I think we should move onto other parts of the app and bug fix later.
// Please can I ask you to see if you can get the PDF function running on the home page drawer for an hour or so. Then I would like to start a refactored user crud to replace current.
// I have worked out all the fields. If possible can we create a multi page form if possible with around 11 pages.
// The bread crumb at the top may not be required but perhaps just dots as each step on the top.
// . . . . . . . . . . . . . .
// Only the users name would be required at first though we may need to access entire validated boolean later.
// Swipe between all these screens would be a very "nice to have"!
// We want the user to have completed most sections before we let them see a rendered PDF of their will I think. We also want it to be as easy as possible to create a simple will!
// here are the groups of fields
// *The Following groups of fields to have their page.
// first name
// last name
// date of birth (find a more appropriate date selector to cover persons born in the 1900's)
// gender
// address 1
// address 2
// city
// country
// Executor 1 Name (1 text field)
// Executor 1 Address (1 text field)
// Executor 2 Name (1 text field)
// Executor 2 Address (1 text field)
// Guardian 1 Name (1 text field)
// Guardian 1 Address (1 text field)
// Guardian 2 Name (1 text field)
// Guardian 2 Address (1 text field)
// Age of trust (Drop down of years ie [1-30] years)
// Simultaneous Clause (free integer field ie [1-1000] days)
// Cremation (Y/N radio slider)
// if Y
// ashes wishes (text field)
// if N
// funeral & burial wishes (text field)
