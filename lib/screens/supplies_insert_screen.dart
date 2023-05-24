import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../models/School.dart';
import '../models/Supplies.dart';
import '../routes/route.dart';
import '../services/school_service.dart';

class SuppliesInsertScreen extends StatefulWidget {
  const SuppliesInsertScreen({super.key});

  @override
  State<SuppliesInsertScreen> createState() => _SuppliesInsertScreenState();
}

class _SuppliesInsertScreenState extends State<SuppliesInsertScreen> {

  final _name = TextEditingController(); 
  final _price = TextEditingController(); 
  final _location = TextEditingController(); 
  final _imageURL = TextEditingController(); 
  final _quant = TextEditingController(); 

   @override
   void initState() {
    super.initState();
    getLocation().then((value) => _location.text = value);
   }

  @override
  Widget build(BuildContext context) {

  School school = ModalRoute.of(context)?.settings.arguments as School;

  void updateSchool(School school, supplie){
      school.supplies.add(
          Supplies("0", _name.text, "teste", double.parse(_price.text), _imageURL.text, int.parse(_quant.text)
        ));
      String teste = jsonEncode(school.toJson());
      print("teste");
      print(teste);
      SchoolService().Update(school.id.toString(), teste);
      Navigator.of(context).pushNamed(Routes.schoolListScreen);
  }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(
                labelText: "Nome"
              ),
            ),
            TextField(
               controller: _price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Preço"
              ),
            ),
            TextField(
               controller: _location,
              decoration: InputDecoration(
                labelText: "Localização"
              ),
            ),
            TextField(
               controller: _imageURL,
              decoration: InputDecoration(
                labelText: "Url Imagem"
              ),
            ),
            TextField(
               controller: _quant,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantidade"
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // SuppliesService().insert(
                //   Supplies("0", _name.text, "teste", double.parse(_price.text), _imageURL.text, int.parse(_quant.text))
                // );
                updateSchool(school, 
                Supplies("0", _name.text, "teste", double.parse(_price.text), _imageURL.text, int.parse(_quant.text)));
                // Navigator.of(context).pushNamed(Routes.suppliesListScreen);
              }, 
              child: const Text("Salvar")
            )
          ],
        ),
      ),
    );
  }
}
Future<String> getLocation() async {
      Location location = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();

      if(!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if(!_serviceEnabled) Future.value("");       
      }

      _permissionGranted = await location.hasPermission();

      if(_permissionGranted == PermissionStatus.denied){
        _permissionGranted = await location.requestPermission();
        if(_permissionGranted != PermissionStatus.granted) Future.value("");
      }
      
      _locationData = await location.getLocation();
      return "${_locationData.latitude} - ${_locationData.longitude}";
}