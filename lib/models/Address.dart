import 'dart:convert';

class Address {
  String street;
  String district;
  String city;
  String uf;
  String country;
  String postalCode;

  Address(
    this.street,
    this.district,
    this.city,
    this.uf,
    this.country,
    this.postalCode,
  );

  Map<String, dynamic> toJson() => {
        'street': street,
        'district': district,
        'city': city,
        'uf': uf,
        'country': country,
        'postalCode': postalCode,
      };

  createAdress(Map<String, dynamic> json) {
    dynamic listDynamic = json["results"][0];
    List<dynamic> listDynamic2 = listDynamic["address_components"];
    var count = 0;
    listDynamic2.forEach((val) => {
          if (count == 1) street = val["long_name"],
          if (count == 2) district = val["long_name"],
          if (count == 3) city = val["long_name"],
          if (count == 4) uf = val["long_name"],
          if (count == 5) country = val["long_name"],
          if (count == 6) postalCode = val["long_name"],
          count++
        });
  }
}
