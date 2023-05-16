import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserFormPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController userFirstName;
  final TextEditingController userLastName;
  final TextEditingController userDob;
  final TextEditingController userCity;
  final TextEditingController userGender;
  final TextEditingController userCountry;
  const UserFormPage({super.key, 
    required this.formKey,
    required this.userFirstName,
    required this.userLastName,
    required this.userDob,
    required this.userCity,
    required this.userGender,
    required this.userCountry,
  });
  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              const Text("User"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: widget.userFirstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter First Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: widget.userLastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Last Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: widget.userDob,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    debugPrint(pickedDate.toString());
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      widget.userDob.text = formattedDate
                          .toString(); //set output date to TextField value.
                    });
                  } else {
                    debugPrint("===============working data");
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Select Dob';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DecoratedBox(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: DropdownButton(
                      hint: widget.userGender.text.isEmpty
                          ? const Text('Gender')
                          : Text(
                              widget.userGender.text,
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
                            widget.userGender.text = val!;
                          },
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: widget.userCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter City';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: widget.userCountry,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Country';
                  }
                  return null;
                },
              ),

              // Add other fields as required
            ],
          ),
        ),
      ),
    );
  }
}

class ExecutorFormPage extends StatelessWidget {
  final int index;
  final GlobalKey<FormState> formKey;
  final TextEditingController executor1FirstName;
  final TextEditingController executor1LastName;
  final TextEditingController executor1Address1;
  final TextEditingController executor1Address2;
  final TextEditingController executor1City;
  final TextEditingController executor1Country;
  const ExecutorFormPage({
    Key? key,
    required this.index,
    required this.formKey,
    required this.executor1FirstName,
    required this.executor1LastName,
    required this.executor1Address1,
    required this.executor1Address2,
    required this.executor1City,
    required this.executor1Country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Executor $index'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: executor1FirstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter First Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor1LastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Last Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor1Address1,
                decoration: const InputDecoration(
                  labelText: 'Address 1',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address 1';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor1Address2,
                decoration: const InputDecoration(
                  labelText: 'Address 2',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address 2';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor1City,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter City';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor1Country,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Country';
                  }
                  return null;
                },
              ),

              // Add other fields as required
            ],
          ),
        ),
      ),
    );
  }
}

class ExecutorFormPage2 extends StatelessWidget {
  final int index;
  final GlobalKey<FormState> formKey;
  final TextEditingController executor2FirstName;
  final TextEditingController executor2LastName;
  final TextEditingController executor2Address1;
  final TextEditingController executor2Address2;
  final TextEditingController executor2City;
  final TextEditingController executor2Country;
  const ExecutorFormPage2(
      {Key? key,
      required this.index,
      required this.formKey,
      required this.executor2FirstName,
      required this.executor2LastName,
      required this.executor2Address1,
      required this.executor2Address2,
      required this.executor2City,
      required this.executor2Country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Executor $index'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: executor2FirstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter First Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor2LastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Last Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor2Address1,
                decoration: const InputDecoration(
                  labelText: 'Address 1',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address 1';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor2Address2,
                decoration: const InputDecoration(
                  labelText: 'Address 2',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address 2';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor2City,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter City';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: executor2Country,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Country';
                  }
                  return null;
                },
              ),

              // Add other fields as required
            ],
          ),
        ),
      ),
    );
  }
}

class GuardianFormPage extends StatelessWidget {
  final int index;
  final GlobalKey<FormState> formKey;
  final TextEditingController guardian1FirstName;
  final TextEditingController guardian1LastName;
  final TextEditingController guardian1Address1;
  final TextEditingController guardian1Address2;
  final TextEditingController guardian1City;
  final TextEditingController guardian1Country;
  const GuardianFormPage({
    Key? key,
    required this.index,
    required this.formKey,
    required this.guardian1FirstName,
    required this.guardian1LastName,
    required this.guardian1Address1,
    required this.guardian1Address2,
    required this.guardian1City,
    required this.guardian1Country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Guardian $index'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: guardian1FirstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter First Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian1LastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Last Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian1Address1,
                decoration: const InputDecoration(
                  labelText: 'Address 1',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address 1';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian1Address2,
                decoration: const InputDecoration(
                  labelText: 'Address 2',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address 2';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian1City,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter City';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian1Country,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Country';
                  }
                  return null;
                },
              ),

              // Add other fields as required
            ],
          ),
        ),
      ),
    );
  }
}

class GuardianFormPage2 extends StatelessWidget {
  final int index;
  final GlobalKey<FormState> formKey;
  final TextEditingController guardian2FirstName;
  final TextEditingController guardian2LastName;
  final TextEditingController guardian2Address1;
  final TextEditingController guardian2Address2;
  final TextEditingController guardian2City;
  final TextEditingController guardian2Country;
  const GuardianFormPage2({
    Key? key,
    required this.index,
    required this.formKey,
    required this.guardian2FirstName,
    required this.guardian2LastName,
    required this.guardian2Address1,
    required this.guardian2Address2,
    required this.guardian2City,
    required this.guardian2Country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Guardian $index'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: guardian2FirstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter First Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian2LastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Last Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian2Address1,
                decoration: const InputDecoration(
                  labelText: 'Address 1',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address 1';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian2Address2,
                decoration: const InputDecoration(
                  labelText: 'Address 2',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address 2';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian2City,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter City';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: guardian2Country,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Country';
                  }
                  return null;
                },
              ),

              // Add other fields as required
            ],
          ),
        ),
      ),
    );
  }
}

class AgeOfTrustFormPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController ageOfTrust;

  const AgeOfTrustFormPage({
    super.key,
    required this.formKey,
    required this.ageOfTrust,
  });

  @override
  State<AgeOfTrustFormPage> createState() => _AgeOfTrustFormPageState();
}

class _AgeOfTrustFormPageState extends State<AgeOfTrustFormPage> {
  final List<int> yearsList = List.generate(30, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            const Text('Age of Trust'),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                  labelText: 'Select years', border: OutlineInputBorder()),
              value: int.tryParse(
                  widget.ageOfTrust.text), // Set initial value or null
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    widget.ageOfTrust.text = value.toString();
                  });
                }
              },
              items: yearsList.map((int year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isNaN) {
                  return 'Please Select Age';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SimultaneousClauseFormPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController simultaneousClause;

  const SimultaneousClauseFormPage(
      {super.key, required this.formKey, required this.simultaneousClause});

  @override
  State<SimultaneousClauseFormPage> createState() =>
      _SimultaneousClauseFormPageState();
}

class _SimultaneousClauseFormPageState
    extends State<SimultaneousClauseFormPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            const Text('Simultaneous Clause'),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: widget.simultaneousClause,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter the number of days (1-1000)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number of days';
                }
                final int? days = int.tryParse(value);
                if (days == null || days < 1 || days > 1000) {
                  return 'Please enter a number between 1 and 1000';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CremationFormPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cremation;

  const CremationFormPage(
      {super.key, required this.formKey, required this.cremation});
  @override
  // ignore: library_private_types_in_public_api
  _CremationFormPageState createState() => _CremationFormPageState();
}

class _CremationFormPageState extends State<CremationFormPage> {
  String cremationChoice = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            const Text('Cremation'),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Yes',
                  groupValue: cremationChoice,
                  onChanged: (value) {
                    setState(() {
                      cremationChoice = value!;
                    });
                  },
                ),
                const Text('Yes'),
                Radio<String>(
                  value: 'No',
                  groupValue: cremationChoice,
                  onChanged: (value) {
                    setState(() {
                      cremationChoice = value!;
                    });
                  },
                ),
                const Text('No'),
              ],
            ),
            if (cremationChoice == 'Yes')
              TextFormField(
                controller: widget.cremation,
                decoration: const InputDecoration(
                  labelText: 'Ashes Wishes',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Ashes Wishes';
                  }
                  return null;
                },
              ),
            if (cremationChoice == 'No')
              TextFormField(
                controller: widget.cremation,
                decoration: const InputDecoration(
                  labelText: 'Funeral & Burial Wishes',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Funeral & Burial Wishes';
                  }
                  return null;
                },
              ),
          ],
        ),
      ),
    );
  }
}
