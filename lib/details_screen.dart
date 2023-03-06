import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:wishwell/components/text_field.dart';
import 'package:wishwell/form_validator.dart';
import 'package:wishwell/shared_preferences.dart';
import 'package:wishwell/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});
  @override
  State<DetailsScreen> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  // ignore: unused_field
  final FormValidator formValidator = FormValidator();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  //late bool _validate = false;
  clearSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  // Or try await prefs.remove('object name');

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

    super.initState();

    focusNode.addListener(() {
      //debugPrint('1:  ${focusNode.hasFocus}');
    });
    // LOAD DATA TO FORM ON PAGE LOAD
    UserData.getStartingData().then((val) {
      var sData = UserModel.fromMap(jsonDecode(val.toString()));
      //debugPrint('Default First Name: ${(sData.firstName.toString())}');
      //debugPrint('Default Last Name: ${(sData.lastName.toString())}');
      _firstNameController.text = sData.firstName.toString();
      _lastNameController.text = sData.lastName.toString();
    });

    _firstNameController.addListener(() async {
      //debugPrint('1:  ${focusNode.hasFocus}');
    });
    _lastNameController.addListener(() async {
      //debugPrint('2s:  ${focusNode.hasFocus}');
    });
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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  final _userObject = <String, String>{};
  final FocusNode _firstNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
        //appBar: AppBar(
        //  title: const Text('My Details'),
        //),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TF(
                onSaved: (val) => _userObject['firstName'] = val ?? '',
                controller: _firstNameController,
                hintText: 'First Name',
                suffix: GestureDetector(
                    onTap: () {
                      _firstNameController.clear();
                    },
                    child: const Icon(Icons.clear)),
                autoFocus: true,
                focusNode: _firstNameFocusNode,
              ),
              const SizedBox(height: 10),
              TF(
                focusNode: focusNode,
                onSaved: (val) => _userObject['lastName'] = val ?? '',
                controller: _lastNameController,
                hintText: 'Last Name',
                suffix: GestureDetector(
                    onTap: () {
                      _lastNameController.clear();
                    },
                    child: const Icon(Icons.clear)),
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

    if (key.currentState == null) {
      debugPrint('key.currentState == null');
    } else if (key.currentState!.validate()) {
      // Commit the field values to their variables
      key.currentState!.save();

      // SAVE FORM ENTRIES TO DEVICE USER PREFERENCES
      final dataStore = _userObject;
      UserData.saveJsonData(dataStore);
      debugPrint('Details screen create user saved as below');
      debugPrint(_userObject.toString());

      //debugPrint("""
      //The user has registered with an first name of '${_userObject['firstName']}'
      //and a last name of '${_userObject['lastName']}'
      // """);

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
