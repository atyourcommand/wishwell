import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wishwell/form_validator.dart';
import 'package:wishwell/provider/client_provider.dart';

class ClientEdit extends StatefulWidget {
  const ClientEdit({
    super.key,
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address1,
    required this.address2,
    required this.city,
    required this.country,
    required this.dob,
  });
  final String clientId;
  final String firstName;
  final String lastName;
  final String gender;
  final String address1;
  final String address2;
  final String city;
  final String country;
  final String dob;

  @override
  State<ClientEdit> createState() => _ClientEditState();
}

class _ClientEditState extends State<ClientEdit> {
  final FormValidator formValidator = FormValidator();

  // ignore: unused_field
  final _formKey = GlobalKey<FormBuilderState>();
  final Map _clientObject = <String, String>{};

  final String firstName = 'firstName';
  final String lastName = 'lastName';
  final String gender = 'gender';
  final String address = 'Address1';
  final String address1 = 'Address2';
  final String city = 'City';
  final String country = 'Country';
  final String dob = 'dob';

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _gender;
  late TextEditingController _address1;
  late TextEditingController _address2;
  late TextEditingController _city;
  late TextEditingController _country;
  late TextEditingController _dob;
  String? _dropDownValue;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _gender = TextEditingController();
    _address1 = TextEditingController();
    _address2 = TextEditingController();
    _city = TextEditingController();
    _country = TextEditingController();
    _dob = TextEditingController();

    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
    _gender.text = widget.gender;
    _address1.text = widget.address1;
    _address2.text = widget.address2;
    _city.text = widget.city;
    _country.text = widget.country;
    _dob.text = widget.dob;
    _dropDownValue = widget.gender;
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gender.dispose();
    _address1.dispose();
    _address2.dispose();
    _city.dispose();
    _country.dispose();
    _dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Edit beneficiary',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.grey.shade200,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 1.0, top: 0.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    //=========frist name textFeild========//
                    TextFormField(
                      controller: _firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          ///--- toast
                        }
                        return null;
                      },
                      onSaved: (val) => _clientObject['firstName'] = val ?? '',
                    ),
                    //=========last name textFeild========//
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (value == null && value!.isEmpty) {
                          ///--- toast
                        }
                        return null;
                      },
                      onSaved: (val) => _clientObject['lastName'] = val ?? '',
                    ),
                    //===============Gender =========//
                    const SizedBox(height: 10),
                    DropdownButton(
                        hint: _dropDownValue == null
                            ? const Text('Gender')
                            : Text(
                                _dropDownValue!,
                                style: const TextStyle(color: Colors.black38),
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: const TextStyle(color: Colors.black38),
                        items: [
                          'Male',
                          'Female',
                        ].map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValue = val;
                            },
                          );
                        }),

                    Divider(
                      height: 1,
                      color: Colors.grey.shade700,

                      //  thickness: 10,
                    ),
                    //=========Address  textFeild========//
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      controller: _address1,
                      name: address,
                      decoration: const InputDecoration(labelText: 'Address1'),
                      validator: FormBuilderValidators.required(),
                      onSaved: (val) => _clientObject['lastName'] = val ?? '',
                    ),
                    //=========Address1  textFeild========//
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      controller: _address2,
                      name: address1,
                      decoration: const InputDecoration(labelText: 'Address2'),
                      validator: FormBuilderValidators.required(),
                      onSaved: (val) => _clientObject['lastName'] = val ?? '',
                    ),
                    //=========Address2  textFeild========//
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      controller: _city,
                      name: city,
                      decoration: const InputDecoration(labelText: 'City'),
                      validator: FormBuilderValidators.required(),
                      onSaved: (val) => _clientObject['lastName'] = val ?? '',
                    ),
                    //============city==========//
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      controller: _country,
                      name: country,
                      decoration: const InputDecoration(labelText: 'Country'),
                      validator: FormBuilderValidators.required(),
                      onSaved: (val) => _clientObject['lastName'] = val ?? '',
                    ),
                    //============country=============//
                    // FormBuilderTextField(
                    //   controller: _dob,
                    //   name: dob,
                    //   decoration: const InputDecoration(labelText: 'Date of Birth'),
                    //   validator: FormBuilderValidators.required(),
                    //   onSaved: (val) => _clientObject['lastName'] = val ?? '',
                    // ),

                    //============Date of birth=============//
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      controller: _dob,
                      name: lastName,
                      decoration:
                          const InputDecoration(labelText: 'Date of Birth'),
                      validator: FormBuilderValidators.required(),
                      //onSaved: (val) => _clientObject['lastName'] = val ?? '',
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          debugPrint(pickedDate.toString());
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            _dob.text = formattedDate
                                .toString(); //set output date to TextField value.
                          });
                        } else {
                          debugPrint("===============working data");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        if (validateForm()) {
                          clientProvider.updateFirstName(
                              widget.clientId, _firstNameController.text);
                          clientProvider.updateLastName(
                              widget.clientId, _lastNameController.text);
                          clientProvider.updateGender(
                              widget.clientId, _dropDownValue.toString());
                          clientProvider.updateAddress1(
                              widget.clientId, _address1.text);
                          clientProvider.updateAddress2(
                              widget.clientId, _address2.text);
                          clientProvider.updateCity(
                              widget.clientId, _city.text);
                          clientProvider.updateCountry(
                              widget.clientId, _country.text);
                          clientProvider.updateDob(widget.clientId, _dob.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Client updated successfully',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => const ClientScreen(),
                          // ));
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        }
                      },
                      child: const Text('Save changes'),
                    )
                    //saveNameBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    if (_firstNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Enter Name',
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
          'Select $gender',
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
