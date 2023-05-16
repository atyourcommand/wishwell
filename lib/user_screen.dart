import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:wishwell/swipable_form.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final PageController pageController = PageController();
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

  @override
  void initState() {
    formKeys = List.generate(8, (_) => GlobalKey<FormState>());
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
        formKey: formKeys[7],
        cremation: cremation,
      ),
    ];
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
        title: const Text('Client Form'),
        centerTitle: true,
      ),
      body: Column(
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
                if (formKeys[currentIndex].currentState!.validate()) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  pageController.jumpToPage(currentIndex);
                }
              },
              children: formPages,
            ),
          ),
        ],
      ),
    );
  }
}
