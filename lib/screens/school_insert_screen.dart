import 'dart:convert';

import 'package:acompanhamento_estudantil/models/Address.dart';
import 'package:acompanhamento_estudantil/services/school_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../models/School.dart';
import '../providers/school_provider.dart';
import '../routes/route.dart';

class SchoolInsertScreen extends StatefulWidget {
  const SchoolInsertScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SchoolInsertScreenState();
}

class _SchoolInsertScreenState extends State<SchoolInsertScreen> {
  @override
  void initState() {
    super.initState();
    getLocation().then((value) => _location.text = value);
  }

  List<TextEditingController> _controllers = [TextEditingController()];

  final _name = TextEditingController();
  final _location = TextEditingController();

  removeInput() {
    var count = 1;
    List<TextEditingController> newcontrollers = [];
    _controllers.forEach((element) {
      if (count < _controllers.length) newcontrollers.add(element);

      count++;
    });

    setState(() {
      _controllers = newcontrollers;
    });
  }

  addInput() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SchoolProvider>(context);
    List<Widget> builderInputImageUrl() {
      return _controllers
          .map((controler) => TextField(
                controller: controler,
                decoration: InputDecoration(labelText: "Url Imagem"),
              ))
          .toList();
    }

    void insertSchool() {
      List<String> images = [];
      _controllers.forEach((element) => {images.add(element.text)});

      School newSchoool = School("0", _name.text, [], images, _location.text);

      provider.insert(newSchoool);

      setState(() {
        provider.schools.add(newSchoool);
      });
      Navigator.of(context).pushNamed(Routes.schoolListScreen);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Escola"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _location,
              decoration: InputDecoration(labelText: "Localização"),
            ),
            Column(
              children: builderInputImageUrl(),
            ),
            ListTile(
                leading: IconButton(
                    icon: Icon(Icons.delete), onPressed: () => removeInput()),
                trailing: IconButton(
                    icon: Icon(Icons.add), onPressed: () => addInput())),
            ElevatedButton(
                onPressed: () => insertSchool(), child: const Text("Salvar"))
          ],
        ),
      ),
    );
  }

  Future<String> getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) Future.value("");
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) Future.value("");
    }

    _locationData = await location.getLocation();

    try {
      Map<String, dynamic> json = await SchoolService().getAddress(_locationData.latitude, _locationData.longitude);
      Address modelAdress = Address("", "", "", "", "", "");
      modelAdress.createAdress(json);
      
      return "${modelAdress.street}, ${modelAdress.district}, ${modelAdress.city} - ${modelAdress.uf}, ${modelAdress.postalCode} - ${modelAdress.country}";
    } catch (err) {
      print(err);
    }

     return "${_locationData.latitude} - ${_locationData.longitude}";
  }
}
