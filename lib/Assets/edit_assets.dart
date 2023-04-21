import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:provider/provider.dart';
import 'package:wishwell/Assets/asset_screen.dart' as aseets;

import 'package:wishwell/form_validator.dart';
import 'package:wishwell/provider/asset_provider.dart';

import '../client_model.dart';

class AssetsEdit extends StatefulWidget {
  const AssetsEdit({
    super.key,
    // required this.assetsId,
    // required this.assetsType,
    // required this.assetsName,
    // required this.assetsValue,
    // required this.clientName,
    // required this.assetsContity,
    required this.asset,
  });
  // final String assetsId;
  // final String assetsType;
  // final String assetsName;
  // final String assetsValue;
  // final String clientName;
  // final String assetsContity;
  final Assets asset;
  @override
  State<AssetsEdit> createState() => _ClientEditState();
}

class _ClientEditState extends State<AssetsEdit> {
  final FormValidator formValidator = FormValidator();
  late Assets _asset;
  // ignore: unused_field
  final _formKey = GlobalKey<FormBuilderState>();

  final String assetsId = 'assetId';
  final String assetsType = 'assetsType';
  final String assetsName = 'assetsName';
  final String assetsValue = 'assetsValue';
  final String clientName = 'clientName';
  final String assetsContity = 'assetsContity';

  late TextEditingController _assetType;
  late TextEditingController _assewtName;
  late TextEditingController _assetValue;
  late TextEditingController _sliderValue;

  List<String> list = <String>[
    'Roy',
    'John',
    'Cornado',
  ];
  List<TextEditingController> controllers = [];
  int noOfTextField = 1;
  String? _dropDownValue;
  List<String?> dropdoen = [null];
  late List<Share> _shareValues;

  @override
  void initState() {
    _asset = widget.asset;
    controllers = List.generate(
      list.length,
      (int i) => TextEditingController(),
    );

    _assetType = TextEditingController();
    _assewtName = TextEditingController();
    _assetValue = TextEditingController();
    _sliderValue = TextEditingController();
    _shareValues = widget.asset.shares;
    _assetType.text = widget.asset.assetsType;
    _assewtName.text = widget.asset.assetsName;
    for (var i = 0; i < _shareValues.length; i++) {
      controllers[i].text = _shareValues[i].shareValue.toString();
    }
    _assetValue.text = widget.asset.value.toString();
    noOfTextField = widget.asset.shares.length;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assetProvider = Provider.of<AssetsProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Edit client',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: Colors.black)),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SizedBox(
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
                  controller: _assetType,
                  decoration: const InputDecoration(labelText: 'Assets type'),
                  validator: (value) {
                    if (value == null && value!.isEmpty) {
                      ///--- toast
                    }
                    return null;
                  },
                ),
                //=========last name textFeild========//
                const SizedBox(height: 10),
                TextFormField(
                  controller: _assewtName,
                  decoration: const InputDecoration(labelText: 'Assets name'),
                  validator: (value) {
                    if (value == null && value!.isEmpty) {
                      ///--- toast
                    }
                    return null;
                  },
                ),
                //===============Gender =========//

                //=========Address  textFeild========//
                const SizedBox(height: 10),

                FormBuilderTextField(
                  controller: _assetValue,
                  name: assetsName,
                  decoration: const InputDecoration(labelText: 'Assets value'),
                  validator: FormBuilderValidators.required(),
                ),
                //=========Address1  textFeild========//
                const SizedBox(height: 10),
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
                                name: "value",
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

                const SizedBox(
                  height: 50,
                ),

                OutlinedButton(
                  onPressed: () async {
                    // assetProvider.updateAssetstype(
                    //     widget.asset.id, _assetType.text);
                    // assetProvider.updateAssetsname(
                    //     widget.asset.id, _assewtName.text);
                    // assetProvider.updateAssetsvalue(
                    //     widget.asset.id, _assetValue.text.toString());
                    // assetProvider.updateClientname(widget.asset.id,
                    //     _shareValues[i].clientName.toString());
                    // assetProvider.updateAssetcontity(
                    //     widget.asset.id, controllers[i].toString());
                    Assets newAsset = Assets(
                        value: double.parse(_assetValue.text),
                        id: _asset.id,
                        shares: _shareValues,
                        assetsType: _assetType.text,
                        assetsName: _assewtName.text);
                    await assetProvider.updateAssetById(newAsset);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Client updated successfully',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => aseets.AssetScreen(),
                    // ));
                    // Navigator.pop(context);
                  },
                  child: const Text('Save changes'),
                )
                // saveNameBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
  // bool validateForm() {
  //   if (_firstNameController.text.toString().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text(
  //         'Enter Name',
  //         textAlign: TextAlign.center,
  //       )),
  //     );
  //     return false;
  //   }

  //   if (_lastNameController.text.toString().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text(
  //         'Enter last name',
  //         textAlign: TextAlign.center,
  //       )),
  //     );
  //     return false;
  //   }

  //   if (_dropDownValue == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //           content: Text(
  //         'Select $_address1',
  //         textAlign: TextAlign.center,
  //       )),
  //     );
  //     return false;
  //   }

  //   if (_address2.text.toString().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text(
  //         'Enter address2',
  //         textAlign: TextAlign.center,
  //       )),
  //     );
  //     return false;
  //   }

  //   if (_address1.text.toString().isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text(
  //         'Enter DOB',
  //         textAlign: TextAlign.center,
  //       )),
  //     );
  //     return false;
  //   }

  //   return true;
  // }
}