//import 'dart:convert';
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

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
  List<Client>? client;
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

      _shareValues.add(Share(clientName: null, shareValue: 0.0));
      dropdoen.add(null);
    });
  }

  removeTextField() {
    debugPrint("removeTextField");

    if (noOfTextField > 1) {
      setState(() {
        noOfTextField -= 1;

        dropdoen.removeLast();
        _shareValues.removeLast();
      });
    }
  }

  convertPrice() {}

  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
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
  double number = 0.0;

  double max = 1.0;
  List<TextEditingController> controllers = List.generate(
    list.length,
    (int i) => TextEditingController(),
  );
  List<String?> dropdoen = [null];
  final List<Share> _shareValues = [Share(clientName: null, shareValue: 0.0)];
  List<Step> stepList() {
    double value = double.tryParse(_valueController.text) ?? 0.0;
    double _remainingValue = value;
    for (var element in _shareValues) {
      _remainingValue -= element.shareValue * value / 100;
    }
    log(_remainingValue.toString());
    return [
      Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
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
              // for (int i = 0; i < noOfTextField; i++)
              //   Container(
              //     height: 50,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.grey,
              //       ),
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: DropdownButton<String>(
              //         isExpanded: true,
              //         value: _shareValues[i].clientName,
              //         icon: const Icon(
              //           Icons.arrow_downward,
              //           color: Colors.black,
              //         ),
              //         elevation: 16,
              //         style: const TextStyle(
              //           color: Colors.black,
              //         ),
              //         onChanged: (String? value) {
              //           // This is called when the user selects an item.
              //           if (value != null) {
              //             setState(() {
              //               _shareValues[i].clientName = value;
              //             });
              //           }
              //         },
              //         items: list.map<DropdownMenuItem<String>>((value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(value),
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //   ),
              // const SizedBox(
              //   height: 10,
              // ),
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
                decoration: InputDecoration(
                  prefixText: _currency,
                  border: OutlineInputBorder(),
                  labelText: 'Enter Assets Value',
                ),
                validator: (value) {
                  if (value == null && value!.isEmpty) {
                    ///--- toast
                  }
                  return null;
                },
              ),
            ],
          )),
      Step(
        state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Shares'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Icon(
              Icons.home,
              size: 40,
            ),
            Text(
              _lastNameController.text,
              style: const TextStyle(
                fontSize: 28,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            Text(
              "\$${_valueController.text}",
              style: const TextStyle(
                fontSize: 28,
                color: Color.fromARGB(255, 114, 114, 114),
              ),
            ),
            const SizedBox(
              height: 30,
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
                              items:
                                  list.map<DropdownMenuItem<String>>((value) {
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
                    Text(
                      "${_shareValues[i].shareValue.toString()}%",
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 114, 114, 114)),
                    ),
                    // Slider(
                    //   value: _shareValues[i].shareValue,
                    //   min: 0.0,
                    //   max: noOfTextField == 0 ? 50.0 : 100.0,
                    //   divisions: 10,
                    //   label: ' ${_shareValues[i].shareValue.round()}',
                    //   onChanged: (double value) {
                    //     setState(() {
                    //       _shareValues[i].shareValue = value;
                    //       final share = _shareValues[i].shareValue *
                    //           double.parse(_valueController.text) /
                    //           100;
                    //       controllers[i].text = share.toString();
                    //       double deduxtMax = max -
                    //           double.parse(
                    //               _shareValues[i].shareValue.toString());
                    //       log("deductmax ${deduxtMax}");
                    //     });
                    //   },
                    // ),
                    Slider(
                      min: 0,
                      max: 100,
                      divisions: 10,
                      value: _shareValues[i].shareValue,
                      onChanged: (value) {
                        if (value < _shareValues[i].shareValue) {
                          setState(() {
                            _shareValues[i].shareValue = value;
                          });
                        }
                        if (_remainingValue > 0) {
                          setState(() {
                            _shareValues[i].shareValue = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
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
                  Text('Assets type : ${_firstNameController.text}'),
                  Text('assets name : ${_lastNameController.text}'),
                  Text('Value : ${_valueController.text}'),
                  Text('Client name : ${_shareValues[i].clientName}'),
                  Text('Assets % : ${_shareValues[i].shareValue}'),
                ],
              ),
          ],
        ),
      ),
    ];
  }

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
                await assetsProvider.insertAssets(
                  _firstNameController.text,
                  _lastNameController.text,
                  double.parse(_valueController.text),
                  _shareValues,
                );

                log("data ${_shareValues.toString()}");

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Client added successfully',
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.of(context).pop();
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
      if (_valueController.text.toString().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
            'Enter Asset value',
            textAlign: TextAlign.center,
          )),
        );
        return false;
      }
    } else if (_activeStepIndex == 1) {}
    return true;
  }

  bool validateForm() {
    if (_valueController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter Asset value',
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
