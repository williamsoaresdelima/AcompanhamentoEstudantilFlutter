import 'package:acompanhamento_estudantil/models/Address.dart';
import 'package:acompanhamento_estudantil/models/School.dart';
import 'package:acompanhamento_estudantil/models/Supplies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Address', () {
    test('"ToJson" do Address', () {
      final address =
          Address('street', 'district', 'city', 'uf', 'country', 'postalCode');
      final map = address.toJson();

      var matcher = {
        'street': 'street',
        'district': 'district',
        'city': 'city',
        'uf': 'uf',
        'country': 'country',
        'postalCode': 'postalCode'
      };
      expect(map, matcher);
    });

    test('"createAdress" do Address', () {
      final address = Address('', '', '', '', '', '');
      var json = {
        'results': [
          {
            'address_components': [
              {'long_name': 'cityCode'},
              {'long_name': 'street'},
              {'long_name': 'district'},
              {'long_name': 'city'},
              {'long_name': 'uf'},
              {'long_name': 'country'},
              {'long_name': 'postalCode'},
            ]
          }
        ]
      };

      address.createAdress(json);
      var matcher = {
        'street': 'street',
        'district': 'district',
        'city': 'city',
        'uf': 'uf',
        'country': 'country',
        'postalCode': 'postalCode'
      };
      var result = address.toJson();
      expect(result, matcher);
    });
  });

  group('School', () {
    test('"ToJson" da School', () {
      List<Supplies> supplies = [];
      supplies.add(Supplies('1', 'name', 'description', 0.0, 'imageUrl', 0));
      List<String> imageUrl = [];
      imageUrl.add('image');
      final school = School('1', 'name', supplies, imageUrl, 'location');

      final map = school.toJson();

      var matcher = {
        'name': 'name',
        'supplies': [
          {
            'name': 'name',
            'description': 'description',
            'price': 0.0,
            'imageUrl': 'imageUrl',
            'quant': 0
          }
        ],
        'imageUrl': ['image'],
        'location': 'location'
      };

      expect(map, matcher);
    });

    test('"fromJson" da School', () {
      var matcher = {
        'name': 'name',
        'supplies': [
          {
            'name': 'name',
            'description': 'description',
            'price': 0.0,
            'imageUrl': 'imageUrl',
            'quant': 0
          }
        ],
        'imageUrl': ['image'],
        'location': 'location'
      };

      final school = School.fromJson('1', matcher);

      var map = school.toJson();
      expect(map, matcher);
    });

    test('"ListSuppliesToJson" da School', () {
      List<Supplies> supplies = [];
      supplies.add(Supplies('1', 'name', 'description', 0.0, 'imageUrl', 0));

      var matcher = [
        {
          'name': 'name',
          'description': 'description',
          'price': 0.0,
          'imageUrl': 'imageUrl',
          'quant': 0
        }
      ];

      final map = School.ListSuppliesToJson(supplies);
      expect(map, matcher);
    });

    test('"listFromJsonImage" da School', () {
      List<dynamic> json = ['1', '2'];
      var matcher = json;
      final map = School.listFromJsonImage(json);
      expect(map, matcher);
    });

    test('"listFromJsonSupplies" da School saida com valores', () {
      List<dynamic> json = [
        {
          'name': 'name1',
          'description': 'description1',
          'price': 0.0,
          'imageUrl': 'imageUrl1',
          'quant': 1
        },
        {
          'name': 'name2',
          'description': 'description2',
          'price': 0.0,
          'imageUrl': 'imageUrl2',
          'quant': 2
        }
      ];

      final map = School.listFromJsonSupplies(json);
      var count = 1;
      map.forEach((element) => {
            expect(element.id, (count - 1).toString()),
            expect(element.name, 'name${count}'),
            expect(element.description, 'description${count}'),
            expect(element.price, 0.0),
            expect(element.imageUrl, 'imageUrl${count}'),
            expect(element.quant, count),
            count++,
          });
    });

    test('"listFromJsonSupplies" da School saida sem valores', () {
      List<dynamic> json = [];
      var matcher = json;
      final map = School.listFromJsonSupplies(json);
      expect(map, matcher);
    });
  });

  group('Supplies', () {
    test('"fromJson" do Supplies', () {
      var supplie = Supplies('0', '', '', 0.0, '', 0);

      var json = {
        'id': '1',
        'name': 'name',
        'description': 'description',
        'price': 2.0,
        'imageUrl': 'imageUrl',
        'quant': 3
      };
      supplie = Supplies.fromJson(json);

      expect(supplie.id, json['id']);
      expect(supplie.name, json['name']);
      expect(supplie.description, json['description']);
      expect(supplie.price, json['price']);
      expect(supplie.imageUrl, json['imageUrl']);
      expect(supplie.quant, json['quant']);
    });

    test('"fromJsonList" do Supplies', () {
      var supplie = Supplies('0', '', '', 0.0, '', 0);
      var id = '1';
      var json = {
        'name': 'name',
        'description': 'description',
        'price': 2.0,
        'imageUrl': 'imageUrl',
        'quant': 3
      };
      supplie = Supplies.fromJsonList(json, id);

      expect(supplie.id, id);
      expect(supplie.name, json['name']);
      expect(supplie.description, json['description']);
      expect(supplie.price, json['price']);
      expect(supplie.imageUrl, json['imageUrl']);
      expect(supplie.quant, json['quant']);
    });

    test('"toJson" do Supplies', () {
      var supplie = Supplies('0', 'name', 'description', 2.0, 'imageUrl', 3);

      var matcher = {
        'name': 'name',
        'description': 'description',
        'price': 2.0,
        'imageUrl': 'imageUrl',
        'quant': 3
      };
      var map = supplie.toJson();
      expect(map, matcher);
    });

    test('"toJsonWithId" do Supplies', () {
      var supplie = Supplies('2', 'name', 'description', 2.0, 'imageUrl', 3);

      var matcher = {
        'id': '2',
        'name': 'name',
        'description': 'description',
        'price': 2.0,
        'imageUrl': 'imageUrl',
        'quant': 3
      };
      var map = supplie.toJsonWithId();
      expect(map, matcher);
    });

    test('"listFromJson" do Supplies', () {
      Map<String, dynamic> matcher = {
      '1': {
        'name': 'name1',
        'description': 'description1',
        'price': 0.0,
        'imageUrl': 'imageUrl1',
        'quant': 1
      },
      '2': {
        'name': 'name2',
        'description': 'description2',
        'price': 0.0,
        'imageUrl': 'imageUrl2',
        'quant': 2
      }
      };
     var map = Supplies.listFromJson(matcher);

      var count = 1;
      map.forEach((element) => {
            expect(element.id, count.toString()),
            expect(element.name, 'name${count}'),
            expect(element.description, 'description${count}'),
            expect(element.price, 0.0),
            expect(element.imageUrl, 'imageUrl${count}'),
            expect(element.quant, count),
            count++,
          });
    });
  });
}
