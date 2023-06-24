//import 'dart:convert';
//import 'dart:developer';

class Client {
  final String clientId;
  final String firstName;
  final String lastName;
  final String gender;
  final String address1;
  final String address2;
  final String city;
  final String country;
  final String dob;
  //final String postcode;

  Client({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.address1,
    required this.address2,
    required this.city,
    required this.country,
    required this.dob,
    //required this.postcode,
  });
//constructor to convert json to object instance
  static Client fromJson(Map<Stream, dynamic> json) => Client(
        clientId: json['clientId'] ?? "",
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        gender: json['gender'] ?? "",
        address1: json['address1'] ?? "",
        address2: json['address2'] ?? "",
        city: json['city'] ?? "",
        //   postcode: json['postcode'] ?? "",
        country: json['country'] ?? "",
        dob: json['dob'] ?? "",
      );

  //a method that convert object to Json string

  Map<String, dynamic> toJson() => {
        'clientId': clientId,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'address1': address1,
        'address2': address2,
        'city': city,
        'country': country,
        'dob': dob,
      };

  @override
  String toString() {
    return '{ $firstName, $lastName, $gender $address1, $address2, $city, $clientId ,$dob}';
  }
}




/*

  {"shareId": "9c2f3fbe-5a83-41ad-a154-42241750e6ae", "assetType": "asset type", "assetName": "My Name", "value": 5986, "share": [{"client_name":"John","share_value":60.0}]}

 */