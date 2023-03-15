import 'package:flutter/material.dart';
import 'package:wishwell/form_validator.dart';
import 'package:wishwell/shared_preferences.dart';
import 'package:wishwell/client_page.dart';
import 'package:wishwell/client_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});
  @override
  State<ClientScreen> createState() => ClientScreenState();
}

class ClientScreenState extends State<ClientScreen> {
  final FormValidator formValidator = FormValidator();
  final _formKey = GlobalKey<FormBuilderState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late Future<List<Client>> clientsFuture; //NEW

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Client List")),
        body:

            //buildForm(context),
            FutureBuilder<List<Client>>(
          future: AllData.getClientData(context),
          builder: (context, snapshot) {
            final clients = snapshot.data;
            //buildForm(context);
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Some error occurred'));
                } else {
                  return buildClients(clients!);
                }
            }
          },
        ),
      );

  Widget buildClients(List<Client> clients) => ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return Card(
            child: ListTile(
              leading: Text(client.firstName),
              subtitle: Text(client.firstName),
              trailing: const Icon(Icons.arrow_forward_ios),
              isThreeLine: true,
              title: Text(client.lastName),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ClientPage(client: client),
                ));
              },
            ),
          );
        },
      );

  @override
  initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

    super.initState();
    //clientsFuture = getClients();
  }

  Widget saveNameBtn() => ElevatedButton(
        onPressed: () {
          _createClient();
        },
        child: const Text('Create client'),
      );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  final _clientObject = <String, String>{};

  final String firstName = 'firstName';
  final String lastName = 'lastName';

  Widget buildForm(BuildContext context) {
    return FormBuilder(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Client Page'),
              FormBuilderTextField(
                controller: _firstNameController,
                name: firstName,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: FormBuilderValidators.required(),
                onSaved: (val) => _clientObject['firstName'] = val ?? '',
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                controller: _lastNameController,
                name: lastName,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: FormBuilderValidators.required(),
                onSaved: (val) => _clientObject['lastName'] = val ?? '',
              ),
              saveNameBtn(),
            ],
          ),
        ));
  }

  void _createClient() {
    if (_formKey.currentState == null) {
      debugPrint('_formKey.currentState == null');
    } else if (_formKey.currentState!.validate()) {
      // Commit the field values to their variables
      _formKey.currentState!.save();

      // SAVE FORM ENTRIES TO DEVICE USER PREFERENCES
      final dataStore = ({"clients": _clientObject});
      AllData.saveJsonData(dataStore);
      //debugPrint('Details screen create client saved as below');
      debugPrint(dataStore.toString());

      //debugPrint("""
      //The client has registered with an first name of '${_clientObject['firstName']}'
      //and a last name of '${_clientObject['lastName']}'
      // """);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('There are some fields that did not validate')),
      );
    }
  }
}
