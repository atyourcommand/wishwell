//import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:provider/provider.dart';
import 'package:wishwell/provider/asset_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:wishwell/client_screen.dart';
//import 'package:wishwell/provider/client_provider.dart';
import '../client_model.dart';
import '../form_validator.dart';

class AssetsAdd extends StatefulWidget {
  const AssetsAdd({super.key});

  @override
  State<AssetsAdd> createState() => _AssetsAddState();
}

class Forbin {
  String? name;
  Forbin({required this.name});
}

List<String> list = <String>[
  'Roy',
  'John',
  'Cornado',
];

class _AssetsAddState extends State<AssetsAdd> {
  //final Map _clientObject = <String, String>{};

  List<Forbin> words = List.empty(growable: true);
  final List<double> _sliderValues = [0];
  final String firstName = 'Type';
  final String lastName = 'Name';
  final String value = 'Value';
  final String address = 'Address1';
  final String address1 = 'Address2';
  final String city = 'City';
  final String country = 'Country';
  final String dob = 'dob';
  List allTextField = [];
  @override
  initState() {
    // initialGetSavedData();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _valueController = TextEditingController();
    _address1 = TextEditingController();
    _address2 = TextEditingController();
    _city = TextEditingController();
    _country = TextEditingController();
    _dob = TextEditingController();
    super.initState();
    //clientsFuture = getClients();
  }

  int noOfTextField = 1;

  addTextField() {
    if (noOfTextField == list.length) {
      return;
    }
    setState(() {
      noOfTextField += 1;
      _sliderValues.add(0);
      _shareValues.add(Share(clientName: null, shareValue: 0.0));
      dropdoen.add(null);
    });
  }

  removeTextField() {
    debugPrint("removeTextField");

    if (noOfTextField > 1) {
      setState(() {
        noOfTextField -= 1;
        _sliderValues.removeLast();
        dropdoen.removeLast();
        _shareValues.removeLast();
      });
    }
  }

  final FormValidator formValidator = FormValidator();

  // ignore: unused_field
  final _formKey = GlobalKey<FormBuilderState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _valueController;
  late TextEditingController _address1;
  late TextEditingController _address2;
  late TextEditingController _city;
  late TextEditingController _country;
  late TextEditingController _dob;
  String? _dropDownValue;
  //
  List<TextEditingController> controllers = List.generate(
    10,
    (int i) => TextEditingController(),
  );
  List<String?> dropdoen = [null];
  final List<Share> _shareValues = [Share(clientName: null, shareValue: 0.0)];
  List<Step> stepList() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text('Assets'),
            content: Column(
              children: [
                const Text(
                  "You can add a person here. Return later to complete all the details in order to prepare your PDF.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                      labelText: 'Enter assets Type',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      ///--- toast
                      return '';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Enter name'),
                  validator: (value) {
                    if (value == null && value!.isEmpty) {
                      ///--- toast
                    }
                    return null;
                  },
                ),
                //===============Gender =========//
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _valueController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Assets Value'),
                  validator: (value) {
                    if (value == null && value!.isEmpty) {
                      ///--- toast
                    }
                    return null;
                  },
                ),
                // DecoratedBox(
                //   decoration: const ShapeDecoration(
                //     shape: RoundedRectangleBorder(
                //       side: BorderSide(
                //           width: 1.0,
                //           style: BorderStyle.solid,
                //           color: Colors.grey),
                //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
                //     ),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(5.0),
                //     child: DropdownButton(
                //         hint: _dropDownValue == null
                //             ? const Text('Value')
                //             : Text(
                //                 _dropDownValue!,
                //                 style: const TextStyle(color: Colors.black38),
                //               ),
                //         isExpanded: true,
                //         iconSize: 30.0,
                //         style: const TextStyle(color: Colors.black38),
                //         items: [
                //           'Male',
                //           'Female',
                //         ].map(
                //           (val) {
                //             return DropdownMenuItem<String>(
                //               value: val,
                //               child: Text(val),
                //             );
                //           },
                //         ).toList(),
                //         onChanged: (val) {
                //           setState(
                //             () {
                //               _dropDownValue = val;
                //             },
                //           );
                //         }),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // FormBuilderTextField(
                //   controller: _dob,
                //   name: lastName,
                //   decoration: const InputDecoration(
                //       border: OutlineInputBorder(), labelText: 'Date of Birth'),
                //   validator: FormBuilderValidators.required(),
                //   onTap: () async {
                //     DateTime? pickedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(1950),
                //         lastDate: DateTime(2100));

                //     if (pickedDate != null) {
                //       debugPrint(pickedDate.toString());
                //       String formattedDate =
                //           DateFormat('yyyy-MM-dd').format(pickedDate);
                //       //formatted date output using intl package =>  2021-03-16
                //       setState(() {
                //         _dob.text = formattedDate
                //             .toString(); //set output date to TextField value.
                //       });
                //     } else {
                //       debugPrint("===============working data");
                //     }
                //   },
                // ),
              ],
            )),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Shares'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              //=========Address  textFeild========//
              for (int i = 0; i < noOfTextField; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: _shareValues[i].clientName,
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.black,
                                ),
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  if (value != null) {
                                    setState(() {
                                      _shareValues[i].clientName = value;
                                    });
                                  }
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: FormBuilderTextField(
                              controller: controllers[i],
                              name: address,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "0",
                              ),
                              validator: FormBuilderValidators.required(),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: _shareValues[i].shareValue,
                        min: 0.0,
                        max: 100.0,
                        divisions: 10,
                        label: ' ${_shareValues[i].shareValue.round()}',
                        onChanged: (double value) {
                          setState(() {
                            _shareValues[i].shareValue = value;
                            controllers[i].text =
                                _shareValues[i].shareValue.toInt().toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              // const SizedBox(height: 10),
              // FormBuilderTextField(
              //   controller: _address1,
              //   name: address,
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(), labelText: 'Address1'),
              //   validator: FormBuilderValidators.required(),
              // ),
              // //=========Address1  textFeild========//
              // const SizedBox(height: 10),
              // FormBuilderTextField(
              //   controller: _address2,
              //   name: address1,
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(), labelText: 'Address2'),
              //   validator: FormBuilderValidators.required(),
              // ),
              // //=========Address2  textFeild========//
              // const SizedBox(height: 10),
              // FormBuilderTextField(
              //   controller: _city,
              //   name: city,
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(), labelText: 'City'),
              //   validator: FormBuilderValidators.required(),
              // ),
              // //============city==========//
              // const SizedBox(height: 10),
              // FormBuilderTextField(
              //   controller: _country,
              //   name: country,
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(), labelText: 'Country'),
              //   validator: FormBuilderValidators.required(),
              // ),
            ],
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Confirm'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < noOfTextField; i++)
                Column(
                  children: [
                    Text('FirstName : ${dropdoen[i]}'),
                    Text('LastName : ${controllers[i].text}'),
                    Text('Value : ${_valueController.text}'),
                    Text('Address1 : ${_address1.text}'),
                    Text('Address2 : ${_address2.text}'),
                    Text('City : ${_city.text}'),
                    Text('Country : ${_country.text}'),
                  ],
                ),
            ],
          ),
        ),
      ];

  int _activeStepIndex = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final assetsProvider = Provider.of<AssetsProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(),
        //title: const Text('My App'),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title:
            // ignore: prefer_const_literals_to_create_immutables

            const Text(
          "Add a Asset",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          elevation: 0.0,
          currentStep: _activeStepIndex,
          type: StepperType.horizontal,
          steps: stepList(),
          onStepContinue: () async {
            final isLastStep = _activeStepIndex == stepList().length - 1;
            _formKey.currentState?.validate();
            bool isDetaildValid = isDetialCompleted();
            if (isDetaildValid) {
              if (isLastStep) {
                // for (int i = 0; i < noOfTextField; i++) {
                //
                // }

                await assetsProvider.insertAssets(
                    _firstNameController.text,
                    _lastNameController.text,
                    double.parse(_valueController.text),
                    _shareValues);

                log("data ${_shareValues.toString()}");
                // log(_sliderValues.toString());
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Client added successfully',
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                // ignore: use_build_context_synchronously
                // Navigator.of(context).pop();
              } else {
                setState(() {
                  _activeStepIndex += 1;
                });
              }
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }
            _activeStepIndex -= 1;
            setState(() {});
          },
          controlsBuilder: (context, details) {
            final isLastStep = _activeStepIndex == stepList().length - 1;
            return Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_activeStepIndex != 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: addTextField,
                            child: const Text('Add More Client'),
                          ),
                        ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (_activeStepIndex != 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: removeTextField,
                            child: const Text('Remove Client'),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      if (_activeStepIndex != 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('BACK'),
                          ),
                        ),
                      if (_activeStepIndex != 0)
                        const SizedBox(
                          width: 12,
                        ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: details.onStepContinue,
                          child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // body: SizedBox(
      //   height: MediaQuery.of(context).size.height,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           const SizedBox(
      //             height: 80,
      //           ),
      //           const Text("Why not,",
      //               style: TextStyle(
      //                 fontSize: 40,
      //                 fontWeight: FontWeight.w300,
      //               )),
      //           const Text(
      //             "add a client.",
      //             style: TextStyle(
      //               fontSize: 40,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 50,
      //           ),
      //           //=========frist name textFeild========//
      //           TextFormField(
      //             controller: _firstNameController,
      //             decoration: const InputDecoration(labelText: 'First Name'),
      //             validator: (value) {
      //               if (value == null && value!.isEmpty) {
      //                 ///--- toast
      //               }
      //               return null;
      //             },
      //             onSaved: (val) => _clientObject['firstName'] = val ?? '',
      //           ),
      //           //=========last name textFeild========//
      //           const SizedBox(height: 10),
      //           TextFormField(
      //             controller: _lastNameController,
      //             decoration: const InputDecoration(labelText: 'Last Name'),
      //             validator: (value) {
      //               if (value == null && value!.isEmpty) {
      //                 ///--- toast
      //               }
      //               return null;
      //             },
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
      //                     _dropDownValue = val;
      //                   },
      //                 );
      //               }),

      //           Divider(
      //             height: 1,
      //             color: Colors.grey.shade700,

      //             //  thickness: 10,
      //           ),
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
      //           //============country=============//
      //           // FormBuilderTextField(
      //           //   controller: _dob,
      //           //   name: dob,
      //           //   decoration: const InputDecoration(labelText: 'Date of Birth'),
      //           //   validator: FormBuilderValidators.required(),
      //           //   onSaved: (val) => _clientObject['lastName'] = val ?? '',
      //           // ),

      //           //============Date of birth=============//
      //           const SizedBox(height: 10),
      //           FormBuilderTextField(
      //             controller: _dob,
      //             name: lastName,
      //             decoration: const InputDecoration(labelText: 'Date of Birth'),
      //             validator: FormBuilderValidators.required(),
      //             onSaved: (val) => _clientObject['lastName'] = val ?? '',
      //             onTap: () async {
      //               DateTime? pickedDate = await showDatePicker(
      //                   context: context,
      //                   initialDate: DateTime.now(),
      //                   firstDate: DateTime(1950),
      //                   lastDate: DateTime(2100));

      //               if (pickedDate != null) {
      //                 debugPrint(pickedDate.toString());
      //                 String formattedDate =
      //                     DateFormat('yyyy-MM-dd').format(pickedDate);
      //                 //formatted date output using intl package =>  2021-03-16
      //                 setState(() {
      //                   _dob.text = formattedDate
      //                       .toString(); //set output date to TextField value.
      //                 });
      //               } else {
      //                 debugPrint("===============working data");
      //               }
      //             },
      //           ),
      //           const SizedBox(
      //             height: 50,
      //           ),
      //           OutlinedButton(
      //             onPressed: () async {
      //               if (validateForm()) {
      //                 await clientProvider.insertData(
      //                   _firstNameController.text,
      //                   _lastNameController.text,
      //                   _dropDownValue.toString(),
      //                   _address1.text,
      //                   _address2.text,
      //                   _city.text,
      //                   _country.text,
      //                   _dob.text,
      //                 );
      //                 _firstNameController.clear();
      //                 _lastNameController.clear();
      //                 _address1.clear();
      //                 _address2.clear();
      //                 _city.clear();
      //                 _country.clear();
      //                 _dob.clear();
      //                 ScaffoldMessenger.of(context).showSnackBar(
      //                   const SnackBar(
      //                     content: Text('client add scuccessfully.'),
      //                     backgroundColor: Colors.green,
      //                   ),
      //                 );
      //                 Navigator.of(context).push(MaterialPageRoute(
      //                   builder: (context) => const ClientScreen(),
      //                 ));
      //               }

      //               // _clientObject['firstName'] =
      //               //     _firstNameController.text.toString().trim();
      //               // _clientObject['lastName'] =
      //               //     _lastNameController.text.toString().trim();
      //               // _clientObject['clientId'] = "1";
      //               // _clientObject['address1'] = _address1.text.toString().trim();
      //               // _clientObject['address2'] = _address2.text.toString().trim();
      //               // _clientObject['city'] = _city.text.toString().trim();
      //               // _clientObject['postcode'] = "";
      //               // _clientObject['country'] = _country.text.toString().trim();
      //               // _clientObject['gender'] = _dropDownValue.toString();
      //               // _clientObject['dob'] = _dob.text.toString().trim();
      //               // storedata();

      //               // _createClient();
      //             },
      //             child: const Text('Create client'),
      //           )
      //           //saveNameBtn(),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  bool isDetialCompleted() {
    if (_activeStepIndex == 0) {
      if (_firstNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
            'Enter asset type',
            textAlign: TextAlign.center,
          )),
        );
        return false;
      }
      if (_lastNameController.text.toString().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
            'Enter asset name',
            textAlign: TextAlign.center,
          )),
        );
        return false;
      }
      // if (_valueController.text.toString().isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //         content: Text(
      //       'Enter value  dewwed',
      //       textAlign: TextAlign.center,
      //     )),
      //   );
      //   return false;
      // }
    } else if (_activeStepIndex == 1) {
      // if (_address1.text.toString().isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //         content: Text(
      //       'Enter address1',
      //       textAlign: TextAlign.center,
      //     )),
      //   );
      //   return false;
      // }

      // if (_address2.text.toString().isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //         content: Text(
      //       'Enter address2',
      //       textAlign: TextAlign.center,
      //     )),
      //   );
      //   return false;
      // }

      // if (_city.text.toString().isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //         content: Text(
      //       'Enter City',
      //       textAlign: TextAlign.center,
      //     )),
      //   );
      //   return false;
      // }

      // if (_country.text.toString().isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //         content: Text(
      //       'Enter Country',
      //       textAlign: TextAlign.center,
      //     )),
      //   );
      //   return false;
      // }
    }
    return true;
  }

  bool validateForm() {
    if (_firstNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter first name',
          textAlign: TextAlign.center,
        )),
      );
      return false;
    }

    if (_lastNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter last name',
          textAlign: TextAlign.center,
        )),
      );
      return false;
    }

    if (_dropDownValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Select $value',
          textAlign: TextAlign.center,
        )),
      );
      return false;
    }

    if (_address1.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter address1',
          textAlign: TextAlign.center,
        )),
      );
      return false;
    }

    if (_address2.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter address2',
          textAlign: TextAlign.center,
        )),
      );
      return false;
    }

    if (_city.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter City',
          textAlign: TextAlign.center,
        )),
      );
      return false;
    }

    if (_country.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter Country',
          textAlign: TextAlign.center,
        )),
      );
      return false;
    }

    if (_dob.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter DOB',
          textAlign: TextAlign.center,
        )),
      );
      return false;
    }

    return true;
  }
}
