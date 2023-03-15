class Client {
  final String firstName;
  final String lastName;
  final String clientId;
  final String dob;
  final String address1;
  final String address2;
  final String city;
  final String postcode;
  final String country;

  const Client({
    required this.firstName,
    required this.lastName,
    required this.clientId,
    required this.dob,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
  });

  static Client fromJson(json) => Client(
        firstName: json['firstName'],
        lastName: json['lastName'],
        clientId: json['clientId'],
        dob: json['dob'],
        address1: json['address1'],
        address2: json['address2'],
        city: json['city'],
        postcode: json['postcode'],
        country: json['country'],
      );
}

class Server {
  final String name;
  final String countryCode;
  final String serverProtocol;

  const Server({
    required this.name,
    required this.countryCode,
    required this.serverProtocol,
  });

  static Server fromJson(json) => Server(
        name: json['name'],
        countryCode: json['countryCode'],
        serverProtocol: json['serverProtocol'],
      );
}
