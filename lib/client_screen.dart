import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wishwell/client_model.dart';
import 'package:wishwell/provider/client_provider.dart';
import 'package:wishwell/shared_preferences.dart';
import 'package:wishwell/client_detail.dart';
import 'components/nav2.dart';
import 'package:provider/provider.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  State<ClientScreen> createState() => ClientScreenState();
}

class ClientScreenState extends State<ClientScreen> {
  //List<Client> clientList = [];
  // final FormValidator formValidator = FormValidator();
  // final _formKey = GlobalKey<FormBuilderState>();
  // late TextEditingController _firstNameController;
  // late TextEditingController _lastNameController;
  // late TextEditingController _gender;
  // late TextEditingController _address1;
  // late TextEditingController _address2;
  // late TextEditingController _city;
  // late TextEditingController _country;
  // late TextEditingController _dob;
  // String? _dropDownValue;
  // late Future<List<Client>> clientsFuture; //NEW

  @override
  void initState() {
    // AllData.getStartingData().then((value) async {
    //   final body = await json.decode(value);
    //   List<dynamic> clientData = body["clients"];
    //   debugPrint("clientData==> ${clientData[0]['firstName']}");
    //   clientList.clear();
    //   setState(() {
    //     for (int i = 0; i < clientData.length; i++) {
    //       clientList.add(Client(
    //         firstName: clientData[i]['firstName'],
    //         lastName: clientData[i]['lastName'],
    //         clientId: clientData[i]['clientId'],
    //         gender: clientData[i]['gender'],
    //         address1: clientData[i]['address1'],
    //         address2: clientData[i]['address2'],
    //         city: clientData[i]['city'],
    //         dob: clientData[i]['dob'],
    //         //postcode: clientData[i]['postcode'],
    //         country: clientData[i]['country'],
    //       ));
    //     }
    //     // clientList = clientData;
    //   });

    //   debugPrint("value===> ${clientList.length}");
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    // bottomNavigationBar: BottomAppBar(
    //   child: SizedBox(
    //     child: ElevatedButton(
    //       onPressed: () {
    //         Navigator.push(context,
    //             MaterialPageRoute(builder: (context) => const Nav2()));
    //       },
    //       child: const Text("Add another client"),
    //     ),
    //   ),
    // ),
    body: SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text("Clients",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                )),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Nav2()));
              },
              child: const Text('+ Client'),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<ClientProvider>(context, listen: false)
                    .selectData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Consumer<ClientProvider>(
                        builder: (context, clientProvider, child) {
                          return clientProvider.clientItem.isNotEmpty
                              ? ListView.builder(
                              itemCount: clientProvider.clientItem.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    trailing:
                                    const Icon(Icons.arrow_forward_ios),
                                    // isThreeLine: true,
                                    title: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${clientProvider.clientItem[index].firstName} ${clientProvider.clientItem[index].lastName}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     const Text("Name :"),
                                        //     Text(clientProvider
                                        //         .clientItem[index]
                                        //         .firstName),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const Text(" Last Name :"),
                                        //     Text(clientProvider
                                        //         .clientItem[index]
                                        //         .lastName),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const Text("city :"),
                                        //     Text(clientProvider
                                        //         .clientItem[index].city),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const Text("address1 :"),
                                        //     Text(clientProvider
                                        //         .clientItem[index]
                                        //         .address1),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const Text("address2 :"),
                                        //     Text(clientProvider
                                        //         .clientItem[index]
                                        //         .address2),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const Text("country :"),
                                        //     Text(clientProvider
                                        //         .clientItem[index].country),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     const Text("postcode :"),
                                        //     Text(client.postcode),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     Text("DOB :"),
                                        //     Text(client.dob),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => ClientPage(
                                            client: clientProvider
                                                .clientItem[index]),
                                      ));
                                    },
                                  ),
                                );
                              })
                              : const Center(
                            child: Text('No details found!!!'),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
            // buildClients(clientList),
          ],
        ),
      ),
    ),
  );

// @override
// initState() {
//   _firstNameController = TextEditingController();
//   _lastNameController = TextEditingController();
//   _gender = TextEditingController();
//   _address1 = TextEditingController();
//   _address2 = TextEditingController();
//   _city = TextEditingController();
//   _country = TextEditingController();
//   _dob = TextEditingController();
//   super.initState();
//   //clientsFuture = getClients();
// }

// Widget saveNameBtn() => ElevatedButton(
//       onPressed: () {
//         _createClient();
//       },
//       child: const Text('Create client'),
//     );

// @override
// void dispose() {
//   _firstNameController.dispose();
//   _lastNameController.dispose();
//   _gender.dispose();
//   _address1.dispose();
//   _address2.dispose();
//   _city.dispose();
//   _country.dispose();
//   _dob.dispose();
//   super.dispose();
// }

// ignore: unused_field
// final _clientObject = <String, String>{};

// final String firstName = 'firstName';
// final String lastName = 'lastName';
// final String gender = 'Gender';
// final String address = 'Address1';
// final String address1 = 'Address2';
// final String city = 'City';
// final String country = 'Country';
// final String dob = 'Date of Birth';

// Widget buildForm(BuildContext context) {
//   return

// FormBuilder(
//     autovalidateMode: AutovalidateMode.onUserInteraction,
//     key: _formKey,
//     onChanged: () {
//       _formKey.currentState!.save();
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           const Text('Add Client'),

//           //=========frist name textFeild========//
//           FormBuilderTextField(
//             controller: _firstNameController,
//             name: firstName,
//             decoration: const InputDecoration(labelText: 'First Name'),
//             validator: FormBuilderValidators.required(),
//             onSaved: (val) => _clientObject['firstName'] = val ?? '',
//           ),
//           //=========last name textFeild========//
//           const SizedBox(height: 10),
//           FormBuilderTextField(
//             controller: _lastNameController,
//             name: lastName,
//             decoration: const InputDecoration(labelText: 'Last Name'),
//             validator: FormBuilderValidators.required(),
//             onSaved: (val) => _clientObject['lastName'] = val ?? '',
//           ),
//           //===============Gender =========//
//           const SizedBox(height: 10),
//           DropdownButton(
//               hint: _dropDownValue == null
//                   ? const Text('Gender')
//                   : Text(
//                       _dropDownValue!,
//                       style: const TextStyle(color: Colors.black38),
//                     ),
//               isExpanded: true,
//               iconSize: 30.0,
//               style: const TextStyle(color: Colors.black38),
//               items: [
//                 'Male',
//                 'Female',
//               ].map(
//                 (val) {
//                   return DropdownMenuItem<String>(
//                     value: val,
//                     child: Text(val),
//                   );
//                 },
//               ).toList(),
//               onChanged: (val) {
//                 setState(
//                   () {
//                     _dropDownValue = val as String?;
//                   },
//                 );
//               }),
//           //=========Address  textFeild========//
//           const SizedBox(height: 10),
//           FormBuilderTextField(
//             controller: _address1,
//             name: address,
//             decoration: const InputDecoration(labelText: 'Address1'),
//             validator: FormBuilderValidators.required(),
//             onSaved: (val) => _clientObject['lastName'] = val ?? '',
//           ),
//           //=========Address1  textFeild========//
//           const SizedBox(height: 10),
//           FormBuilderTextField(
//             controller: _address2,
//             name: address1,
//             decoration: const InputDecoration(labelText: 'Address2'),
//             validator: FormBuilderValidators.required(),
//             onSaved: (val) => _clientObject['lastName'] = val ?? '',
//           ),
//           //=========Address2  textFeild========//
//           const SizedBox(height: 10),
//           FormBuilderTextField(
//             controller: _city,
//             name: city,
//             decoration: const InputDecoration(labelText: 'City'),
//             validator: FormBuilderValidators.required(),
//             onSaved: (val) => _clientObject['lastName'] = val ?? '',
//           ),
//           //============city==========//
//           const SizedBox(height: 10),
//           FormBuilderTextField(
//             controller: _country,
//             name: country,
//             decoration: const InputDecoration(labelText: 'Country'),
//             validator: FormBuilderValidators.required(),
//             onSaved: (val) => _clientObject['lastName'] = val ?? '',
//           ),
//============country=============//
// FormBuilderTextField(
//   controller: _dob,
//   name: dob,
//   decoration: const InputDecoration(labelText: 'Date of Birth'),
//   validator: FormBuilderValidators.required(),
//   onSaved: (val) => _clientObject['lastName'] = val ?? '',
// ),

//============Date of birth=============//
//  const SizedBox(height: 10)
// FormBuilderTextField(
//   controller: _dob,
//   name: lastName,
//   decoration: const InputDecoration(labelText: 'Date of Birth'),
//   validator: FormBuilderValidators.required(),
//   onSaved: (val) => _clientObject['lastName'] = val ?? '',
//   onTap: () async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1950),
//         lastDate: DateTime(2100));

//     if (pickedDate != null) {
//       print(pickedDate);
//       String formattedDate =
//           DateFormat('yyyy-MM-dd').format(pickedDate);
//       print(
//           formattedDate); //formatted date output using intl package =>  2021-03-16
//       setState(() {
//         _dob.text =
//             formattedDate; //set output date to TextField value.
//       });
//     } else {}
//   },
// ),

//       saveNameBtn(),
//     ],
//   ),
// ));
}




// void _createClient() {
//   if (_formKey.currentState == null) {
//     debugPrint('_formKey.currentState == null');
//   } else if (_formKey.currentState!.validate()) {
//     _formKey.currentState!.save();

//     final dataStore = ({"clients": _clientObject});
//     AllData.saveJsonData(dataStore);
//     debugPrint(dataStore.toString());

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Processing Data')),
//     );
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//           content: Text('There are some fields that did not validate')),
//     );
//   }
// }
//}
