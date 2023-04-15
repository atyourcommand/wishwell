// import 'package:flutter/material.dart';

// class DynamicTextField extends StatefulWidget {
//   const DynamicTextField({Key? key}) : super(key: key);

//   @override
//   State<DynamicTextField> createState() => _DynamicTextFieldState();
// }

// class _DynamicTextFieldState extends State<DynamicTextField> {
//   TextEditingController name = TextEditingController();

// //Tax Date

//   final _formKey = GlobalKey<FormState>();

//   List allTextField = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   List displayTextField = [];
//   int noOfTextField = 1;

//   addTextField() {
//     setState(() {
//       noOfTextField += 1;
//     });
//   }

//   removeTextField() {
//     print("removeTextField");

//     if (noOfTextField > 1) {
//       setState(() {
//         noOfTextField -= 1;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Dynamic Text Field"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: name,
//                   decoration: const InputDecoration(
//                     label: Text("Enter Name"),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Required Name  ';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('Assesment Tax :'),
//                     ElevatedButton(
//                       onPressed: addTextField,
//                       child: const Text('Add'),
//                     ),
//                     ElevatedButton(
//                       onPressed: removeTextField,
//                       child: const Text('Remove'),
//                     ),
//                   ],
//                 ),
//                 for (int i = 0; i < noOfTextField; i++) const TextField(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         List finalDynamicTextFieldValue = [];

//                         if (displayTextField.isNotEmpty) {
//                           for (int i = 0; i < displayTextField.length; i++) {
//                             TextEditingController taxValue =
//                                 displayTextField[i]['value'];

//                             Map dummyMap = {
//                               "${displayTextField[i]['keyforbackend']}":
//                                   taxValue.text
//                             };
//                             print(dummyMap);
//                             finalDynamicTextFieldValue.add(dummyMap);
//                           }
//                         }

//                         Map requiredFormDataForBackend = {
//                           'name': name.text,
//                           "tax": finalDynamicTextFieldValue
//                         };
//                         print("Final Data $requiredFormDataForBackend");
//                       }
//                     },
//                     child: const Text("Submit Data"))
//               ],
//             )),
//       ),
//     );
//   }
// }
