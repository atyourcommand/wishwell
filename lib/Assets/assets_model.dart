import 'dart:convert';

class Assets {
  final String id;
  final String assetsType;
  final String assetsName;
  final double value;
  final List<Share> shares;
  //final String postcode;

  Assets({
    required this.value,
    required this.id,
    required this.shares,
    required this.assetsType,
    required this.assetsName,
    //required this.postcode,
  });
//constructor to convert json to object instance

  static Assets fromJson(Map<String, dynamic> json, List<Share> shares) {
    // log(json.toString());
    return Assets(
        id: json["shareId"],
        assetsType: json['assetType'],
        assetsName: json['assetName'],
        shares: shares,
        value: double.parse(json['value']));
  }

  //a method that convert object to Json string

  Map<String, Object> toJson() => {
        'shareId': id,
        'assetType': assetsType,
        'assetName': assetsName,
        'value': value,
        "share": jsonEncode(List<dynamic>.from(shares.map((x) => x.toJson())))
      };

  // @override
  // String toString() {
  //   return '{ $firstName, $lastName, $gender $address1, $address2, $city, $clientId ,$dob}';
  // }
}

class Share {
  Share({
    required this.clientName,
    required this.shareValue,
  });

  String? clientName;
  double shareValue;

  factory Share.fromJson(Map<String, dynamic> json) => Share(
        clientName: json["client_name"],
        shareValue: json["share_value"],
      );

  Map<String, dynamic> toJson() => {
        "client_name": clientName,
        "share_value": shareValue,
      };

  @override
  String toString() => "client => $clientName share => $shareValue";
}
