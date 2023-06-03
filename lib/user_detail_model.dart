class User {
  final String firstName;
  final String lastName;
  final String dob;
  final String gender;
  final String city;
  final String country;
  final String executorFirstName;
  final String executorLastName;
  final String executorAddress1;
  final String executorAddress2;
  final String executorCity;
  final String executorCountry;
  final String executor2FirstName;
  final String executor2LastName;
  final String executor2Address1;
  final String executor2Address2;
  final String executor2City;
  final String executor2Country;
  final String guardianFirstName;
  final String guardianLastName;
  final String guardianAddress1;
  final String guardianAddress2;
  final String guardianCity;
  final String guardianCountry;
  final String guardian2FirstName;
  final String guardian2LastName;
  final String guardian2Address1;
  final String guardian2Address2;
  final String guardian2City;
  final String guardian2Country;
  final String ageOfTrust;
  final String days;
  final bool isCremation;
  final String ashesWish;
  final String burialWish;
  //final String postcode;

  User({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.city,
    required this.country,
    required this.executorFirstName,
    required this.executorLastName,
    required this.executorAddress1,
    required this.executorAddress2,
    required this.executorCity,
    required this.executorCountry,
    required this.executor2FirstName,
    required this.executor2LastName,
    required this.executor2Address1,
    required this.executor2Address2,
    required this.executor2City,
    required this.executor2Country,
    required this.guardianFirstName,
    required this.guardianLastName,
    required this.guardianAddress1,
    required this.guardianAddress2,
    required this.guardianCity,
    required this.guardianCountry,
    required this.guardian2FirstName,
    required this.guardian2LastName,
    required this.guardian2Address1,
    required this.guardian2Address2,
    required this.guardian2City,
    required this.guardian2Country,
    required this.ageOfTrust,
    required this.days,
    required this.isCremation,
    required this.ashesWish,
    required this.burialWish,
    //required this.postcode,
  });
//constructor to convert json to object instance
  static User fromJson(Map<Stream, dynamic> json) => User(
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        dob: json['dob'] ?? "",
        gender: json['gender'] ?? "",
        city: json['city'] ?? "",
        country: json['country'] ?? "",
        executorFirstName: json['executorFirstName'] ?? "",
        executorLastName: json['executorLastName'] ?? "",
        executorAddress1: json['executorAddress1'] ?? "",
        executorAddress2: json['executorAddress2'] ?? "",
        executorCity: json['executorCity'] ?? "",
        executorCountry: json['executorCountry'] ?? "",
        executor2FirstName: json['executor2FirstName'] ?? "",
        executor2LastName: json['executor2LastName'] ?? "",
        executor2Address1: json['executor2Address1'] ?? "",
        executor2Address2: json['executor2Address2'] ?? "",
        executor2City: json['executor2City'] ?? "",
        executor2Country: json['executor2Country'] ?? "",
        guardianFirstName: json['guardianFirstName'] ?? "",
        guardianLastName: json['guardianLastName'] ?? "",
        guardianAddress1: json['guardianAddress1'] ?? "",
        guardianAddress2: json['guardianAddress2'] ?? "",
        guardianCity: json['guardianCity'] ?? "",
        guardianCountry: json['guardianCountry'] ?? "",
        guardian2FirstName: json['guardian2FirstName'] ?? "",
        guardian2LastName: json['guardian2LastName'] ?? "",
        guardian2Address1: json['guardian2Address1'] ?? "",
        guardian2Address2: json['guardian2Address2'] ?? "",
        guardian2City: json['guardian2City'] ?? "",
        guardian2Country: json['guardian2Country'] ?? "",
        ageOfTrust: json['ageOfTrust'] ?? "",
        days: json['days'] ?? "",
        isCremation: json['isCremation'] ?? "",
        ashesWish: json['ashesWish'] ?? "",
        burialWish: json['burialWish'] ?? "",

        // clientId: json['clientId'] ?? "",
        // firstName: json['firstName'] ?? "",
        // lastName: json['lastName'] ?? "",
        // gender: json['gender'] ?? "",
        // address1: json['address1'] ?? "",
        // address2: json['address2'] ?? "",
        // city: json['city'] ?? "",
        // //   postcode: json['postcode'] ?? "",
        // country: json['country'] ?? "",
        // dob: json['dob'] ?? "",
      );

  //a method that convert object to Json string

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'dob': dob,
        'gender': gender,
        'city': city,
        'country': country,
        'executorFirstName': executorFirstName,
        'executorLastName': executorLastName,
        'executorAddress1': executorAddress1,
        'executorAddress2': executorAddress2,
        'executorCity': executorCity,
        'executorCountry': executorCountry,
        'executor2FirstName': executor2FirstName,
        'executor2LastName': executor2LastName,
        'executor2Address1': executor2Address1,
        'executor2Address2': executor2Address2,
        'executor2City': executor2City,
        'executor2Country': executor2Country,
        'guardianFirstName': guardianFirstName,
        'guardianLastName': guardianLastName,
        'guardianAddress1': guardianAddress1,
        'guardianAddress2': guardianAddress2,
        'guardianCity': guardianCity,
        'guardianCountry': guardianCountry,
        'guardian2FirstName': guardian2FirstName,
        'guardian2LastName': guardian2LastName,
        'guardian2Address1': guardian2Address1,
        'guardian2Address2': guardian2Address2,
        'guardian2City': guardian2City,
        'guardian2Country': guardian2Country,
        'ageOfTrust': ageOfTrust,
        'days': days,
        'isCremation': isCremation,
        'ashesWish': ashesWish,
        'burialWish': burialWish,
        // 'clientId': clientId,
        // 'firstName': firstName,
        // 'lastName': lastName,
        // 'gender': gender,
        // 'address1': address1,
        // 'address2': address2,
        // 'city': city,
        // 'country': country,
        // 'dob': dob,
      };

  @override
  String toString() {
    return '{ $firstName,$lastName,$dob,$gender,$city,$country,$executorFirstName,$executorLastName,$executorAddress1,$executorAddress2,$executorCity,$executorCountry,$executor2FirstName,$executor2LastName,$executor2Address1,$executor2Address2,$executor2City,$executor2Country,$guardianFirstName,$guardianLastName,$guardianAddress1,$guardianAddress2,$guardianCity,$guardianCountry,$guardian2FirstName,$guardian2LastName,$guardian2Address1,$guardian2Address2,$guardian2City,$guardian2Country,$ageOfTrust,$days,$isCremation,$ashesWish,$burialWish,}';
  }
}
