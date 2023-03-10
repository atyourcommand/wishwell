import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:wishwell/components/text_field.dart' ;
import 'package:wishwell/form_validator.dart';
import 'package:wishwell/shared_preferences.dart';
import 'package:wishwell/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});
  @override
  State<ClientScreen> createState() => ClientScreenState();
}

class ClientScreenState extends State<ClientScreen> {
  //Map<String, dynamic> userData = UserModel() <String, dynamic>{};

  final FormValidator formValidator = FormValidator();

  final _formKey = GlobalKey<FormBuilderState>();

  clearSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _genderController = TextEditingController();

    // LOAD DATA TO FORM ON PAGE LOAD

    UserData.getStartingData().then((val) {
      // ignore: unused_local_variable
      var sData = UserModel.fromMap(jsonDecode(val.toString()));
      //debugPrint('Default First Name: ${(sData.firstName.toString())}');
      //debugPrint('Default Last Name: ${(sData.lastName.toString())}');
      _firstNameController.text = sData.firstName.toString();
      _lastNameController.text = sData.lastName.toString();
      _genderController.text = sData.gender.toString();
      //var selectedGender = sData.gender.toString()
      debugPrint('EACH TIME loading gender string ${_genderController.text}');
      return sData;
    });

    getSavedGender(def) {
      UserData.getNewStartingData().then((val) {
        var sData = UserModel.fromMap(jsonDecode(val.toString()));
        if (sData.gender == null || sData.gender == '') {
          debugPrint('getting gender default');
          return def;
        } else {
          debugPrint('getting saved gender ${sData.gender}');
          return '${sData.gender}';
        }
      });
    }

    // ignore: unused_local_variable
    var selectedGender = getSavedGender('Male');

    super.initState();
  }

  Widget saveNameBtn() => ElevatedButton(
        //onPressed: () async {
        //  final dataStore = <String, dynamic>{
        //    'firstName': _firstNameController.text,
        //    'lastName': _lastNameController.text,
        //  };
        //  await UserData.saveJsonData(dataStore);
        //  //UserData.getJsonData();
        //},
        onPressed: () {
          _createUser();
        },
        child: const Text('Save data'),
      );
  Widget clearDataBtn() => ElevatedButton(
        onPressed: clearSharedPrefs,
        child: const Text('Add some default data'),
      );

  var genderOptions = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  //bool _ageHasError = false;
  final String firstName = 'firstName';
  final String lastName = 'lastName';
  final String gender = 'gender';
  bool _genderHasError = false;
  //var selectedGender =

  @override
  Widget build(BuildContext context) {
    //debugPrint('ddd');

    //var selectedGender = _genderController.text;

    // ignore: unnecessary_brace_in_string_interps
    debugPrint('ddfgdf ${_genderController.text}');
    return FormBuilder(
        //appBar: AppBar(
        //  title: const Text('My Details'),
        //),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();

          //debugPrint(_formKey.currentState!.value.toString());
        },
        // ignore: prefer_const_literals_to_create_immutables
        // initialValue: {
        //  'gender': 'male',
        //},

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('fig'),
              FormBuilderTextField(
                controller: _firstNameController,
                name: firstName,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                controller: _lastNameController,
                name: lastName,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderDropdown<String>(
                // autovalidate: true,
                //controller: _genderController,

                name: 'gender',
                decoration: InputDecoration(
                  labelText: 'Gender',
                  suffix: _genderHasError
                      ? const Icon(Icons.error)
                      : const Icon(Icons.check),
                  hintText: 'Select Gender',
                ),
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),

                items: genderOptions
                    .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.centerStart,
                          //value: gender,
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                initialValue: 'Male',

                onChanged: (String? val) {
                  setState(() {
                    _genderHasError =
                        !(_formKey.currentState?.fields['gender']?.validate() ??
                            false);
                  });
                },
                valueTransformer: (val) => val?.toString(),
              ),
              saveNameBtn(),
              clearDataBtn(),
            ],
          ),
        ));
  }

  //VALIDATION

  // ignore: unused_element

  void _createUser() {
    // After the first attempt to save, turn on autovalidate to give quicker feedback to the user
    //setState(() => _autovalidate = true); // <-- Add this line

    if (_formKey.currentState == null) {
      //debugPrint('key.currentState == null');
    } else if (_formKey.currentState!.validate()) {
      // Commit the field values to their variables
      _formKey.currentState!.save();

      //debugPrint('{First name: ${_formKey.currentState!.value[firstName]},Last name: ${_formKey.currentState!.value[lastName]},gender: ${_formKey.currentState!.value[genderOptions]}}');

      final dataStore = _formKey.currentState?.value;
      //debugPrint(dataStore.toString());
      UserData.saveJsonData(dataStore);
      //debugPrint('saved');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('There are fields that did not validate')),
      );
    }
  }
}
