import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishwell/nav.dart';
import 'package:wishwell/provider/user_provider.dart';
import 'package:wishwell/swipable_form.dart';
import 'package:wishwell/user_detail_model.dart';

class UserAdd extends StatefulWidget {
  const UserAdd({Key? key, this.index = 0}) : super(key: key);
  final int index;
  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  late final PageController pageController;
  int currentIndex = 0;
  List<GlobalKey<FormState>> formKeys = [];
  List<Widget> formPages = [];
  TextEditingController userFirstName = TextEditingController();
  TextEditingController userLastName = TextEditingController();
  TextEditingController userDob = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userGender = TextEditingController();
  TextEditingController userCountry = TextEditingController();

  TextEditingController executor1FirstName = TextEditingController();
  TextEditingController executor1LastName = TextEditingController();
  TextEditingController executor1Address1 = TextEditingController();
  TextEditingController executor1Address2 = TextEditingController();
  TextEditingController executor1City = TextEditingController();
  TextEditingController executor1Country = TextEditingController();

  TextEditingController executor2FirstName = TextEditingController();
  TextEditingController executor2LastName = TextEditingController();
  TextEditingController executor2Address1 = TextEditingController();
  TextEditingController executor2Address2 = TextEditingController();
  TextEditingController executor2City = TextEditingController();
  TextEditingController executor2Country = TextEditingController();

  TextEditingController guardian1FirstName = TextEditingController();
  TextEditingController guardian1LastName = TextEditingController();
  TextEditingController guardian1Address1 = TextEditingController();
  TextEditingController guardian1Address2 = TextEditingController();
  TextEditingController guardian1City = TextEditingController();
  TextEditingController guardian1Country = TextEditingController();

  TextEditingController guardian2FirstName = TextEditingController();
  TextEditingController guardian2LastName = TextEditingController();
  TextEditingController guardian2Address1 = TextEditingController();
  TextEditingController guardian2Address2 = TextEditingController();
  TextEditingController guardian2City = TextEditingController();
  TextEditingController guardian2Country = TextEditingController();

  TextEditingController ageOfTrust = TextEditingController();

  TextEditingController simultaneousClause = TextEditingController();

  TextEditingController cremation = TextEditingController();
  List<bool> validationBools = [];
  bool _isLoading = false;
  bool radioValue = true;
  getWill() async {
    setState(() {
      _isLoading = true;
    });
    await context.read<WillProvider>().selectData();
    if (!mounted) {}
    final user = context.read<WillProvider>().userItem.first;
    userFirstName.text = user.firstName;
    userLastName.text = user.lastName;
    userDob.text = user.dob;
    userCity.text = user.city;
    userGender.text = user.gender;
    userCountry.text = user.country;
    executor1FirstName.text = user.executorFirstName;
    executor1LastName.text = user.executorLastName;
    executor1Address1.text = user.executorAddress1;
    executor1Address2.text = user.executorAddress2;
    executor1City.text = user.executorCity;
    executor1Country.text = user.executorCountry;
    executor2FirstName.text = user.executor2FirstName;
    executor2LastName.text = user.executor2LastName;
    executor2Address1.text = user.executor2Address1;
    executor2Address2.text = user.executor2Address2;
    executor2City.text = user.executor2City;
    executor2Country.text = user.executor2Country;
    guardian1FirstName.text = user.guardianFirstName;
    guardian1LastName.text = user.guardianLastName;
    guardian1Address1.text = user.guardianAddress1;
    guardian1Address2.text = user.guardianAddress2;
    guardian1City.text = user.guardianCity;
    guardian1Country.text = user.guardianCountry;
    guardian2FirstName.text = user.guardian2FirstName;
    guardian2LastName.text = user.guardian2LastName;
    guardian2Address1.text = user.guardian2Address1;
    guardian2Address2.text = user.guardian2Address2;
    guardian2City.text = user.guardian2City;
    guardian2Country.text = user.guardian2Country;
    ageOfTrust.text = user.ageOfTrust;
    simultaneousClause.text = user.days;
    cremation.text = user.burialWish;
    formPages = [
      // UserFormPage(
      //   formKey: formKeys[0], userFirstName: null,
      // ),
      UserFormPage(
        formKey: formKeys[0],
        userFirstName: userFirstName,
        userLastName: userLastName,
        userDob: userDob,
        userCity: userCity,
        userGender: userGender,
        userCountry: userCountry,
      ),
      // ExecutorFormPage(index: 1, formKey: formKeys[1]),
      ExecutorFormPage(
        index: 1,
        formKey: formKeys[1],
        executor1FirstName: executor1FirstName,
        executor1LastName: executor1LastName,
        executor1Address1: executor1Address1,
        executor1Address2: executor1Address2,
        executor1City: executor1City,
        executor1Country: executor1Country,
      ),
      // ExecutorFormPage2(index: 2, formKey: formKeys[2]),
      ExecutorFormPage2(
        index: 2,
        formKey: formKeys[2],
        executor2FirstName: executor2FirstName,
        executor2LastName: executor2LastName,
        executor2Address1: executor2Address1,
        executor2Address2: executor2Address2,
        executor2City: executor2City,
        executor2Country: executor2Country,
      ),
      // GuardianFormPage(index: 1, formKey: formKeys[3]),
      GuardianFormPage(
        index: 1,
        formKey: formKeys[3],
        guardian1FirstName: guardian1FirstName,
        guardian1LastName: guardian1LastName,
        guardian1Address1: guardian1Address1,
        guardian1Address2: guardian1Address2,
        guardian1City: guardian1City,
        guardian1Country: guardian1Country,
      ),

      // GuardianFormPage2(index: 2, formKey: formKeys[4]),
      GuardianFormPage2(
        index: 2,
        formKey: formKeys[4],
        guardian2FirstName: guardian2FirstName,
        guardian2LastName: guardian2LastName,
        guardian2Address1: guardian2Address1,
        guardian2Address2: guardian2Address2,
        guardian2City: guardian2City,
        guardian2Country: guardian2Country,
      ),
      AgeOfTrustFormPage(
        formKey: formKeys[5],
        ageOfTrust: ageOfTrust,
      ),
      SimultaneousClauseFormPage(
        formKey: formKeys[6],
        simultaneousClause: simultaneousClause,
      ),
      CremationFormPage(
        radioValue: user.isCremation,
        onChanged: (value) {
          //print("changed value is $value");
          setState(() {
            radioValue = value;
          });
        },
        formKey: formKeys[7],
        cremation: cremation,
        onTap: () async {
          validationBools[currentIndex] =
              formKeys[currentIndex].currentState!.validate();
          final prefs = await SharedPreferences.getInstance();
          prefs.setStringList('validationBools',
              validationBools.map((e) => e.toString()).toList());

          if (mounted) {
            context.read<WillProvider>().insertData(
                  User(
                    firstName: userFirstName.text,
                    lastName: userLastName.text,
                    dob: userDob.text,
                    gender: userGender.text,
                    city: userCity.text,
                    country: userCountry.text,
                    executorFirstName: executor1FirstName.text,
                    executorLastName: executor1LastName.text,
                    executorAddress1: executor1Address1.text,
                    executorAddress2: executor1Address2.text,
                    executorCity: executor1City.text,
                    executorCountry: executor1Country.text,
                    executor2FirstName: executor2FirstName.text,
                    executor2LastName: executor2LastName.text,
                    executor2Address1: executor2Address1.text,
                    executor2Address2: executor2Address2.text,
                    executor2City: executor2City.text,
                    executor2Country: executor2Country.text,
                    guardianFirstName: guardian1FirstName.text,
                    guardianLastName: guardian1LastName.text,
                    guardianAddress1: guardian1Address1.text,
                    guardianAddress2: guardian1Address2.text,
                    guardianCity: guardian1City.text,
                    guardianCountry: guardian1Country.text,
                    guardian2FirstName: guardian2FirstName.text,
                    guardian2LastName: guardian2LastName.text,
                    guardian2Address1: guardian2Address1.text,
                    guardian2Address2: guardian2Address2.text,
                    guardian2City: guardian2City.text,
                    guardian2Country: guardian2Country.text,
                    ageOfTrust: ageOfTrust.text,
                    days: simultaneousClause.text,
                    isCremation: radioValue,
                    ashesWish: cremation.text,
                    burialWish: cremation.text,
                  ),
                );
          }
          // ignore: unused_local_variable
          final listOfForms = [
            'My Detail',
            'Executor 1',
            'Executor 2',
            'Guardian 1',
            'Guardian 2',
            'Age of Trust',
            'Silmultaneous Clause',
            'Burial/Cremation Wishes',
          ];
          // final validationBools = formKeys.map<bool>(
          //   (e) => e.currentState!.validate(),
          // );
          /*
            1 ✅ My details - complete 
            2 ❌Executor 1 - to be completed 
            3 ❌Executor 2 - to be completed 
            4 ✅ Guardian 1 - complete  
            5 ✅ Guardian 2 - complete 
            6 ❌Age of trust - to be completed 
            7 ❌Simultaneous clause - to be completed 
            8 ✅ Burial/Cremation wishes - complete 
           */
          //debugPrint(validationBools);
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     content: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         for (int i = 0; i < listOfForms.length; i++)
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: InkWell(
          //               onTap: () {
          //                 Navigator.pop(context, i);
          //               },
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Text(
          //                       '${validationBools.elementAt(i) ? '✅' : '❌'} ${listOfForms.elementAt(i)} - ${validationBools.elementAt(i) ? 'complete' : 'needs attention'}'),
          //                   const Divider(
          //                     color: Colors.black,
          //                     height: 2,
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),
          // ).then((value) => );
          if (!mounted) {
            return;
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Nav(index: 1),
              ));
        },
      ),
    ];
    setState(() {
      radioValue = user.isCremation;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    currentIndex = widget.index;
    pageController = PageController(initialPage: currentIndex);
    context.read<WillProvider>().selectData();
    formKeys = List.generate(8, (_) => GlobalKey<FormState>());
    validationBools = List.generate(8, (_) => false);
    getWill();
    // formPages = [
    //   // UserFormPage(
    //   //   formKey: formKeys[0], userFirstName: null,
    //   // ),
    //   UserFormPage(
    //     formKey: formKeys[0],
    //     userFirstName: userFirstName,
    //     userLastName: userLastName,
    //     userDob: userDob,
    //     userCity: userCity,
    //     userGender: userGender,
    //     userCountry: userCountry,
    //   ),
    //   // ExecutorFormPage(index: 1, formKey: formKeys[1]),
    //   ExecutorFormPage(
    //     index: 1,
    //     formKey: formKeys[1],
    //     executor1FirstName: executor1FirstName,
    //     executor1LastName: executor1LastName,
    //     executor1Address1: executor1Address1,
    //     executor1Address2: executor1Address2,
    //     executor1City: executor1City,
    //     executor1Country: executor1Country,
    //   ),
    //   // ExecutorFormPage2(index: 2, formKey: formKeys[2]),
    //   ExecutorFormPage2(
    //     index: 2,
    //     formKey: formKeys[2],
    //     executor2FirstName: executor2FirstName,
    //     executor2LastName: executor2LastName,
    //     executor2Address1: executor2Address1,
    //     executor2Address2: executor2Address2,
    //     executor2City: executor2City,
    //     executor2Country: executor2Country,
    //   ),
    //   // GuardianFormPage(index: 1, formKey: formKeys[3]),
    //   GuardianFormPage(
    //     index: 1,
    //     formKey: formKeys[3],
    //     guardian1FirstName: guardian1FirstName,
    //     guardian1LastName: guardian1LastName,
    //     guardian1Address1: guardian1Address1,
    //     guardian1Address2: guardian1Address2,
    //     guardian1City: guardian1City,
    //     guardian1Country: guardian1Country,
    //   ),

    //   // GuardianFormPage2(index: 2, formKey: formKeys[4]),
    //   GuardianFormPage2(
    //     index: 2,
    //     formKey: formKeys[4],
    //     guardian2FirstName: guardian2FirstName,
    //     guardian2LastName: guardian2LastName,
    //     guardian2Address1: guardian2Address1,
    //     guardian2Address2: guardian2Address2,
    //     guardian2City: guardian2City,
    //     guardian2Country: guardian2Country,
    //   ),
    //   AgeOfTrustFormPage(
    //     formKey: formKeys[5],
    //     ageOfTrust: ageOfTrust,
    //   ),
    //   SimultaneousClauseFormPage(
    //     formKey: formKeys[6],
    //     simultaneousClause: simultaneousClause,
    //   ),
    //   CremationFormPage(
    //     formKey: formKeys[7],
    //     cremation: cremation,
    //   ),
    // ];
    super.initState();
  }

  @override
  void dispose() {
    userLastName.dispose();
    userDob.dispose();
    userCity.dispose();
    userGender.dispose();
    userCountry.dispose();
    executor1FirstName.dispose();
    executor1LastName.dispose();
    executor1Address1.dispose();
    executor1Address2.dispose();
    executor1City.dispose();
    executor1Country.dispose();
    executor2FirstName.dispose();
    executor2LastName.dispose();
    executor2Address1.dispose();
    executor2Address2.dispose();
    executor2City.dispose();
    executor2Country.dispose();
    guardian1FirstName.dispose();
    guardian1LastName.dispose();
    guardian1Address1.dispose();
    guardian1Address2.dispose();
    guardian1City.dispose();
    guardian1Country.dispose();
    guardian2FirstName.dispose();
    guardian2LastName.dispose();
    guardian2Address1.dispose();
    guardian2Address2.dispose();
    guardian2City.dispose();
    guardian2Country.dispose();
    ageOfTrust.dispose();
    simultaneousClause.dispose();
    cremation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details and Wishes'),
        centerTitle: true,
        actions: [
          Center(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text(
                "preview",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Visibility(
        visible: !_isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            DotsIndicator(
              dotsCount: formPages.length,
              position: currentIndex,
              decorator: DotsDecorator(
                activeColor: Colors.blue,
                color: Colors.grey,
                spacing: const EdgeInsets.all(4),
                activeSize: const Size(10, 10),
                size: const Size(8, 8),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (int index) {
                  debugPrint("==========> $currentIndex");
                  validationBools[currentIndex] =
                      formKeys[currentIndex].currentState!.validate();
                  // if (currentIndex < index) {
                  // validationBools[index - 1] =
                  //     formKeys[index - 1].currentState!.validate();
                  // } else {
                  //   validationBools[index] =
                  //       formKeys[index].currentState!.validate();
                  // }
                  setState(() {
                    currentIndex = index;
                  });

                  // if (formKeys[currentIndex].currentState!.validate()) {
                  //   setState(() {
                  //     currentIndex = index;
                  //   });
                  // } else {
                  //   pageController.jumpToPage(currentIndex);
                  // }
                },
                children: formPages,
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     validationBools[currentIndex] =
      //         formKeys[currentIndex].currentState!.validate();
      //     final prefs = await SharedPreferences.getInstance();
      //     prefs.setStringList('validationBools',
      //         validationBools.map((e) => e.toString()).toList());

      //     if (true) {
      //       context.read<WillProvider>().insertData(
      //             User(
      //               firstName: userFirstName.text,
      //               lastName: userLastName.text,
      //               dob: userDob.text,
      //               gender: userGender.text,
      //               city: userCity.text,
      //               country: userCountry.text,
      //               executorFirstName: executor1FirstName.text,
      //               executorLastName: executor1LastName.text,
      //               executorAddress1: executor1Address1.text,
      //               executorAddress2: executor1Address2.text,
      //               executorCity: executor1City.text,
      //               executorCountry: executor1Country.text,
      //               executor2FirstName: executor2FirstName.text,
      //               executor2LastName: executor2LastName.text,
      //               executor2Address1: executor2Address1.text,
      //               executor2Address2: executor2Address2.text,
      //               executor2City: executor2City.text,
      //               executor2Country: executor2Country.text,
      //               guardianFirstName: guardian1FirstName.text,
      //               guardianLastName: guardian1LastName.text,
      //               guardianAddress1: guardian1Address1.text,
      //               guardianAddress2: guardian1Address2.text,
      //               guardianCity: guardian1City.text,
      //               guardianCountry: guardian1Country.text,
      //               guardian2FirstName: guardian2FirstName.text,
      //               guardian2LastName: guardian2LastName.text,
      //               guardian2Address1: guardian2Address1.text,
      //               guardian2Address2: guardian2Address2.text,
      //               guardian2City: guardian2City.text,
      //               guardian2Country: guardian2Country.text,
      //               ageOfTrust: ageOfTrust.text,
      //               days: simultaneousClause.text,
      //               isCremation: true,
      //               ashesWish: cremation.text,
      //               burialWish: cremation.text,
      //             ),
      //           );
      //     }
      //     final listOfForms = [
      //       'My Detail',
      //       'Executor 1',
      //       'Executor 2',
      //       'Guardian 1',
      //       'Guardian 2',
      //       'Age of Trust',
      //       'Silmultaneous Clause',
      //       'Burial/Cremation Wishes',
      //     ];
      //     // final validationBools = formKeys.map<bool>(
      //     //   (e) => e.currentState!.validate(),
      //     // );
      //     /*
      //       1 ✅ My details - complete
      //       2 ❌Executor 1 - to be completed
      //       3 ❌Executor 2 - to be completed
      //       4 ✅ Guardian 1 - complete
      //       5 ✅ Guardian 2 - complete
      //       6 ❌Age of trust - to be completed
      //       7 ❌Simultaneous clause - to be completed
      //       8 ✅ Burial/Cremation wishes - complete
      //      */
      //     //debugPrint(validationBools);
      //     // showDialog(
      //     //   context: context,
      //     //   builder: (context) => AlertDialog(
      //     //     shape: RoundedRectangleBorder(
      //     //       borderRadius: BorderRadius.circular(15),
      //     //     ),
      //     //     content: Column(
      //     //       mainAxisSize: MainAxisSize.min,
      //     //       crossAxisAlignment: CrossAxisAlignment.start,
      //     //       children: [
      //     //         for (int i = 0; i < listOfForms.length; i++)
      //     //           Padding(
      //     //             padding: const EdgeInsets.all(8.0),
      //     //             child: InkWell(
      //     //               onTap: () {
      //     //                 Navigator.pop(context, i);
      //     //               },
      //     //               child: Column(
      //     //                 crossAxisAlignment: CrossAxisAlignment.start,
      //     //                 mainAxisAlignment: MainAxisAlignment.center,
      //     //                 children: [
      //     //                   Text(
      //     //                       '${validationBools.elementAt(i) ? '✅' : '❌'} ${listOfForms.elementAt(i)} - ${validationBools.elementAt(i) ? 'complete' : 'needs attention'}'),
      //     //                   const Divider(
      //     //                     color: Colors.black,
      //     //                     height: 2,
      //     //                   )
      //     //                 ],
      //     //               ),
      //     //             ),
      //     //           ),
      //     //       ],
      //     //     ),
      //     //   ),
      //     // ).then((value) => );
      //     Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => Nav(index: 1),
      //         ));
      //     // if (index != null) {
      //     //   pageController.jumpToPage(index);
      //     //   currentIndex = index;
      //     //   setState(() {});
      //     // }
      //   },
      //   child: const Icon(Icons.done_outline_rounded),
      // ),
    );
  }
}
